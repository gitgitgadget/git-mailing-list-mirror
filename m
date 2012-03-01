From: Andrew Ardill <andrew.ardill@gmail.com>
Subject: Re: Why Is There No Bug Tracker And Why Are Patches Sent Instead Of
 Pull Requests
Date: Thu, 1 Mar 2012 12:20:52 +1100
Message-ID: <CAH5451krbyZCRm8JR+kf+8cDqkbnQKnzXGxmncmRF9YPXvckNA@mail.gmail.com>
References: <CAM=oOO2i-9zraF-YG5YzvZEmN1eXTnQfhJ-eMF04NP7HGtf41w@mail.gmail.com>
 <7vhay9tqs6.fsf@alter.siamese.dyndns.org> <20120229225304.GA9099@burratino>
 <CAH5451miv_Mo_9tZV+mfDEHuEX0491duqAYh66aOzLsMLTNkaA@mail.gmail.com>
 <rmifwdti2ap.fsf@fnord.ir.bbn.com> <CAH5451kWaRGutP1esuvjSK-arrEc=5m-SDwVHACx6QF9JFj-MQ@mail.gmail.com>
 <7vaa41qgf4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Greg Troxel <gdt@ir.bbn.com>, Jonathan Nieder <jrnieder@gmail.com>,
	opticyclic <opticyclic@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 01 02:21:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2uhr-0005yL-Og
	for gcvg-git-2@plane.gmane.org; Thu, 01 Mar 2012 02:21:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757956Ab2CABVO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Feb 2012 20:21:14 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:53148 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755762Ab2CABVN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Feb 2012 20:21:13 -0500
Received: by wejx9 with SMTP id x9so32395wej.19
        for <git@vger.kernel.org>; Wed, 29 Feb 2012 17:21:12 -0800 (PST)
Received-SPF: pass (google.com: domain of andrew.ardill@gmail.com designates 10.180.104.4 as permitted sender) client-ip=10.180.104.4;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of andrew.ardill@gmail.com designates 10.180.104.4 as permitted sender) smtp.mail=andrew.ardill@gmail.com; dkim=pass header.i=andrew.ardill@gmail.com
Received: from mr.google.com ([10.180.104.4])
        by 10.180.104.4 with SMTP id ga4mr21803306wib.17.1330564872745 (num_hops = 1);
        Wed, 29 Feb 2012 17:21:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=r14vfxIgWp7v9MY47g85EeZQnSF7My+LzEjislmAlnk=;
        b=UGg+NvkFPrxA2t5Q6hH+lUm0N56qSsN/alEFdP3pU6A2v50SZT/J1qhp4/rLFBc0Yz
         TNDWD6lWZUHuerp2ubdFcTLGrp3pSzaHLGv78pa/poYHbY0/yvIRx3IUqkCUUimXsGfr
         pmRJXusla6vKboItBxusN2Nyrb1EXwTMwvkjE=
Received: by 10.180.104.4 with SMTP id ga4mr17439372wib.17.1330564872700; Wed,
 29 Feb 2012 17:21:12 -0800 (PST)
Received: by 10.223.96.133 with HTTP; Wed, 29 Feb 2012 17:20:52 -0800 (PST)
In-Reply-To: <7vaa41qgf4.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191872>

On 1 March 2012 12:05, Junio C Hamano <gitster@pobox.com> wrote:
> Andrew Ardill <andrew.ardill@gmail.com> writes:
>
>> On 1 March 2012 11:37, Greg Troxel <gdt@ir.bbn.com> wrote:
>>>
>>> Do people really think it's reasonable to use non-Free tools to dev=
elop
>>> git? That seems surprising to me.
>>
>> Maybe not, and if that is the case I am more than happy to let this =
die.
>
> I won't speculate how big or small part of the Git community you woul=
d be
> repelling by using a closed/commertial offering. It may not be such a=
 big
> deal, or it may be. I simply do not know.

Neither do I - let's find out!

> But we will never find out until we try. The same thing can be said f=
or
> the usefulness of having a bug tracker and feasibility of keeping it
> reasonably clean and useful over time with volunteer effort. =C2=A0I =
commend
> you for finally stepping up and biting the bullet to start an experim=
ent.

I have been meaning to get this going for a few months now, the latest
thread kickstarted me again.

> One request I may have is to give read/browse-only access to unregist=
ered
> users without any account (I hate having to maintain credentials to r=
andom
> websites, and I imagine so do many other people), but I am not the ta=
rget
> audience, so please do not bend backwards to implement such if it is =
too
> much trouble with the system.
>
> Thanks.

I have given browse access by default to Anyone (does not require
log-in). JIRA is highly customisable, so most requests are typically
feasible.

Regards,

Andrew Ardill
