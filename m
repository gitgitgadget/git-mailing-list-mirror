From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 0/4]  misc. MSVC patches
Date: Wed, 23 Jun 2010 20:36:17 +0100
Message-ID: <4C226231.40102@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 23 21:51:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORVyg-0008LG-8n
	for gcvg-git-2@lo.gmane.org; Wed, 23 Jun 2010 21:51:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752983Ab0FWTvN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jun 2010 15:51:13 -0400
Received: from anchor-post-2.mail.demon.net ([195.173.77.133]:48127 "EHLO
	anchor-post-2.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751458Ab0FWTvM (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Jun 2010 15:51:12 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-2.mail.demon.net with esmtp (Exim 4.69)
	id 1ORVyZ-0000gp-jQ; Wed, 23 Jun 2010 19:51:11 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149539>

Hi Junio,

I have been spring cleaning my branches and found these MSVC patches
down the back of the sofa. ;-)

Nothing very exciting, but I thought I would pass them on anyway.

The second patch may improve SHA1 performance slightly, but I have
not timed it.

I think some variant of the final patch has been seen on the list
before and was not applied; I don't remember much discussion, so
I don't recall if or why it was rejected...

Ramsay Jones (4):
  msvc: Fix some "expr evaluates to function" compiler warnings
  msvc: Select the "fast" definition of the {get,put}_be32() macros
  msvc: Fix some compiler warnings
  Makefile: Don't pass $(ALL_CFLAGS) to the linker

 Makefile          |   14 +++++++-------
 block-sha1/sha1.c |    9 +++++----
 builtin.h         |    4 ++--
 builtin/notes.c   |    2 +-
 notes.h           |    4 ++--
 5 files changed, 17 insertions(+), 16 deletions(-)


ATB,
Ramsay Jones
