From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: What's in a name? Let's use a (uuid,name,email) triplet
Date: Fri, 19 Mar 2010 08:25:28 -0400
Message-ID: <9e4733911003190525m552a400exdd7fb3f6c88cc4ca@mail.gmail.com>
References: <4ba2293f.c5c2f10a.5e9c.5c4a@mx.google.com>
	 <4BA338C1.7030803@alum.mit.edu>
	 <b4087cc51003190439x3c9ff269g35d11432bd2a3d60@mail.gmail.com>
	 <alpine.DEB.2.00.1003190441530.3821@asgard.lang.hm>
	 <20100319115445.GA12986@glandium.org>
	 <3f4fd2641003190509j6e4908e4kab87b601d2ce9c00@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mike Hommey <mh@glandium.org>, david@lang.hm, git@vger.kernel.org
To: Reece Dunn <msclrhd@googlemail.com>
X-From: git-owner@vger.kernel.org Fri Mar 19 13:25:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsbGk-0002s0-RT
	for gcvg-git-2@lo.gmane.org; Fri, 19 Mar 2010 13:25:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751962Ab0CSMZa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Mar 2010 08:25:30 -0400
Received: from mail-qy0-f182.google.com ([209.85.221.182]:50336 "EHLO
	mail-qy0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751627Ab0CSMZa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Mar 2010 08:25:30 -0400
Received: by qyk12 with SMTP id 12so952085qyk.5
        for <git@vger.kernel.org>; Fri, 19 Mar 2010 05:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=QE7YCOMZ6nK8FUrXqoe5ET8UqnaOy8HcCisbsJUgCUI=;
        b=LKyGQhnAV+Pcp1d0CT9efvV6/sb7ZEfsR7zbS5XEGVa4WNutu9dJd8911MltJlsZy1
         5UbAF0ZllJ5oHR7IcRJxmgV6HsDWvINAoVpbn2Dzc5W69cnMYe8acKYMG0RT5WU+Xbst
         DImvlr8baqfp54WnA2Wp5tWftfD0ySt/+6xz8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=tW5g5tA7oSR5vCTg2Mi4fraaKM9MGYzU6fsgVcKsmY7dm/QrCDVWw62UYhMZTzhPQg
         r5vDtqWHqkC2BTzya4m1mafUgOK+RD7tiv7z/EEoOf4l8THP/AF8XjFHr5s0O2E35nCT
         ZIDF5RNDrDbvL+Us4ZEIYUimlkNMpt4+uuP3s=
Received: by 10.229.221.14 with SMTP id ia14mr4119316qcb.8.1269001528280; Fri, 
	19 Mar 2010 05:25:28 -0700 (PDT)
In-Reply-To: <3f4fd2641003190509j6e4908e4kab87b601d2ce9c00@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142583>

On Fri, Mar 19, 2010 at 8:09 AM, Reece Dunn <msclrhd@googlemail.com> wr=
ote:
> On 19 March 2010 11:54, Mike Hommey <mh@glandium.org> wrote:
>> On Fri, Mar 19, 2010 at 04:45:38AM -0700, david@lang.hm wrote:
>>> here is where you are missing the point.
>>>
>>> no, there is not 'much less chance' of it getting messed up.
>>>
>>> you seem to assume that people would never need to set the UUID on
>>> multiple machines.
>>>
>>> if they don't need to set it on multiple machines, then the
>>> e-mail/userid is going to be reliable anyway
>>>
>>> if they do need to set it on multiple machines and can't be bothere=
d
>>> to keep their e-mail consistant, why would they bother keeping this
>>> additional thing considtant? Linus is pointing out that people don'=
t
>>> care now about their e-mail and name, and will care even less about
>>> some abstract UUID
>>>
>>> people who care will already make their e-mail consistant.
>>
>> While I don't agree with the need for that uuid thing, I'd like to
>> pinpoint that people who care can't necessarily make their e-mail
>> consistant. For example, Linus used to use an @osdl.org address, and
>> he now uses an @linux-foundation.org address. It's still the same Li=
nus,
>> but the (name, email) pair has legitimately changed.
>
> So create an aliases list that maps one (name,email) to another that
> is from the same person. There is no need for an additional item (a
> uuid) to solve this problem. It also means that searching on any
> (name,email) pair will find the others, so you only need to
> remember/find one of the identities for the person you are interested
> in finding the commits for.

git already supports aliases via the .mailmap file. Pick one
name/address pair that you like and then use .mailmap to map all of
the variations into the primary one. Granted some git tools don't
process .mailmap, but it is easier to fix the tools that create a new
ID system.

Look at the .mailmap in the current kernel tree. It fixes a few
problems. I have a much larger one that fixes most address issues.

You don't need to reimplement this aliases, they are already in git.


>
> AFAICS, mailmap is about correcting mistakes (primarily in the
> reported name for a given email address). In this case, mailmap and
> this aliases-map will work in conjunction with each other to give wha=
t
> the original poster wanted. However, I haven't seen any of his replie=
s
> that answer this (or sufficiently address why mailmap does not solve
> his problem).
>
> - Reece
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>



--=20
Jon Smirl
jonsmirl@gmail.com
