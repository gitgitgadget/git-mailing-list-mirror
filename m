From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: make test
Date: Mon, 15 Oct 2012 13:18:02 +0200
Message-ID: <507BF0EA.7000805@viscovery.net>
References: <k5gov5$fe1$1@ger.gmane.org> <507BEB12.9040101@viscovery.net> <003101cdaac4$430b7a30$c9226e90$@schmitz-digital.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Joachim Schmitz <jojo@schmitz-digital.de>
X-From: git-owner@vger.kernel.org Mon Oct 15 13:18:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNigd-0004QP-Io
	for gcvg-git-2@plane.gmane.org; Mon, 15 Oct 2012 13:18:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752221Ab2JOLSH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2012 07:18:07 -0400
Received: from so.liwest.at ([212.33.55.24]:13899 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752199Ab2JOLSG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2012 07:18:06 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1TNigN-00034U-Aa; Mon, 15 Oct 2012 13:18:03 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 038451660F;
	Mon, 15 Oct 2012 13:18:02 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:16.0) Gecko/20121010 Thunderbird/16.0.1
In-Reply-To: <003101cdaac4$430b7a30$c9226e90$@schmitz-digital.de>
X-Enigmail-Version: 1.4.5
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207736>

Am 10/15/2012 13:00, schrieb Joachim Schmitz:
>> From: Johannes Sixt [mailto:j.sixt@viscovery.net]
>> and if that does not give sufficient clues,
>>
>>   $SHELL_PATH -x ./t0000-basic.sh -v -i
> 
> not ok - 12 tests clean up even on failures
> #...
> + die
> 
> Looks identical, except for the "die" at the end. And still leaves me without a clue...

When I do that it begins like this (I'm on Windows):

D:\Src\mingw-git\t>bash -x t0000-basic.sh -v -i
+ test_description='Test the very basics part #1.
...
'
+ . ./test-lib.sh
++ ORIGINAL_TERM=cygwin
++ test -z ''
+++ pwd
++ TEST_DIRECTORY=/d/Src/mingw-git/t
++ test -z ''
++ TEST_OUTPUT_DIRECTORY=/d/Src/mingw-git/t
++ GIT_BUILD_DIR=/d/Src/mingw-git/t/..
++ /d/Src/mingw-git/t/../git
++ test 1 '!=' 1
++ . /d/Src/mingw-git/t/../GIT-BUILD-OPTIONS
+++ SHELL_PATH=/bin/sh
+++ PERL_PATH=/usr/bin/perl
+++ DIFF=diff
+++ PYTHON_PATH=/usr/bin/python
+++ TAR=tar
...

It seems you need a shell that is verbose under -x.

-- Hannes
