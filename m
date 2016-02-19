From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: git submodule should honor "-c credential.helper" command line argument
Date: Fri, 19 Feb 2016 11:34:12 -0800
Message-ID: <CA+P7+xqyD=oOnZ+T_L29KYyS4EpmAAVda33ypTphFuPMbvyNRw@mail.gmail.com>
References: <56B0E3AA.30804@syntevo.com> <20160203042554.GA21179@sigill.intra.peff.net>
 <CA+P7+xpGTvbyLOKQ=DHFBLOuVNN8WocraaZQhFD36oDiFrY+sA@mail.gmail.com>
 <CA+P7+xr4gQFPsUiuqSzMsUJP6_W8FnXBwX1Xes=XjksuTs=+hQ@mail.gmail.com>
 <56B74B17.4040304@syntevo.com> <CA+P7+xpFmZBUwq1h9Xhi7xKYfAyvcouBiV5ujHxuGJQJTMHXZw@mail.gmail.com>
 <CA+P7+xpHNHVSJnVg3HwiBjWxRdSpLXCsm3GpWst=BNyhLMVd5A@mail.gmail.com>
 <20160219043019.GA14764@sigill.intra.peff.net> <xmqqr3g8d2pn.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>,
	Marc Strapetz <marc.strapetz@syntevo.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Git mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 19 20:34:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWqpD-0003s2-CD
	for gcvg-git-2@plane.gmane.org; Fri, 19 Feb 2016 20:34:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946214AbcBSTen (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2016 14:34:43 -0500
Received: from mail-io0-f181.google.com ([209.85.223.181]:34667 "EHLO
	mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751630AbcBSTem (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2016 14:34:42 -0500
Received: by mail-io0-f181.google.com with SMTP id 9so120343066iom.1
        for <git@vger.kernel.org>; Fri, 19 Feb 2016 11:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=y+uZL4ituP9vZRSLwth3sIrPlpmlmwTTL+Z8IPP8t6I=;
        b=t8OIW+TiNqevZn/8coahN/7Bo8aFvS72uYT5s1uhGafNpUz91rW40FWkhsLRZsHAJL
         7EhQV9AHd+SbODfiTnj2mBcBSxwiFC3/WwPl8G0e2e+uSVk0J9+HCviA6ktvFjUJfJyp
         0liqajA+/4SB5omDqV2+Fj516jxr1EkCkFlXBoAffo8d2LvFOUHXlhsTNcBCxB/7gw99
         F2jjcPlpAf6UHjd6LaBLs7c5BA3kTM8TEjUD1GpyFlS1nIRNZRFYPGndo/4d1lA7OnVk
         s/I+hvYrKyY6SQq18k1toA0qCTE1Zulgr4Se6IjclzZ9bKdZGouMgM4a3u179EK2hhIj
         Vc6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=y+uZL4ituP9vZRSLwth3sIrPlpmlmwTTL+Z8IPP8t6I=;
        b=X35MtRFFKEpXu06Oas5Anruwe09rUdkK5mUGGoebapV60ziSw6dA2Wk3SBNrC7aCus
         j0ZotCxNhi1gdBc7uUwm5WO6gMf+H+VTFcgm8ISOhkUvTgufKTKLmOqfaiLNmgQAtIQI
         YJBMQhYSi/yCdaxLNk+ttXjc66C0hA2zjRWaSo/xiHKpwALakoHbCvXdPjou7lLb+2VG
         wawrnNSOd6A/5L6/5T3E5NRHtIpQSsY+PXAtppoF0StAXY8K5MUDolcQ5qZoD4SCVi+0
         dYJnzTqQ+uFiBe5oLSP02OQOS3zae0vZrdwu7KcKqpm7W0AYnSFisv7Ob3aIN77oEnA6
         pMEA==
X-Gm-Message-State: AG10YOS0ex1wU839ztxGsP/o+Y+JaxWlBrMd+5XDaw4JUH7MpmBoxPcdwBKGdwRb1/5LRyqgyeOJ34pNgWZkbw==
X-Received: by 10.107.156.14 with SMTP id f14mr19366401ioe.0.1455910471869;
 Fri, 19 Feb 2016 11:34:31 -0800 (PST)
Received: by 10.107.20.76 with HTTP; Fri, 19 Feb 2016 11:34:12 -0800 (PST)
In-Reply-To: <xmqqr3g8d2pn.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286747>

On Fri, Feb 19, 2016 at 9:33 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>
>> That being said, I am not sure this is the right solution. In the thread
>> I linked earlier[1], Jens indicated he would prefer not to blindly share
>> config with the submodules, and I think I agree. Or are you proposing to
>> pick and choose the keys in GIT_CONFIG_PARAMETERS, and whitelist
>> credential.*?
>
> Yes, I think it is sensible not to propagate by default, and pass
> ones that are absolutely safe, sane and necessary by whitelisting.

Yes I agree. I'm trying to think of a reasonable way to implement this
as part of a submodule--helper.. something like whitelist-config or
something, which would just output the value of GIT_CONFIG_PARAMETERS
after whitelisting. It would be up to the shell code to then use this
inside a subshell.

Regards,
Jake
