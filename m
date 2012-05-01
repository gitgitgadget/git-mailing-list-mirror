From: PJ Weisberg <pj@irregularexpressions.net>
Subject: Re: Is there any way to make hooks part of the repository?
Date: Tue, 1 May 2012 14:59:18 -0700
Message-ID: <CAJsNXT=niP2Ja-pSbvj-OGi5t0x0-Zxm3CdcY0nLs9ROdCG8hg@mail.gmail.com>
References: <CAE1pOi2hr7ewjo5WVDoW0ipYxDVTckr5M_sHNoOQ323=_k754Q@mail.gmail.com>
	<7vipgf8wve.fsf@alter.siamese.dyndns.org>
	<86r4v3mxf7.fsf@red.stonehenge.com>
	<7vaa1r8vhy.fsf@alter.siamese.dyndns.org>
	<CAE1pOi00Mr4dOj2ChTJU9XWypUAaVUDDa36-M7LA+9BixW0nKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>,
	Git Users <git@vger.kernel.org>
To: Hilco Wijbenga <hilco.wijbenga@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 01 23:59:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPL6S-0001pG-SL
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 23:59:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753089Ab2EAV7U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 May 2012 17:59:20 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:46067 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752759Ab2EAV7U (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2012 17:59:20 -0400
Received: by wgbdr13 with SMTP id dr13so275wgb.1
        for <git@vger.kernel.org>; Tue, 01 May 2012 14:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=He1yWO26o0Ij9brCsYEKwX1rHHohvifG1EPVe+taPnI=;
        b=uZEw3mPmy/puBdhFM2tla6ltLVVkKrOIeiUh85PYlKD9+oUIR8FgXKh/2yoyHi8ssN
         tGsfT4UxU7Sc4YkNttQz1uEvymsDwooJ+hyIu4OSvCrWmeVZno7wgg1dOL8RHxjreewT
         w3Uf/cI2O4i/ZpsP66uqdFEvNWDI+ItGl024Y5DN3dRxojNvpuv5LsYBH1gX/zQh0Cet
         9L1Ad9LTXtev7akyfBf3A6Wwm0d6DozygHNWaVlxYcRvfQ8vNxtkkh43O9AzGIccGQ0S
         P+2qFPei2khj1ju1AU4jKEPsn7H0DxOcrn2Ged+3W9r+KNC7W/pWYfPEC+uXiMM/l+1F
         AViQ==
Received: by 10.216.132.202 with SMTP id o52mr4509640wei.106.1335909558688;
 Tue, 01 May 2012 14:59:18 -0700 (PDT)
Received: by 10.223.116.200 with HTTP; Tue, 1 May 2012 14:59:18 -0700 (PDT)
In-Reply-To: <CAE1pOi00Mr4dOj2ChTJU9XWypUAaVUDDa36-M7LA+9BixW0nKw@mail.gmail.com>
X-Google-Sender-Auth: ooHxBtdeBPBlZ9gr-wWu2yypTFA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196760>

On Tue, May 1, 2012 at 2:09 PM, Hilco Wijbenga <hilco.wijbenga@gmail.com> wrote:

> On 1 May 2012 14:03, Junio C Hamano <gitster@pobox.com> wrote:
>
>> We've talked about something like that a few times in the past, but as far
>> as I (am concerned / remember) the conclusion has always been that is not
>> worth "standardizing", i.e. nothing a ./setup script in-tree or a Makefile
>> target cannot offer the same convenience.
>
> This would not keep things up-to-date, though, would it? It seems like
> yet another thing developers need to remember and do. I would prefer
> something more automatic.

Once your hooks are installed, couldn't your post-checkout and
post-merge hooks keep all the others up to date?


-PJ

Gehm's Corollary to Clark's Law: Any technology distinguishable from
magic is insufficiently advanced.
