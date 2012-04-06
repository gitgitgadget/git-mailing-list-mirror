From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: push.default: current vs upstream
Date: Fri, 6 Apr 2012 23:38:46 +0400
Message-ID: <CAHkcotixA=NukMZYymjGQG+h5b9_6+5T13f4158rxKB1iAX-aw@mail.gmail.com>
References: <7vd37wv77j.fsf@alter.siamese.dyndns.org>
	<20120329095236.GA11911@sigill.intra.peff.net>
	<7vbonfqezs.fsf@alter.siamese.dyndns.org>
	<20120329221154.GA1413@sigill.intra.peff.net>
	<7vfwcqq2dw.fsf@alter.siamese.dyndns.org>
	<20120330071358.GB30656@sigill.intra.peff.net>
	<7vty15ltuo.fsf@alter.siamese.dyndns.org>
	<vpqty12h995.fsf@bauges.imag.fr>
	<20120405131301.GB10293@sigill.intra.peff.net>
	<vpqwr5uceis.fsf@bauges.imag.fr>
	<CAHkcotjrVqvYnAV5U7gPngbW0saghAv8vZB3jh=dOKLPmYdJrQ@mail.gmail.com>
	<CANgJU+VM4Dz3-EGa6z4hB8hB7ZvaahrG8tb5VCCzWQ=7zohBFA@mail.gmail.com>
	<CAHkcotgiNyaSRr-AH2j7GXjwXVSKToegZbycLWitv1tEfW6uSg@mail.gmail.com>
	<CANgJU+Wse2ej5tJmLnP54_Fx+A9O_UTK6zuLThdQDnnK5TWc4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: demerphq <demerphq@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 06 21:39:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SGF01-0001Im-1F
	for gcvg-git-2@plane.gmane.org; Fri, 06 Apr 2012 21:39:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757611Ab2DFTjE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Apr 2012 15:39:04 -0400
Received: from mail-pz0-f52.google.com ([209.85.210.52]:46571 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755017Ab2DFTjD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Apr 2012 15:39:03 -0400
Received: by dake40 with SMTP id e40so3061634dak.11
        for <git@vger.kernel.org>; Fri, 06 Apr 2012 12:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=GYMSpK3foiEuCxHtXcOEuPGeZZl2VT3ZYZvwP7Kd56U=;
        b=LxnwEBMtokHW+cjtj5/ZgwOvD4S6gU3Y2Zjh5MPWLaek+oAgiP/MXB2ReQu4Mpjy74
         18xkpsyf+cSyKypQ/hQ0H/YahirqCfOs/3OiHTqolxPoguVJfMaPxjkM5qesbYmkxoLw
         hrJsqdq9EdzFOtjnS4imdlfdR7f9g6h7LpA7lVsIvLIkUx8VVMTNpy5Ivtp4nssJpArN
         2BHPSL4NF/+M20CFmDesrDrohEtnycqxx1UScFwRtHkbpiAS67PBDc83vo7YhG/T6aJ+
         LEmuozO18anLRYPoVCWsE5issiuvYkMMGCht/NQi18mf6Y7Eb32yozK1IcQ1MUxwe2fk
         FlRg==
Received: by 10.68.197.164 with SMTP id iv4mr18258249pbc.11.1333741126876;
 Fri, 06 Apr 2012 12:38:46 -0700 (PDT)
Received: by 10.143.66.9 with HTTP; Fri, 6 Apr 2012 12:38:46 -0700 (PDT)
In-Reply-To: <CANgJU+Wse2ej5tJmLnP54_Fx+A9O_UTK6zuLThdQDnnK5TWc4w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194898>

On Fri, Apr 6, 2012 at 10:48 PM, demerphq <demerphq@gmail.com> wrote:
> On 6 April 2012 20:03, Dmitry Potapov <dpotapov@gmail.com> wrote:
>> On Fri, Apr 6, 2012 at 5:36 PM, demerphq <demerphq@gmail.com> wrote:
>>> On 6 April 2012 13:38, Dmitry Potapov <dpotapov@gmail.com> wrote:
>>>> Seriously, why do you care about beginners who use a centralized workflow
>>>> and not beginners who have to use with existing projects that use more or
>>>> less distributed workflow,
>>>
>>> Because the former are unlikely to be self-selected users of git and
>>> instead are likely to be forced to use git because their $work has
>>> dictated it to be so.
>>
>> Any decision is made by people. On its own, $work does not dictate what
>> VCS or what workflow should be used. There are many ways for those who
>> are in charge to screw up things. And a centralized workflow is not very
>> scalable and many bad practices associated with it. While it is not easy
>> to to convert a CVS/SVN repository to git that alone does not bring most
>> of git advantages, because those advantages come from the workflow.
>
> Pretty well every project that uses git has a "canonical upstream
> repository". Including for instance this one. Which basically means at
> some point there is a centralized master repo. It is either owned by
> someone like Linus or Junio, or it is owned by a company. Companies
> tend to like to know that their valuable data is properly backed up,
> and etc. This basically means central repos are inevitable. And git
> works just fine like that thank you very much.

It seems you confuse a centralized workflow with existence of an official
(central) repository. It is not same...

Dmitry
