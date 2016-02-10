From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v2] config: add '--sources' option to print the source of
 a config value
Date: Wed, 10 Feb 2016 12:47:19 +0000
Message-ID: <56BB3157.7080307@ramsayjones.plus.com>
References: <1455099198-11515-1-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: sschuberth@gmail.com, peff@peff.net
To: larsxschneider@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 10 13:47:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTUB5-0007xm-PO
	for gcvg-git-2@plane.gmane.org; Wed, 10 Feb 2016 13:47:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750911AbcBJMrX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Feb 2016 07:47:23 -0500
Received: from avasout07.plus.net ([84.93.230.235]:34382 "EHLO
	avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750825AbcBJMrX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Feb 2016 07:47:23 -0500
Received: from [10.0.2.15] ([46.208.159.221])
	by avasout07 with smtp
	id GcnK1s00A4mu3xa01cnLiE; Wed, 10 Feb 2016 12:47:21 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=QqujpgGd c=1 sm=1 tr=0
 a=Sp5fw55EgyGSOjouSGNDoQ==:117 a=Sp5fw55EgyGSOjouSGNDoQ==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=N659UExz7-8A:10
 a=pGLkceISAAAA:8 a=PKzvZo6CAAAA:8 a=n8t0vtEh2yhArY8xrwUA:9 a=pILNOxqGKmIA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
In-Reply-To: <1455099198-11515-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285896>



On 10/02/16 10:13, larsxschneider@gmail.com wrote:
> From: Lars Schneider <larsxschneider@gmail.com>
> 
> If config values are queried using 'git config' (e.g. via '--list' flag
> or the '--get*' flags) then it is sometimes hard to find the
> configuration file where the values were defined.
> 
> Teach 'git config' the '--sources' option to print the source
> configuration file for every printed value.
> 
> Based-on-patch-by: Jeff King <peff@peff.net>
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
> 
> diff to v1:
> 
> * add documention
> * produce a consistent (tab-delimited) format that can be parsed
> * adhere declaration-after-statement style
> * prefix every source line with the source type (file, stdin, blob, cmd)
> * add relative path test case
> * add blob ref test case
> * add "git config --local" test case (Note: I think I found a bug there that I
>   plan to fix/investigate in a seperate patch. Is it ok to leave the TODO?)
> * add a test case to check funny character escapes (file name with tabs)
> 
> Sebastian suggested "--show-origin" as a better option name over "--sources".
> I still believe "--sources" might be slightly better as I fear that users could
> somehow related "origin" to "remote" kind of configs. However, I am happy to
> change that if a majority prefers "--show-origin".

<bikeshed>
As I have said before, I'm not very good at naming things, but ...

Of the two, I *slightly* prefer --show-origin, since I don't think
there will be any confusion. However, I think --source may be OK too
(for some reason it sounds better than the plural). Another idea
may be --show-source. ;-)

</bikeshed>

ATB,
Ramsay Jones
