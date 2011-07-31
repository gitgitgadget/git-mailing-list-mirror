From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCHv2 2/4] git-p4: add missing && in test
Date: Sun, 31 Jul 2011 14:55:11 +0100
Message-ID: <4E355EBF.2070400@diamand.org>
References: <20110731003557.GA4867@arf.padd.com> <20110731134416.GB6564@arf.padd.com> <20110731134517.GD6564@arf.padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Sun Jul 31 15:55:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnWUC-0000dA-DE
	for gcvg-git-2@lo.gmane.org; Sun, 31 Jul 2011 15:55:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751631Ab1GaNzQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jul 2011 09:55:16 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:60797 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751608Ab1GaNzP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jul 2011 09:55:15 -0400
Received: by wyg8 with SMTP id 8so1055088wyg.19
        for <git@vger.kernel.org>; Sun, 31 Jul 2011 06:55:14 -0700 (PDT)
Received: by 10.227.183.137 with SMTP id cg9mr5161293wbb.2.1312120513879;
        Sun, 31 Jul 2011 06:55:13 -0700 (PDT)
Received: from [86.30.143.167] (cpc4-cmbg14-2-0-cust166.5-4.cable.virginmedia.com [86.30.143.167])
        by mx.google.com with ESMTPS id g48sm2691968wee.13.2011.07.31.06.55.12
        (version=SSLv3 cipher=OTHER);
        Sun, 31 Jul 2011 06:55:13 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110402 Iceowl/1.0b2 Icedove/3.1.9
In-Reply-To: <20110731134517.GD6564@arf.padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178258>

Acked.



On 31/07/11 14:45, Pete Wyckoff wrote:
> Signed-off-by: Pete Wyckoff<pw@padd.com>
> ---
>   t/t9800-git-p4.sh |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/t/t9800-git-p4.sh b/t/t9800-git-p4.sh
> index aec3ba1..b7eda82 100755
> --- a/t/t9800-git-p4.sh
> +++ b/t/t9800-git-p4.sh
> @@ -202,7 +202,7 @@ test_expect_success 'preserve user where author is unknown to p4' '
>   	"$GITP4" clone --dest="$git" //depot&&
>   	test_when_finished cleanup_git&&
>   	cd "$git"&&
> -	git config git-p4.skipSubmitEditCheck true
> +	git config git-p4.skipSubmitEditCheck true&&
>   	echo "username-bob: a change by bob">>  file1&&
>   	git commit --author "Bob<bob@localhost>" -m "preserve: a change by bob" file1&&
>   	echo "username-unknown: a change by charlie">>  file1&&
