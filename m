From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH v2 0/2] Remove the CYGWIN_V15_WIN32API build variable
Date: Thu, 02 May 2013 20:23:53 +0100
Message-ID: <5182BD49.1070603@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>, mlevedahl@gmail.com,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 02 21:39:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXzLd-0003lj-Vp
	for gcvg-git-2@plane.gmane.org; Thu, 02 May 2013 21:39:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932671Ab3EBTjS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 May 2013 15:39:18 -0400
Received: from mdfmta010.mxout.tch.inty.net ([91.221.169.51]:35169 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751974Ab3EBTjQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 May 2013 15:39:16 -0400
Received: from smtp.demon.co.uk (unknown [127.0.0.1])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mdfmta010.tch.inty.net (Postfix) with ESMTP id 7416B400681
	for <git@vger.kernel.org>; Thu,  2 May 2013 20:32:17 +0100 (BST)
Received: from mdfmta004.tch.inty.net (unknown [127.0.0.1])
	by mdfmta004.tch.inty.net (Postfix) with ESMTP id B5A76AC421B;
	Thu,  2 May 2013 20:31:36 +0100 (BST)
Received: from mdfmta004.tch.inty.net (unknown [127.0.0.1])
	by mdfmta004.tch.inty.net (Postfix) with ESMTP id 227EAAC420C;
	Thu,  2 May 2013 20:31:36 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])
	by mdfmta004.tch.inty.net (Postfix) with ESMTP;
	Thu,  2 May 2013 20:31:35 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
X-MDF-HostID: 17
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223252>


Hi Junio,

Version 2 changes:

   - minor edit to commit message to Patch #1
     (s.%s/NATIVE_WINDOWS/.%s/WINDOWS_NATIVE/.) ;-)

   - add some additional explanation to commit message
     of Patch #2.

Note: Since I don't have a commit ID for the first patch,
I didn't know how to refer to it in the second patch.

ATB,
Ramsay Jones

Jonathan Nieder (1):
  mingw: rename WIN32 cpp macro to GIT_WINDOWS_NATIVE

Ramsay Allan Jones (1):
  cygwin: Remove the CYGWIN_V15_WIN32API build variable

 Makefile          |  7 -------
 abspath.c         |  2 +-
 compat/cygwin.c   |  5 -----
 compat/terminal.c |  4 ++--
 compat/win32.h    |  2 +-
 config.mak.uname  |  1 -
 diff-no-index.c   |  2 +-
 git-compat-util.h |  3 ++-
 help.c            |  2 +-
 run-command.c     | 10 +++++-----
 test-chmtime.c    |  2 +-
 thread-utils.c    |  2 +-
 12 files changed, 15 insertions(+), 27 deletions(-)

-- 
1.8.2
