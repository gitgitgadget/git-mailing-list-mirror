From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH] t0050: fix printf format strings for portability
Date: Tue, 28 Dec 2010 18:05:56 +0000
Message-ID: <4D1A2704.8020500@ramsay1.demon.co.uk>
References: <4D1105B5.5070703@ramsay1.demon.co.uk> <20101221202755.GA27214@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: prohaska@zib.de, Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>, trast@student.ethz.ch
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 28 19:13:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PXe2e-0005ew-Em
	for gcvg-git-2@lo.gmane.org; Tue, 28 Dec 2010 19:13:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751883Ab0L1SMs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Dec 2010 13:12:48 -0500
Received: from lon1-post-1.mail.demon.net ([195.173.77.148]:34520 "EHLO
	lon1-post-1.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751524Ab0L1SMs (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Dec 2010 13:12:48 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-1.mail.demon.net with esmtp (Exim 4.69)
	id 1PXe2Q-0001Ud-YS; Tue, 28 Dec 2010 18:12:47 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <20101221202755.GA27214@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164282>

Jonathan Nieder wrote:
> diff --git a/t/t0050-filesystem.sh b/t/t0050-filesystem.sh
> index 057c97c..1542cf6 100755
> --- a/t/t0050-filesystem.sh
> +++ b/t/t0050-filesystem.sh
> @@ -4,8 +4,8 @@ test_description='Various filesystem issues'
>  
>  . ./test-lib.sh
>  
> -auml=`printf '\xc3\xa4'`
> -aumlcdiar=`printf '\x61\xcc\x88'`
> +auml=$(printf '\303\244')
> +aumlcdiar=$(printf '\141\314\210')
>  
>  case_insensitive=
>  unibad=

Thanks everyone (Jonathan, Junio and Thomas) for the quick reply and fix!
[I should have figured it out myself, but I just couldn't imagine printf
not supporting hex escapes! :-P ]

ATB,
Ramsay Jones
