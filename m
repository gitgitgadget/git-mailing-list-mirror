From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 4/4] color-words: make regex configurable via
 attributes
Date: Thu, 15 Jan 2009 02:43:33 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901150241210.3586@pacific.mpi-cbg.de>
References: <3ff3ccf6e3c1cd6a002d200aee5df88a197a7bf6.1231971446.git.trast@student.ethz.ch> <48504e8a330beca560208ce050d43bc92ac04c90.1231971446.git.trast@student.ethz.ch> <b1290f83267e64856e58477e0c19e920dd416c82.1231971446.git.trast@student.ethz.ch>
 <b404fdfe0f5af535b35d1f239a68f6a7911ede19.1231971446.git.trast@student.ethz.ch> <alpine.DEB.1.00.0901150233121.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org,
	=?ISO-8859-15?Q?Santi_B=E9jar?= <santi@agolina.net>,
	Junio C Hamano <junio@pobox.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Jan 15 02:44:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNHHE-0006Xp-N7
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 02:44:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752628AbZAOBmo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 20:42:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750927AbZAOBmn
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 20:42:43 -0500
Received: from mail.gmx.net ([213.165.64.20]:39327 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751262AbZAOBmm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 20:42:42 -0500
Received: (qmail invoked by alias); 15 Jan 2009 01:42:40 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp068) with SMTP; 15 Jan 2009 02:42:40 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+c1ZpLr/GcUV1cwXLQsCQy/z8P8+Cbkz86gxN/++
	ad7+Ca/MRnfwiQ
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.DEB.1.00.0901150233121.3586@pacific.mpi-cbg.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105756>

Hi,

On Thu, 15 Jan 2009, Johannes Schindelin wrote:

> @@ -136,10 +131,11 @@ cat > expect <<\EOF
>  aaa (aaa) <GREEN>aaa<RESET>
>  EOF
>  
> -test_expect_success "test parsing words for newline" '
> +test_expect_success 'test parsing words for newline' '
> +
> +	word_diff --color-words="a+"
>  
> -	word_diff --color-words="a+" &&
> -	word_diff_check expect
> +	word_diff --color-words=.
>  
>  '

D'oh.  please remove the last word_diff, this comes from my "fix" for your 
smiley issue.

Ciao,
Dscho "off to bed"

--
"The night was so dark that he hardly coulx srr tje keuboarf."
