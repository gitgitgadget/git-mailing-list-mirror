From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH 2/5] diff --quiet
Date: Wed, 14 Mar 2007 23:33:14 +0100
Message-ID: <81b0412b0703141533q4e71e67aqaa83de45fa9e3988@mail.gmail.com>
References: <7vwt1j8z0e.fsf@assigned-by-dhcp.cox.net>
	 <7vodmv7bza.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Mar 14 23:33:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRc24-0004SS-5v
	for gcvg-git@gmane.org; Wed, 14 Mar 2007 23:33:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422696AbXCNWdR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Mar 2007 18:33:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422706AbXCNWdQ
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Mar 2007 18:33:16 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:28505 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422696AbXCNWdP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2007 18:33:15 -0400
Received: by nf-out-0910.google.com with SMTP id o25so422203nfa
        for <git@vger.kernel.org>; Wed, 14 Mar 2007 15:33:14 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kjCXdk+U8zPY8A7v62f1pDjSw34Egf3wc2xK6GLhIUiorUpsGesEtONrTdJOyg0Pw88VsrY6OTascvCFNuCj8MeOEtoonSISJba1UD1czO6JWW93enQ3+OgmzGPM0y52NUyWEmu373kGkBzCVTuVgxMurggvcLA66WikYoedR74=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=f2ydbCFFdDpO7mp1AjjXCT1we8uw0DCR603sSJQtP9u3X9Bqz4UAbKZ9RcNixin4gxFU7UGQemPx27zqB0E9lJXPQX57CbgL/UCXBzkaD14KuBQeFmf/Z+htBXprb/nz8OoNvfPKVjOpx7mXzpmiANJ+7++8udq3JPi8h7n6RY8=
Received: by 10.78.136.7 with SMTP id j7mr851198hud.1173911594515;
        Wed, 14 Mar 2007 15:33:14 -0700 (PDT)
Received: by 10.78.138.5 with HTTP; Wed, 14 Mar 2007 15:33:14 -0700 (PDT)
In-Reply-To: <7vodmv7bza.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42242>

On 3/14/07, Junio C Hamano <junkio@cox.net> wrote:
> The --quiet option is silently turned off (but --exit-code is
> still in effect, so is silent output) if postprocessing filters
> such as pickaxe and diff-filter are used.  For all practical
> purposes I do not think of a reason to want to use these filters
> and not viewing the diff output.

pickaxe filter can be useful in hooks to enforce policy
on use of some constructs. I can well imagine (do not
even have to imagine) a stupid company policy forbidding
commits with "\<printf\>" in them. Have no idea for
diff-filter though.
