From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH 4/2] test: use test_must_contain
Date: Sat, 21 Nov 2015 02:16:43 +0100
Message-ID: <1448068603-2112-1-git-send-email-szeder@ira.uka.de>
References: <564F878B.3090508@web.de>
Cc: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Sat Nov 21 02:18:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZzwoR-0002YN-3v
	for gcvg-git-2@plane.gmane.org; Sat, 21 Nov 2015 02:17:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760758AbbKUBRY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Nov 2015 20:17:24 -0500
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:58753 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759759AbbKUBRX (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Nov 2015 20:17:23 -0500
Received: from x590cde9d.dyn.telefonica.de ([89.12.222.157] helo=localhost.localdomain)
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 25 
	iface 141.3.10.81 id 1Zzwnl-0004z5-E6; Sat, 21 Nov 2015 02:17:18 +0100
X-Mailer: git-send-email 2.6.3.398.g4ce1eda
In-Reply-To: <564F878B.3090508@web.de>
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1448068638.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281540>

Hi,

> diff --git a/t/t9810-git-p4-rcs.sh b/t/t9810-git-p4-rcs.sh
> index 8134ab4..e02b490 100755
> --- a/t/t9810-git-p4-rcs.sh
> +++ b/t/t9810-git-p4-rcs.sh
> @@ -294,8 +294,7 @@ test_expect_success 'cope with rcs keyword file deletion' '
>  		echo "\$Revision\$" >kwdelfile.c &&
>  		p4 add -t ktext kwdelfile.c &&
>  		p4 submit -d "Add file to be deleted" &&
> -		cat kwdelfile.c &&
> -		grep 1 kwdelfile.c
> +		test_must_constain 1 kwdelfile.c

s/constain/contain/
