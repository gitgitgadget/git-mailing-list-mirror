From: =?UTF-8?B?WmJpZ25pZXcgSsSZZHJ6ZWpld3NraS1Tem1law==?= 
	<zbyszek@in.waw.pl>
Subject: problem with git grep -P
Date: Wed, 15 Feb 2012 14:15:00 +0100
Message-ID: <4F3BAFD4.7080209@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?B?TWljaGHFgiBLaWVkcm93aWN6?= <michal.kiedrowicz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 15 14:15:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rxehj-0003vZ-Jr
	for gcvg-git-2@plane.gmane.org; Wed, 15 Feb 2012 14:15:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758256Ab2BONPY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Feb 2012 08:15:24 -0500
Received: from kawka.in.waw.pl ([178.63.212.103]:52644 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756094Ab2BONPK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Feb 2012 08:15:10 -0500
Received: from [193.0.104.42]
	by kawka.in.waw.pl with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1RxehP-00016h-Sc; Wed, 15 Feb 2012 14:15:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:8.0) Gecko/20120104 Icedove/8.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190830>

Hi,
I'm not getting output from git grep -P. Simplified test case:

$ git grep -P '^ ' t/t4012-diff-binary.sh
(nothing)

$ git grep -E '^ ' t/t4012-diff-binary.sh
t/t4012-diff-binary.sh: a |    2 +-
t/t4012-diff-binary.sh: b |  Bin
t/t4012-diff-binary.sh: c |    2 +-
t/t4012-diff-binary.sh: d |  Bin
t/t4012-diff-binary.sh: 4 files changed, 2 insertions(+), 2 deletions(-)
t/t4012-diff-binary.sh: binfile  |   Bin 0 -> 1026 bytes
t/t4012-diff-binary.sh: textfile | 10000 +++++++++++++++++++++++++++++++

I would expect -P to give the same results as -E.

Am I missing something special about pcre?

$ git --version
git version 1.7.9.5.g1210a
(AFAICT this hasn't changed since grep -P was merged)

I have libpcre3 8.12-4 from debian.

--
Zbyszek
