From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 0/2] Remote helper for p4
Date: Wed, 5 Aug 2009 01:02:27 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0908050056280.2147@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 05 07:02:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYYeD-0007Gg-Bk
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 07:02:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933097AbZHEFCf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 01:02:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933321AbZHEFCe
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 01:02:34 -0400
Received: from iabervon.org ([66.92.72.58]:37033 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933097AbZHEFC2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 01:02:28 -0400
Received: (qmail 18341 invoked by uid 1000); 5 Aug 2009 05:02:27 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 5 Aug 2009 05:02:27 -0000
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124857>

This series implements a client-side helper for p4, with the ability
to import projects with smallish history structure and export simple
history on good days.

Mostly, it serves as a second example of a foreign helper, with an RFC
version of the "export" command.

Daniel Barkalow (2):
  Add push by "export"
  Implement git-vcs-p4

 Documentation/git-remote-helpers.txt |   33 +
 Documentation/git-vcs-p4.txt         |   47 ++
 Makefile                             |   23 +
 transport-helper.c                   |   62 ++
 vcs-p4/p4client-api.cc               |  455 ++++++++++++
 vcs-p4/p4client.c                    |  158 +++++
 vcs-p4/p4client.h                    |   74 ++
 vcs-p4/vcs-p4.c                      | 1250 ++++++++++++++++++++++++++++++++++
 vcs-p4/vcs-p4.h                      |  135 ++++
 9 files changed, 2237 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/git-vcs-p4.txt
 create mode 100644 vcs-p4/p4client-api.cc
 create mode 100644 vcs-p4/p4client.c
 create mode 100644 vcs-p4/p4client.h
 create mode 100644 vcs-p4/vcs-p4.c
 create mode 100644 vcs-p4/vcs-p4.h
