From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Patches for test suite on sunos
Date: Tue, 22 Jul 2008 16:15:17 -0500
Message-ID: <xBk5x6Gn4j_BxeOlNdnKZYx9EVCDUf3daWtIO2qp-b8jRKgjlQ8spQ@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 22 23:17:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLPEl-0007b1-Au
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 23:17:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756798AbYGVVPz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 17:15:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756808AbYGVVPz
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 17:15:55 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:53998 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756798AbYGVVPy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 17:15:54 -0400
Received: by mail.nrlssc.navy.mil id m6MLFHcZ020338; Tue, 22 Jul 2008 16:15:17 -0500
X-OriginalArrivalTime: 22 Jul 2008 21:15:17.0859 (UTC) FILETIME=[0A84B330:01C8EC40]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89532>


The following set of patches is a subset of patches I created
while trying to compile on solaris and get the test suite running.
Except for the patches to the perl modules section, the rest all
deal with the test suite. I think these are general improvements
(or benign changes) and so I am submitting them.

With these patches and the others which I will maintain privately,
I can compile git on solaris using the native c compiler and pass
nearly all of the test suite with the native shell in /usr/xpg4/bin/sh
(i.e. ksh). The remaining bits of the test suite that do not pass are
related to a broken iconv or an ancient build environment.

Here are the tests I am skipping:

GIT_SKIP_TESTS='
   t3900.1[0-289] t3900.2[023]
   t3901.*
   t5000.1[0-24-689] t5000.2[01]
   t5100.[56] t5100.10
   t6030.1[2-9] t6030.2[0-9]
   t9301.4
'

-brandon
