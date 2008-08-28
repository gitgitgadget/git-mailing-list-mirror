From: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Thu, 28 Aug 2008 15:45:56 +0200
Message-ID: <4d8e3fd30808280645n95b0afat1e9ed2e79a38498f@mail.gmail.com>
References: <alpine.DEB.1.00.0808252018490.24820@pacific.mpi-cbg.de.mpi-cbg.de>
	 <20080827001705.GG23698@parisc-linux.org>
	 <7v63pmkozh.fsf@gitster.siamese.dyndns.org>
	 <1219907659.7107.230.camel@pmac.infradead.org>
	 <7vtzd5fta0.fsf@gitster.siamese.dyndns.org>
	 <1219912327.7107.245.camel@pmac.infradead.org>
	 <94a0d4530808280157p230d289dlf0c85cd517541801@mail.gmail.com>
	 <20080828115408.GA30834@hera.kernel.org>
	 <94a0d4530808280615i2befb89cm7d6153bfceb11b19@mail.gmail.com>
	 <94a0d4530808280634k1c23fe10q8934875c83d4a2f5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Al Viro" <viro@hera.kernel.org>,
	"David Woodhouse" <dwmw2@infradead.org>,
	"Matthew Wilcox" <matthew@wil.cx>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	users@kernel.org, "Jeff King" <peff@peff.net>,
	"Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Felipe Contreras" <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 28 15:50:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYhqH-00005Y-R6
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 15:47:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753278AbYH1Np6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 09:45:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752755AbYH1Np5
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 09:45:57 -0400
Received: from wf-out-1314.google.com ([209.85.200.173]:62963 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753305AbYH1Np4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 09:45:56 -0400
Received: by wf-out-1314.google.com with SMTP id 27so349766wfd.4
        for <git@vger.kernel.org>; Thu, 28 Aug 2008 06:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=sillyxBaUcXG9DXzIJMGY6fXzzwRumN9503VlVZph8E=;
        b=nSTEWhaTooynRSxMUMe7FptXthW9uFaeh1IFpMV/4wC8GbNd61r9JWg0eDrzXIxVJK
         8IZ8dEqX2PlJKCWwaSw/FbDrQ4r3m1eMRYueqfHhFpbdVVs/bYtQHOdwZFM9ZCMMdmVU
         o+qmgduAEEIpDxM+/Q+IgPHOITmkNEQebs5fA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=vnqJbqazidRvKVQ5Q6XqW83BXnMXmoUBcT8meakj18XsWC1HQBrf1HtlgnoNAGntxH
         6CTX8JgOklUWPgnrSfQixLABbtlo4Vmcl+ch29/RKe9YmdKHtsWtNI6q+P3oSYSzaIU2
         Dd3DRt8C4IoHJiaLz+oVI7f+L6V54FC7JcMNY=
Received: by 10.142.217.17 with SMTP id p17mr484802wfg.23.1219931156271;
        Thu, 28 Aug 2008 06:45:56 -0700 (PDT)
Received: by 10.142.177.15 with HTTP; Thu, 28 Aug 2008 06:45:56 -0700 (PDT)
In-Reply-To: <94a0d4530808280634k1c23fe10q8934875c83d4a2f5@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94054>

On Thu, Aug 28, 2008 at 3:34 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Thu, Aug 28, 2008 at 4:15 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> On Thu, Aug 28, 2008 at 2:54 PM, Al Viro <viro@hera.kernel.org> wrote:
>>> On Thu, Aug 28, 2008 at 11:57:56AM +0300, Felipe Contreras wrote:
>>>
>>>> The masses should forget about the git-foo form. If you push people
>>>> into using git-foo then you are not following git guidelines; you
>>>> would be pushing your own agenda.
>>>
>>> Egads...  For sarcasm it's far too heavy-handed and if that's for real...
>>> What's next, verbal diarrhea about Diluting the Message(tm)?
>>
>> Sorry, I guess I should have made it clearer.
>>
>> I haven't made my mind about git-foo vs "git foo", but a decision has
>> been made to deprecate git-foo, and allow it as an option for the
>> people that really want to use it, right?
>>
>> So there must have been a reason to deprecate git-foo, if people keep
>> using git-foo, and distributions keep allowing it, what's the point of
>> deprecation? It's ok if they keep that usage to themselves, like
>> 'alias ll = ls -l', but it's not something to assume everybody uses.
>>
>> So either we take back the decision and keep discussing if it's a good
>> idea to deprecate git-foo, or we go forward and discourage git-foo
>> completely.
>>
>> Anything in the middle would just confuse people more, and wouldn't
>> achieve the purpose of deprecation.
>>
>> If some script is relying on git-foo, and it has been deprecated, it
>> should be fixed.
>
> Actually, now I think I understand the point of David Woodhouse better.
>
> If the git-foo was supposed to be deprecated in 1.6.0, it should still
> work by default, but something to strongly discourage it like a
> warning should have been added.
>
> When it becomes truly obsolete, then people can rely on git exec-dir,
> which will be disabled by default.
>
> So is it deprecated or obsolete?

I quote Junio:
--8<---
We have deprecated the dashed form in early 2006, and announced that 1.6.0
will remove them from $PATH in the 1.5.4 release notes, with instructions
on how to update their scripts before 1.6.0 happens.  Many people knew
about this transition, but they didn't do anything about it.  Since 2005,
git has matured enough that majority of people are using it without
building one themselves, without a chance to even read Release Notes
--8<---

Ciao,
-- 
Paolo
http://paolo.ciarrocchi.googlepages.com/
