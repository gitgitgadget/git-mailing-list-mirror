From: "jamesmikedupont@googlemail.com" <jamesmikedupont@googlemail.com>
Subject: Re: Introduction and Wikipedia and Git Blame
Date: Fri, 16 Oct 2009 23:19:03 +0200
Message-ID: <ee9cc730910161419x608f5972x705ce8088d72c94a@mail.gmail.com>
References: <ee9cc730910160207x49feb40ej692188abb0a57473@mail.gmail.com>
	 <alpine.DEB.1.00.0910161321550.4985@pacific.mpi-cbg.de>
	 <ee9cc730910160443k7e5f718bs964923a796cf38d1@mail.gmail.com>
	 <alpine.DEB.1.00.0910161548550.4985@pacific.mpi-cbg.de>
	 <7vbpk7w9qx.fsf@alter.siamese.dyndns.org>
	 <ee9cc730910161100r71818303v343f555151db4dcc@mail.gmail.com>
	 <7v7huvuptn.fsf@alter.siamese.dyndns.org>
	 <7vpr8nt894.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 16 23:19:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyuCe-0007jR-Ny
	for gcvg-git-2@lo.gmane.org; Fri, 16 Oct 2009 23:19:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751498AbZJPVTB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Oct 2009 17:19:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751341AbZJPVTA
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Oct 2009 17:19:00 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:33457 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751286AbZJPVTA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Oct 2009 17:19:00 -0400
Received: by fxm18 with SMTP id 18so2923644fxm.37
        for <git@vger.kernel.org>; Fri, 16 Oct 2009 14:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=GlrtuTKk1yqqYr7qSjwZPMQXMFHAVBeXE+4dct0F5Xc=;
        b=ODw9RvmjN0PjXS6pjjQl4LK/vLcuxZHH9jIeyqE/EGzgCK4d0qJf6+vZVpUpel4nKJ
         +FlJOyu58k29lsR3uCW/CXhfKeoz7u//EpSmw+NmY0QE5I0y5BA/WfMxmvq0vOlmLDAt
         htoLsAiNMq+lLdqM0QPSgw/JcPihB57j/eYcY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=NWH3lSTFP6495x6g5toRAzIPKxIPMHmaOhUrUyEiLJ153v8SDRfqjDPnPahbEBg3vb
         K90lq7OGkTMmgq8euWUyOFS1KMvzSrnEHPgYzYY8iUJSwSI5WdeqIKGDIDw0unsEdrva
         Z+mkYt/TFTgqpeDcASvJOHuwbJvm5i3UK5NRg=
Received: by 10.204.160.85 with SMTP id m21mr1800908bkx.175.1255727943420; 
	Fri, 16 Oct 2009 14:19:03 -0700 (PDT)
In-Reply-To: <7vpr8nt894.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130528>

What do you think of my idea to create blames along a specific user
defined byte positions ?
please review my suggestion and comment.

mike

On Fri, Oct 16, 2009 at 10:05 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> "jamesmikedupont@googlemail.com" <jamesmikedupont@googlemail.com> wr=
ites:
>>
>>>> You would need to postprocess the computed result (either by diff =
or
>>>> blame) to lay out the final text output in either case anyway, and=
 making
>>>> the existing blame engine do the work for you would be a better ap=
proach,
>>>> I think.
>>>
>>> Please can you tell me what is the basic algorithm of the blame eng=
ine?
>>
>> I think this is one of the most conprehensive write-up on the algori=
thm:
>>
>> =A0 http://thread.gmane.org/gmane.comp.version-control.git/28826/foc=
us=3D28895
>>
>> The whole thread (at least what I wrote in it) is worth reading if y=
ou
>> want to understand what the current code does. =A0The first message =
in the
>> thread talks about "NEEDSWORK" label on an unimplemented part of the=
 code,
>> and says "we could", but these gaps were since filled.
>
> Ah, nevermind. =A0The thread is the definitive description of the bla=
me
> algorithm, but I agree with Dscho that in this case, you either have =
to
> change blame itself to do this "byte-wise" comparison internally betw=
een
> versions, or re-do the blame logic yourself like Dscho suggests. =A0D=
scho is
> right in this case; an unmodifled blame engine, unless you feed a his=
tory
> that is converted to use the byte-per-line format, won't help you at =
all.
>
> So it would be either between rolling a custom byte-wise blame algori=
thm
> yourself and teaching a new byte-wise mode to existing blame engine.
> Sorry for making the task sound much easier than it would be.
>
>
>
