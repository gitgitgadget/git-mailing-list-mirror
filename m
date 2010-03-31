From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH 2/2] gitk: add the equivalent of diff --color-words
Date: Wed, 31 Mar 2010 14:04:17 +0200
Message-ID: <201003311404.17760.trast@student.ethz.ch>
References: <cover.1269996525.git.trast@student.ethz.ch> <5850172da86408306dee764013d6a0aeed02e604.1269996525.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eelis van der Weegen <eelis@eelis.net>,
	Paul Mackerras <paulus@samba.org>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 31 14:04:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nwwez-0000n8-F9
	for gcvg-git-2@lo.gmane.org; Wed, 31 Mar 2010 14:04:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932437Ab0CaME3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Mar 2010 08:04:29 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:6055 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932334Ab0CaME2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Mar 2010 08:04:28 -0400
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.234.1; Wed, 31 Mar
 2010 14:04:24 +0200
Received: from thomas.localnet (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.234.1; Wed, 31 Mar
 2010 14:04:17 +0200
User-Agent: KMail/1.13.2 (Linux/2.6.31.12-0.2-desktop; KDE/4.4.2; x86_64; ; )
In-Reply-To: <5850172da86408306dee764013d6a0aeed02e604.1269996525.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143666>

Thomas Rast wrote:
> @@ -7727,15 +7739,22 @@ proc getblobdiffline {bdf ids} {
>  	    # parse the prefix - one ' ', '-' or '+' for each parent
>  	    set prefix [string range $line 0 [expr {$diffnparents - 1}]]
>  	    set tag [expr {$diffnparents > 1? "m": "d"}]
> +	    puts "prefix is '$prefix'"

This is a leftover debugging print and should be removed if you want
to try it... sorry for the noise.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
