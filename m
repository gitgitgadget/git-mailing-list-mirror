From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH 0/5] fixes for sanitized submodule config
Date: Thu, 28 Apr 2016 09:03:48 -0700
Message-ID: <CA+P7+xqU8k2bwZC3-z6+gx+fr7Tbn09Mpq1DEOsr7z-usyv6Pw@mail.gmail.com>
References: <60724588-B06E-47E8-9302-8709C4601826@gmail.com>
 <CAGZ79kYmAr-O6_Jw2KO9eZEfZQ+_WBiERF=nhOYLJCZpUjSSyA@mail.gmail.com>
 <CA+P7+xoaqNF+uBHVnD2QR7j-=0Hyvd-scTc_vOdV+etC0VS9jA@mail.gmail.com>
 <20160425212449.GA7636@sigill.intra.peff.net> <017AA7DB-5224-49C3-A4A6-6C93005BF006@gmail.com>
 <20160428112511.GA11522@sigill.intra.peff.net> <20160428120504.GA22399@sigill.intra.peff.net>
 <20160428121753.GA5023@sigill.intra.peff.net> <20160428133534.GA19056@sigill.intra.peff.net>
 <alpine.DEB.2.20.1604281600020.9313@virtualbox> <CAGZ79kY-QMfK_u7V5sXcpC8ScjyrpugLgxMaRkM2q_+y3F_j1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>,
	Lars Schneider <larsxschneider@gmail.com>,
	Git Users <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Apr 28 18:04:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avoQJ-00045I-2y
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 18:04:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752806AbcD1QEL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2016 12:04:11 -0400
Received: from mail-ob0-f177.google.com ([209.85.214.177]:34454 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752403AbcD1QEI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2016 12:04:08 -0400
Received: by mail-ob0-f177.google.com with SMTP id bg3so41229093obb.1
        for <git@vger.kernel.org>; Thu, 28 Apr 2016 09:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=MgnE+OQkmsWV08s19uJk52qJMlVG/ZdTUR0BH8RYbJs=;
        b=zNHltS0YXOcOtM5PluCHUyAPhDtAXbKwWcpob0to+pRe0jQ/aeEYAvVRrNwRfH6EW/
         mJYbJMkPjPqQU8lvCDPuUbEv3LCV7SI0Zlg2CWzJbXS++iTR1LHucYCvl8iCofzs+zvQ
         vmEIuz1/pBv2Y4L93YPi+IFzj9ISaGUrJmFAj5imxwwpXNOAuejaI1COZi7rDTmQvSOL
         kind7/glkswKDbr5i1fI2rXVA2QinX5LAlqnFDuuCwUeh3iiOlojT+jfUGDDRtGNGC3y
         /AcsnI5RHE4aRNEHjQZR7rsvzMlnUyDqvbjr/fPvA0kONkrYq6mXj+Dzk3fhirZxpthB
         PDFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=MgnE+OQkmsWV08s19uJk52qJMlVG/ZdTUR0BH8RYbJs=;
        b=QIpQaYfH8/nHsLZyIuTT7pu7ZpnBpRzh+OxkcRpKLDV2WsUxIBAllrDHRCupjnudEt
         YYFX2OngaZ/lmW6gp2h+KeHv2CsVLy7cOiM2wE6nSKtmUbpaAx+u2ktD+RBWORwASCqW
         iG+TDji2iu5gPPhYlsOsH6ZFJ9v7qx+Id/q8/6d6N6v7zHW6SkmLntd4BEGkzM35t9ll
         gcl4gci+yHImRGwiZpjf1A+fJ07ChXOUURtN6BGrlIlCF2QKZKdUL6S8g7cM/WECW85m
         Moeg/+bhZKEheWvbokqk1TjWsw46sflMkgho4QCe1MBde/YnYXPsm/I1HKdBOP95Z17j
         Gcug==
X-Gm-Message-State: AOPr4FXS36bxLVEwVEALbJatDcICI8tK0nncANOAfg1OvoNfQ9EHGhG80tXv4mTcFx9EKk/D+MTrTnKfrWpmzA==
X-Received: by 10.182.213.8 with SMTP id no8mr7011383obc.8.1461859447842; Thu,
 28 Apr 2016 09:04:07 -0700 (PDT)
Received: by 10.182.117.132 with HTTP; Thu, 28 Apr 2016 09:03:48 -0700 (PDT)
In-Reply-To: <CAGZ79kY-QMfK_u7V5sXcpC8ScjyrpugLgxMaRkM2q_+y3F_j1g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292911>

On Thu, Apr 28, 2016 at 8:56 AM, Stefan Beller <sbeller@google.com> wrote:
> On Thu, Apr 28, 2016 at 7:02 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>> Hi Peff,
>>
>> On Thu, 28 Apr 2016, Jeff King wrote:
>>
>>> On Thu, Apr 28, 2016 at 08:17:53AM -0400, Jeff King wrote:
>>>
>>> > So that case _is_ correct right now. It's just that t5550 isn't testing
>>> > the shell script part, which is broken. Probably running "git submodule
>>> > update" in the resulting clone would cover that.
>>> >
>>> > And for the fetch case, we probably just need to be calling
>>> > prepare_submodule_repo_env() there, too.
>>>
>>> So here's a series which fixes sanitizing in the "git-submodule" shell
>>> script, along with "git fetch". And cleans up a few things along the
>>> way.
>>
>> Nice!
>>
>> I reviewed those changes and they all look sensible to me (did not apply
>> them locally for lack of time, though).
>
> Same here.
>

Same as well. Looks good, and good catch finding the bug!

Thanks,
Jake

>>
>> Ciao,
>> Dscho
