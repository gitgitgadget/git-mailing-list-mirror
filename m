From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] t4052: unset $COLUMNS inherited from environment
Date: Tue, 27 Mar 2012 07:32:41 +0200
Message-ID: <4F7150F9.50806@viscovery.net>
References: <20120326234549.GA10172@sigill.intra.peff.net> <1332825003-2288-1-git-send-email-zbyszek@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
	Michael J Gruber <git@drmicha.warpmail.net>,
	pclouds@gmail.com
To: =?UTF-8?B?WmJpZ25pZXcgSsSZZHJ6ZWpld3NraS1Tem1law==?= 
	<zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Tue Mar 27 07:32:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCP1a-0006d7-65
	for gcvg-git-2@plane.gmane.org; Tue, 27 Mar 2012 07:32:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755476Ab2C0Fct convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Mar 2012 01:32:49 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:34836 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751365Ab2C0Fct convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Mar 2012 01:32:49 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.76)
	(envelope-from <j.sixt@viscovery.net>)
	id 1SCP1O-0005iy-Oj; Tue, 27 Mar 2012 07:32:43 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 54D521660F;
	Tue, 27 Mar 2012 07:32:42 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:11.0) Gecko/20120312 Thunderbird/11.0
In-Reply-To: <1332825003-2288-1-git-send-email-zbyszek@in.waw.pl>
X-Enigmail-Version: 1.4
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194011>

Am 3/27/2012 7:10, schrieb Zbigniew J=C4=99drzejewski-Szmek:
> diff --git a/t/t4052-stat-output.sh b/t/t4052-stat-output.sh
> index 328aa8f..1f47f1d 100755
> --- a/t/t4052-stat-output.sh
> +++ b/t/t4052-stat-output.sh
> @@ -17,6 +17,7 @@ test_expect_success 'preparation' '
>  	git commit -m message &&
>  	echo a >"$name" &&
>  	git commit -m message "$name"
> +	sane_unset COLUMNS
>  '

Watch out, the && chain is broken here.

-- Hannes
