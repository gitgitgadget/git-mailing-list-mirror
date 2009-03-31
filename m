From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] Add configuration variable for sign-off to format-patch
Date: Tue, 31 Mar 2009 21:47:37 +0200
Message-ID: <49D27359.1040703@op5.se>
References: <20090331185018.GD72569@macbook.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Tue Mar 31 21:49:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LojxY-00022o-AM
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 21:49:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761732AbZCaTrp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2009 15:47:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760330AbZCaTro
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 15:47:44 -0400
Received: from mail.op5.se ([193.201.96.20]:41255 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759625AbZCaTrn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2009 15:47:43 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 215221B80379;
	Tue, 31 Mar 2009 21:25:12 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4L2Yp3ulJuku; Tue, 31 Mar 2009 21:25:10 +0200 (CEST)
Received: from clix.int.op5.se (unknown [172.27.78.6])
	by mail.op5.se (Postfix) with ESMTP id 87CE11B80076;
	Tue, 31 Mar 2009 21:25:10 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <20090331185018.GD72569@macbook.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115304>

Heiko Voigt wrote:
> If you regularly create patches which require a Signed-off: line you may
> want to make it your default to add that line. It also helps you not to forget
> to add the -s/--signoff switch.
> 
> Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
> ---
> 
> Because it happened to me twice already that I forgot to add the switch.
> 
>  Documentation/config.txt           |    4 ++++
>  Documentation/git-format-patch.txt |    1 +
>  builtin-log.c                      |   23 ++++++++++++++++-------
>  3 files changed, 21 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index ad22cb8..ed85536 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -715,6 +715,10 @@ format.thread::
>  	A true boolean value is the same as `shallow`, and a false
>  	value disables threading.
>  
> +format.signoff::
> +	This lets you enable the -s/--signoff option of format-patch by
> +	default. It takes a boolean value.
> +

Can we please make it "formatpatch.signoff" or some such instead? Just
plain "format" is a bit too generic for my taste.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
