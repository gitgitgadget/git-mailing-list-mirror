From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: git submodule should honor "-c credential.helper" command line argument
Date: Thu, 18 Feb 2016 23:51:25 -0800
Message-ID: <CA+P7+xoN+ye38tHiXc=WGenuuF0NVA1R-3nfd5_LNjOF01EJfQ@mail.gmail.com>
References: <56B0E3AA.30804@syntevo.com> <20160203042554.GA21179@sigill.intra.peff.net>
 <CA+P7+xpGTvbyLOKQ=DHFBLOuVNN8WocraaZQhFD36oDiFrY+sA@mail.gmail.com>
 <CA+P7+xr4gQFPsUiuqSzMsUJP6_W8FnXBwX1Xes=XjksuTs=+hQ@mail.gmail.com>
 <56B74B17.4040304@syntevo.com> <CA+P7+xpFmZBUwq1h9Xhi7xKYfAyvcouBiV5ujHxuGJQJTMHXZw@mail.gmail.com>
 <CA+P7+xpHNHVSJnVg3HwiBjWxRdSpLXCsm3GpWst=BNyhLMVd5A@mail.gmail.com>
 <20160219043019.GA14764@sigill.intra.peff.net> <CA+P7+xr9dLOyaVky1jvXm7MkF0JUqs5SadrTdr4o83baMp397A@mail.gmail.com>
 <20160219074633.GA780@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Marc Strapetz <marc.strapetz@syntevo.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Git mailing list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 19 08:51:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWfqw-00014M-2C
	for gcvg-git-2@plane.gmane.org; Fri, 19 Feb 2016 08:51:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753441AbcBSHvq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2016 02:51:46 -0500
Received: from mail-ig0-f170.google.com ([209.85.213.170]:37640 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751488AbcBSHvp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2016 02:51:45 -0500
Received: by mail-ig0-f170.google.com with SMTP id 5so31263227igt.0
        for <git@vger.kernel.org>; Thu, 18 Feb 2016 23:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=+lu80zpNn93EgCB7mLG9y4pfKE1XtoWvEehAWBu3Cr0=;
        b=NlSGKzbL3IyInobjiYEIGj8KtamuJOC26yI6ycH4yGJx0S/YOkW8Sk+/5t0Y3HJ9Ne
         GgxrXIkLYDDQJmBi48apcMAoO59gz6BSuauEdk/BljNIz4CUkFR+DngfcEFiQIgdeH4M
         DRV0jHnfj2AEg1jMdoHJ5Qt56IprcohUplEZEq3oibvN0OnA1qbvpMl/Kkgmq+29mHlM
         CYkpGL7cbZcMM6LIIJkdm9I9WL2UHdAiosbdjZIqIDa6eKC8ssfTi0BiSQkhJsrzkQWt
         yL3hqS0NQRBo+xz4RTClmjdaEPIRcXHf6JADdM51zL7K4AFuUZ6qRuCNkli55Ho4bmZe
         lbEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=+lu80zpNn93EgCB7mLG9y4pfKE1XtoWvEehAWBu3Cr0=;
        b=dTSxhD9WJFnF7Mf3RtGMwAqWT39VjJFl7Soh7FYnEvlzSgqZUrDWfeVKbrVebaJQuZ
         viz6OWJENkzrhJExei6VGjU8SUJVt1GymV/DrV2EQqaGdVcZWIwfllJWg1n6bvdesalE
         +n2XkDwmZaMf1I4Q2WPZZu3uRdgZFq0RThJt0DnYtHamIjIuYQf3m3HgzLQgr59puLAw
         WWIotrB9gXRuoYJhJVg4WMdSzvEChu76yZzUIXJVN81DHx4BF8Vm6XS7qkTyqn8Vfxrf
         r9InzguU4sULCxCYxA7rrjqK6yn2PAFD+ESYOAELn3nB7nNAypLM8rXdulyy1diQVqmr
         ntDA==
X-Gm-Message-State: AG10YORXoa6m7HwQFb9jyawmj4RkBMCnKo7vUh/4gTC3Xt8VZS0/6xkJrJ/eVe6pIYXooq8oIEEWbQ9YnM+NHQ==
X-Received: by 10.50.72.48 with SMTP id a16mr7326842igv.73.1455868304914; Thu,
 18 Feb 2016 23:51:44 -0800 (PST)
Received: by 10.107.20.76 with HTTP; Thu, 18 Feb 2016 23:51:25 -0800 (PST)
In-Reply-To: <20160219074633.GA780@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286665>

On Thu, Feb 18, 2016 at 11:46 PM, Jeff King <peff@peff.net> wrote:
> To trigger a credential fetch in actual use, you have to clone over
> http. See the credential tests in t5550, for example.
>

I'll look at these.

>> As for how to whitelist config to share with the submodule I am really
>> not 100% sure, since we just clear GIT_CONFIG_PARAMETERS, and I think
>> we'd need a specialized variant of clear_local_git_env_vars specific
>> to submodule then.
>
> Yeah, you'll have to parse, which is pretty painful. In C, you'd do
> something like:

<snip>

>
> but right now git-submodule.sh is all in shell. You'd probably need a
> special helper from git-submodule--helper, though it might simply make
> sense to put this off until the submodule code is fully ported to C.
>

I think the best approach is probably to put this off since I am not
100% sure how we'd handle environment variables from swapping into
submoduler--helper and out. That seems really finicky and likely to go
away once the full port occurs so I am not sure it's worth it.

> -Peff
