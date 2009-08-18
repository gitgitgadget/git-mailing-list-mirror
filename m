From: Frank Li <lznuaa@gmail.com>
Subject: Re: [PATCH 05/11] Remove va_copy at MSVC because there are va_copy.
Date: Tue, 18 Aug 2009 13:06:23 +0800
Message-ID: <1976ea660908172206hc75c1e6i117806338be5ccea@mail.gmail.com>
References: <1250525040-5868-1-git-send-email-lznuaa@gmail.com>
	 <4A898B27.3040507@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, msysgit@googlegroups.com,
	Johannes.Schindelin@gmx.de
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Tue Aug 18 07:06:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdGtz-0002hU-IJ
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 07:06:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751436AbZHRFGX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 01:06:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751390AbZHRFGX
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 01:06:23 -0400
Received: from mail-qy0-f196.google.com ([209.85.221.196]:54462 "EHLO
	mail-qy0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750965AbZHRFGW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2009 01:06:22 -0400
Received: by qyk34 with SMTP id 34so2559019qyk.33
        for <git@vger.kernel.org>; Mon, 17 Aug 2009 22:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=lXUmIXnkYg1Xu2TtRh74bKVFaKCjAr4dYiUFee6WGwI=;
        b=Rxfa7hNyujABRh+bILbz6grKC9MVeFddX5vQqTnYLQC3St2YW2XM2M+YcD++sEj0sR
         msb4JlFQT7fNZqx4inh/fZ96gulfkcSmVAG/C2+dOonKXnFNinq1MIYLM//k8uSm+V7A
         nAjm74o8M/B/0pJApJ7nMCfox6Jw33gouh3ww=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=SMEDuwLy5LbxfmLcPXdN4ekMim1HZYs9CN/990F3ZwpVl36vTNruXQF1ekJ0TMA726
         p7k8uAKcooKiGQ96jUztbinJKjaYPoToSxDh8ChgXVoqAwNopKwoLhrAUMqv2ssavcZx
         7VajZuUtz28BQCf4HP5lLUbgL8zWJVaDXh5n4=
Received: by 10.224.102.212 with SMTP id h20mr5018671qao.40.1250571983918; 
	Mon, 17 Aug 2009 22:06:23 -0700 (PDT)
In-Reply-To: <4A898B27.3040507@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126346>

>
> #ifndef va_copy
> #define va_copy(dst, src)	((dst) = (src))
> #endif
>
> if it works on MSVC?
>
> Paolo
>

I test it, it works.
