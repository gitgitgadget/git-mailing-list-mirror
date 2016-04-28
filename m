From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 0/5] fixes for sanitized submodule config
Date: Thu, 28 Apr 2016 08:56:04 -0700
Message-ID: <CAGZ79kY-QMfK_u7V5sXcpC8ScjyrpugLgxMaRkM2q_+y3F_j1g@mail.gmail.com>
References: <60724588-B06E-47E8-9302-8709C4601826@gmail.com>
	<CAGZ79kYmAr-O6_Jw2KO9eZEfZQ+_WBiERF=nhOYLJCZpUjSSyA@mail.gmail.com>
	<CA+P7+xoaqNF+uBHVnD2QR7j-=0Hyvd-scTc_vOdV+etC0VS9jA@mail.gmail.com>
	<20160425212449.GA7636@sigill.intra.peff.net>
	<017AA7DB-5224-49C3-A4A6-6C93005BF006@gmail.com>
	<20160428112511.GA11522@sigill.intra.peff.net>
	<20160428120504.GA22399@sigill.intra.peff.net>
	<20160428121753.GA5023@sigill.intra.peff.net>
	<20160428133534.GA19056@sigill.intra.peff.net>
	<alpine.DEB.2.20.1604281600020.9313@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>,
	Lars Schneider <larsxschneider@gmail.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Git Users <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Apr 28 17:56:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avoJ0-0001DN-Mv
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 17:56:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753161AbcD1P4O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2016 11:56:14 -0400
Received: from mail-io0-f174.google.com ([209.85.223.174]:33360 "EHLO
	mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753132AbcD1P4K (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2016 11:56:10 -0400
Received: by mail-io0-f174.google.com with SMTP id f89so81084303ioi.0
        for <git@vger.kernel.org>; Thu, 28 Apr 2016 08:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=XpSZfMebTw5Ma0ARgNKjckDn9ngbPAes8A3tsimOrwo=;
        b=TAWrSsXlvTCiQpOCK9bRTZYI12rOzioIxm/Pa3SjES2+YjfE9pL6pb3CvA0ZIJ2Mdr
         9vEBIdr1FzPIjFCe/DviS8l1RqcmqRKK9Pxy2+XDJOv0QJTmIYEKTH0e9Qos1Em1o2pa
         DXMVbN89h5cKZACRkTayC4P5nHZLY5SFcJmZOflQodlF9qEtYez3TnIF+ydaI8EAMxfA
         BfcjT9LcX1UP3Yil2UuZQmYm2s+roc/HjlgSoYSWpW44AJSuRmUnypYvjV9TRyN1aGws
         QZ9OMPH0fIJXGUu6rSRFRzTJFE3mX8NvjQ8t7jGAbxFBT/LDeuteZ2BHDhGz8Apa0wH2
         uXdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=XpSZfMebTw5Ma0ARgNKjckDn9ngbPAes8A3tsimOrwo=;
        b=lkcHZbfxW58hmVSjX7dvQ5VdCTtU880LJ/Wr1OTRwarDNUOLHYVfdQEgeO7DZyRh2y
         wVSTT8mco4lqwgjuNYT9dedSiJj4pki7qN27bQUnUgxwwWbl2lkYFh9oZH/w+MLyEhGn
         QD6WSSgqkPmLiJiWAzHaDqdUkPTxM6zSQvehbwD3rIVN3JcGMpztbiFfwv2GezAoKXrA
         nCaKNtA01gcLUsrU2XW1oqVqiDoDvRSpBadQcb8QNXh4kANOWFJj2D7S4/p49vnfJSZG
         HAiNr+7gWuTohT1L7N58DAQQnPK8THf7sA1JpOys24k3IBBLmyEM8QdtVfIacon7PTPY
         KMXA==
X-Gm-Message-State: AOPr4FUnsKGmpkH/pKxtjtftij45cfq0l2XUla+WMG6jZ8ECRL/vUwKR3ILCUv4yaRm/XcfPuc4csbiN7o+sdSbD
X-Received: by 10.107.161.68 with SMTP id k65mr20746356ioe.110.1461858964221;
 Thu, 28 Apr 2016 08:56:04 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Thu, 28 Apr 2016 08:56:04 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1604281600020.9313@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292910>

On Thu, Apr 28, 2016 at 7:02 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Peff,
>
> On Thu, 28 Apr 2016, Jeff King wrote:
>
>> On Thu, Apr 28, 2016 at 08:17:53AM -0400, Jeff King wrote:
>>
>> > So that case _is_ correct right now. It's just that t5550 isn't testing
>> > the shell script part, which is broken. Probably running "git submodule
>> > update" in the resulting clone would cover that.
>> >
>> > And for the fetch case, we probably just need to be calling
>> > prepare_submodule_repo_env() there, too.
>>
>> So here's a series which fixes sanitizing in the "git-submodule" shell
>> script, along with "git fetch". And cleans up a few things along the
>> way.
>
> Nice!
>
> I reviewed those changes and they all look sensible to me (did not apply
> them locally for lack of time, though).

Same here.

>
> Ciao,
> Dscho
