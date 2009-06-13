From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH] Documentation: remove warning that "git bisect skip"
 may slow bisection
Date: Sat, 13 Jun 2009 01:14:36 -0700
Message-ID: <4A335FEC.6060309@gmail.com>
References: <20090613052258.4209.23374.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Sam Vilain <sam@vilain.net>, "H. Peter Anvin" <hpa@zytor.com>,
	Ingo Molnar <mingo@elte.hu>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sat Jun 13 10:15:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFOO4-0000in-FB
	for gcvg-git-2@gmane.org; Sat, 13 Jun 2009 10:14:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751698AbZFMIOo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Jun 2009 04:14:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751146AbZFMIOn
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Jun 2009 04:14:43 -0400
Received: from wa-out-1112.google.com ([209.85.146.177]:18516 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750782AbZFMIOl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jun 2009 04:14:41 -0400
Received: by wa-out-1112.google.com with SMTP id j5so538090wah.21
        for <git@vger.kernel.org>; Sat, 13 Jun 2009 01:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=wfodKnAbEVS8TU99aQUYnrapSoIr0D8yZFeQeir5COQ=;
        b=RhZCWZ+/bc96GgeFo2SI5ok/CG/4FnxyDHmL+XNNBh1yNDPKLLyN9YYjR/S7sqYfST
         HJyT4R6K3tLVEeWTgy2zLhTn/XNEHfE5WjnaCneRmK/1QyAy5XC5UZCYjL8K61hBfVx4
         x1eZIN/qYTrF5JSxISvgkZtp3N6fStShroRCY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=iXIFMl7H8z2rNSF+lF6YKZoJiNXd3rsM37qRnMLWAgONIMDa+xLawFcIEnF+8qHdN3
         zCDR6YdZbuzi3JMNN9jm1vq0I5D+WaziZ8Vb5O9TVJIlXSlzdpW/m+7Mi+F1hR+t4oMm
         gv1gZtoT4Hg2Zs9zooNlnGzCiZwbRDtkfgno4=
Received: by 10.114.113.16 with SMTP id l16mr7457806wac.188.1244880883184;
        Sat, 13 Jun 2009 01:14:43 -0700 (PDT)
Received: from ?192.168.1.2? ([76.89.212.195])
        by mx.google.com with ESMTPS id m28sm2221342waf.2.2009.06.13.01.14.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 13 Jun 2009 01:14:38 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090429)
In-Reply-To: <20090613052258.4209.23374.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121488>

Christian Couder wrote:
> -But computing the commit to test may be slower afterwards and git may
> -eventually not be able to tell the first bad commit among a bad commit
> -and one or more skipped commits.
> +But git may eventually not be able to tell the first bad commit among
> +a bad commit and one or more skipped commits.
>  
>  You can even skip a range of commits, instead of just one commit,
>  using the "'<commit1>'..'<commit2>'" notation. For example:
>   

Can this be "git may eventually be unable to tell" instead?
