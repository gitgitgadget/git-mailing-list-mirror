From: Stephen Kelly <steveire@gmail.com>
Subject: Re: Creating remote branch called HEAD corrupts remote clones
Date: Tue, 26 Apr 2011 14:09:04 +0200
Message-ID: <BANLkTim1gW_L-9DKo9p_VFQFUBUGWAPxoA@mail.gmail.com>
References: <ih1449$ul6$1@dough.gmane.org>
	<7v62tjs66r.fsf@alter.siamese.dyndns.org>
	<20110120203840.GA11468@sigill.intra.peff.net>
	<7vbp3bqmiy.fsf@alter.siamese.dyndns.org>
	<20110120215456.GB11468@sigill.intra.peff.net>
	<AANLkTikBbSt5_WdbuE8a96w1pWBCYLNjMCUCBThjdLdG@mail.gmail.com>
	<7vk4hyp38i.fsf@alter.siamese.dyndns.org>
	<AANLkTikmbWkpjioARZrmySpLM8t7kqCX0v1+NKibk_ar@mail.gmail.com>
	<AANLkTinRcmevXz3zV0wtxd7+Q3F4zcH2AZOQk1XVxYXa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 26 14:09:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEh4s-0004MY-6F
	for gcvg-git-2@lo.gmane.org; Tue, 26 Apr 2011 14:09:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751515Ab1DZMJI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Apr 2011 08:09:08 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:41550 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750837Ab1DZMJH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Apr 2011 08:09:07 -0400
Received: by bwz15 with SMTP id 15so441445bwz.19
        for <git@vger.kernel.org>; Tue, 26 Apr 2011 05:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=GQH0vy5KQVmTqywKh+estV277dS9g6OvuZ/LZ1ETbjI=;
        b=ocKhTIUn2WEbkjIxN/73Wyy0AbJ3ycwGZNRKGld49y6BQumIQSofgr16a92o8X5Mp6
         pTbAihCqssOnRNsQh1/MDIgxcx4KSrIEPCy6JNsxvIVqJiXFwlFfsMzaBkWcMCeSZ9NC
         cUNPphytg7nQ62kQpTdqmYSs4AoMn8fTyVR1g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=EfbnemWe4NzzvpXoghpboobwn5Yj01O0PGkFtpolG9AgC6tJUg82LYYpO84prJOhME
         VPhsOmbUx9aClMObM8DjzpftWlshRSqV0ptWRPfa9ZF1OLB6GslnVQzImTay2ldgWrLR
         LzrwbDe70PDYHl2oUDk+0U65raCh6ve131KNo=
Received: by 10.204.84.137 with SMTP id j9mr607419bkl.120.1303819745419; Tue,
 26 Apr 2011 05:09:05 -0700 (PDT)
Received: by 10.204.120.195 with HTTP; Tue, 26 Apr 2011 05:09:04 -0700 (PDT)
In-Reply-To: <AANLkTinRcmevXz3zV0wtxd7+Q3F4zcH2AZOQk1XVxYXa@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172089>

Can git have a bug tracker please?

This is another reminder to fix this bug which is otherwise untrackable=
=2E

Thanks,

Steve.

On Sun, Feb 20, 2011 at 2:17 PM, Stephen Kelly <steveire@gmail.com> wro=
te:
> bump.
>
> I don't think this issue was fixed, was it?
>
> (no need to put kdepim back in the cc list)
>
> On Sat, Jan 22, 2011 at 1:46 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> On Fri, Jan 21, 2011 at 7:37 PM, Junio C Hamano <gitster@pobox.com> =
wrote:
>>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>>
>>>> I don't fully understand the issue, so excuse me if this is totall=
y
>>>> wrong, but wouldn't a rule like 'you can't create a branch for whi=
ch
>>>> there's already a symbolic ref' do the trick?
>>>
>>> But whose symbolic ref are you checking against? =A0Your own, or on=
es in
>>> somebody else's repository that you haven't recently updated from?
>>
>> The local ones. That means that somebody can't create a 'HEAD' branc=
h
>> locally, and can't push a 'HEAD' branch either, as the remote server
>> would already have a 'HEAD' symbolic link. And actually, if for some
>> reason I have a FOO_HEAD, and I fetch a branch called bob/FOO_HEAD,
>> obviously the local symbolic ref without namespace should take
>> precedence.
>>
>> --
>> Felipe Contreras
>>
>
