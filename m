From: Don Slutz <Don.Slutz@SierraAtlantic.com>
Subject: Re: Tests in Cygwin
Date: Thu, 07 May 2009 14:29:34 -0400
Message-ID: <4A03288E.7010405@SierraAtlantic.com>
References: <83prfbhasp.fsf@kalahari.s2.org>	<4A01E64C.7050703@SierraAtlantic.com> <7vvdoet13g.fsf@alter.siamese.dyndns.org> <4A028A0A.5070003@viscovery.net> <4A030277.2000708@SierraAtlantic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>,
	Hannu Koivisto <azure@iki.fi>, git@vger.kernel.org
To: Don Slutz <Don.Slutz@sierraatlantic.com>
X-From: git-owner@vger.kernel.org Thu May 07 20:29:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M28Lr-0007qF-TT
	for gcvg-git-2@gmane.org; Thu, 07 May 2009 20:29:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752498AbZEGS3j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2009 14:29:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751684AbZEGS3j
	(ORCPT <rfc822;git-outgoing>); Thu, 7 May 2009 14:29:39 -0400
Received: from mail201.messagelabs.com ([216.82.254.211]:30451 "HELO
	mail201.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751251AbZEGS3j (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2009 14:29:39 -0400
X-VirusChecked: Checked
X-Env-Sender: Don.Slutz@SierraAtlantic.com
X-Msg-Ref: server-5.tower-201.messagelabs.com!1241720979!33907834!1
X-StarScan-Version: 6.0.0; banners=sierraatlantic.com,-,-
X-Originating-IP: [206.86.29.5]
Received: (qmail 13621 invoked from network); 7 May 2009 18:29:39 -0000
Received: from seng.sierraatl.com (HELO USFREEX1.us.corp.sa) (206.86.29.5)
  by server-5.tower-201.messagelabs.com with SMTP; 7 May 2009 18:29:39 -0000
Received: from usbosex1.us.corp.sa ([192.168.17.34]) by USFREEX1.us.corp.sa with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 7 May 2009 11:29:39 -0700
Received: from [127.0.0.1] ([208.37.241.146]) by usbosex1.us.corp.sa with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 7 May 2009 14:29:37 -0400
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <4A030277.2000708@SierraAtlantic.com>
X-OriginalArrivalTime: 07 May 2009 18:29:37.0491 (UTC) FILETIME=[C6FAAA30:01C9CF41]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118502>

Before these patches, I get:

make aggregate-results
make[3]: Entering directory `/home/adslutz/BinMode/git/t'
'/bin/sh' ./aggregate-results.sh test-results/t*-*
fixed   3
success 4201
failed  15
broken  5
total   4272
make[3]: Leaving directory `/home/adslutz/BinMode/git/t'

After:

make aggregate-results
make[2]: Entering directory `/home/adslutz/BinMode/git/t'
'/bin/sh' ./aggregate-results.sh test-results/t*-*
fixed   3
success 4181
failed  6
broken  5
total   4274
make[2]: Leaving directory `/home/adslutz/BinMode/git/t'

   -Don

-------- Original Message --------
Subject: Re: Tests in Cygwin
From: Don Slutz <Don.Slutz@sierraatlantic.com>
To: Johannes Sixt <j.sixt@viscovery.net>
CC: Junio C Hamano <gitster@pobox.com>, Hannu Koivisto <azure@iki.fi>, 
git@vger.kernel.org
Date: 5/7/2009 11:47 AM
> Here is a change back to using spaces.  It also includes a change
> to test for the code working.  Squash on top.
>
> Signed-off-by: Don Slutz <Don.Slutz@SierraAtlantic.com>
> ---
> t/README                    |    4 ++--
> t/t0000-basic.sh            |   13 ++++++++++++-
> t/t1004-read-tree-m-u-wf.sh |    2 +-
> t/test-lib.sh               |    7 +------
> 4 files changed, 16 insertions(+), 10 deletions(-)
>
> diff --git a/t/README b/t/README
> index 49c3a51..c61e1d4 100644
> --- a/t/README
> +++ b/t/README
> @@ -200,9 +200,9 @@ library for your script to use.
>    <script>.  If it yields success, test is considered
>    successful.  <message> should state what it is testing.
>
> -   An optional parameter <prereq> is a '+' separated list of 
> prerequisite
> +   An optional parameter <prereq> is a space separated list of 
> prerequisite
>    tokens.  The test will be skipped if the test environment lacks any of
> -   the prerequiste feature listed (see below for commonly used
> +   the prerequisite feature listed (see below for commonly used
>    prerequisites).
>
>    Example:
> diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
> index f4ca4fc..58bac69 100755
> --- a/t/t0000-basic.sh
> +++ b/t/t0000-basic.sh
> @@ -67,7 +67,18 @@ donthaveit=yes
> test_expect_success DONTHAVEIT 'unmet prerequisite causes test to be 
> skipped' '
>     donthaveit=no
> '
> -if test $haveit$donthaveit != yesyes
> +test_set_prereq HAVEBOTH
> +haveboth1=no
> +test_expect_success 'HAVEBOTH HAVEIT' 'test runs if both 
> prerequisites are satisfied' '
> +    test_have_prereq "HAVEIT HAVEBOTH" &&
> +    haveboth1=yes
> +'
> +haveboth2=no
> +test_expect_success 'HAVEIT HAVEBOTH' 'test passes if both 
> prerequisites are satisfied' '
> +    test_have_prereq "HAVEBOTH HAVEIT" &&
> +    haveboth2=yes
> +'
> +if test $haveit$donthaveit$haveboth1$haveboth2 != yesyesyesyes
> then
>        say "bug in test framework: prerequisite tags do not work 
> reliably"
>        exit 1
> diff --git a/t/t1004-read-tree-m-u-wf.sh b/t/t1004-read-tree-m-u-wf.sh
> index 8683189..eb60f80 100755
> --- a/t/t1004-read-tree-m-u-wf.sh
> +++ b/t/t1004-read-tree-m-u-wf.sh
> @@ -177,7 +177,7 @@ test_expect_success SYMLINKS 'funny symlink in 
> work tree' '
>
> '
>
> -test_expect_success SYMLINKS+SANITY 'funny symlink in work tree, 
> un-unlink-able' '
> +test_expect_success 'SYMLINKS SANITY' 'funny symlink in work tree, 
> un-unlink-able' '
>
>        rm -fr a b &&
>        git reset --hard &&
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 2d12799..dd3b8d7 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -263,13 +263,8 @@ test_set_prereq () {
> }
> satisfied=" "
>
> -# prerequisites can be concatenated with '+'
> test_have_prereq () {
> -       save_IFS=$IFS
> -       IFS=+
> -       set -- $*
> -       IFS=$save_IFS
> -       for prerequisite
> +       for prerequisite in $(echo $*)
>        do
>                case $satisfied in
>                *" $prerequisite "*)



__________________________________________________________________________________________________________________
DISCLAIMER:"The information contained in this message and the attachments (if any) may be privileged and confidential and protected from disclosure. You are hereby notified that any unauthorized use, dissemination, distribution or copying of this communication, review, retransmission, or taking of any action based upon this information, by persons or entities other than the intended recipient, is strictly prohibited. If you are not the intended recipient or an employee or agent responsible for delivering this message, and have received this communication in error, please notify us immediately by replying to the message and kindly delete the original message, attachments, if any, and all its copies from your computer system. Thank you for your cooperation." 
________________________________________________________________________________________________________________
