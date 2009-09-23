From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 0/3] Add a pretty format to rewrapping/indenting commit
 messages
Date: Wed, 23 Sep 2009 22:34:38 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0909232232050.4985@pacific.mpi-cbg.de>
References: <7vfxaercma.fsf@alter.siamese.dyndns.org> <1253655038-20335-1-git-send-email-heipei@hackvalue.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Gilger <heipei@hackvalue.de>,
	Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 23 22:32:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MqYW5-0007G4-Lf
	for gcvg-git-2@lo.gmane.org; Wed, 23 Sep 2009 22:32:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751482AbZIWUcg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Sep 2009 16:32:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751463AbZIWUcf
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Sep 2009 16:32:35 -0400
Received: from mail.gmx.net ([213.165.64.20]:39936 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751289AbZIWUcf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Sep 2009 16:32:35 -0400
Received: (qmail invoked by alias); 23 Sep 2009 20:32:37 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp019) with SMTP; 23 Sep 2009 22:32:37 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18JSE8lyP4JWMz549HwwgEr+AnWuRrjwrr4TI6IOp
	j9OXPk6aTxStIe
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1253655038-20335-1-git-send-email-heipei@hackvalue.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128994>


I needed that a long time ago, so I implemented it and let it rut in my
personal tree.

Maybe somebody else wants to benefit from my work, too.

Johannes Schindelin (3):
  print_wrapped_text(): allow hard newlines
  Add strbuf_add_wrapped_text() to utf8.[ch]
  Add "%w" to pretty formats, which rewraps the commit message

 Documentation/pretty-formats.txt |    1 +
 pretty.c                         |   27 ++++++++++++++++++++++
 utf8.c                           |   45 ++++++++++++++++++++++++++++++-------
 utf8.h                           |    2 +
 4 files changed, 66 insertions(+), 9 deletions(-)
