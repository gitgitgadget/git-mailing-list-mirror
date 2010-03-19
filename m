From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: What's in a name? Let's use a (uuid,name,email) triplet
Date: Fri, 19 Mar 2010 16:25:26 +0100
Message-ID: <40aa078e1003190825j57ba4a0axbb4d2bf7cbdb32d0@mail.gmail.com>
References: <4ba2293f.c5c2f10a.5e9c.5c4a@mx.google.com>
	 <m3tyscjt7h.fsf@localhost.localdomain>
	 <b4087cc51003190740h680b5dech4edd7a5000f180ee@mail.gmail.com>
	 <40aa078e1003190756h190af29ao472508aaf624efe3@mail.gmail.com>
	 <b4087cc51003190805h1eb91af9wf0c8e987f9a75026@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 19 16:25:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nse4s-0006rl-VG
	for gcvg-git-2@lo.gmane.org; Fri, 19 Mar 2010 16:25:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751520Ab0CSPZ3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Mar 2010 11:25:29 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:63397 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751052Ab0CSPZ1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Mar 2010 11:25:27 -0400
Received: by wyb38 with SMTP id 38so1568575wyb.19
        for <git@vger.kernel.org>; Fri, 19 Mar 2010 08:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=091VfDhQ11sFk9Q3uVWfktt6tbCryuRDp4EDX8bKLyo=;
        b=MuLx/XpEI6b8B5DdPWvrNY4yz8YnV4LZS8wMPeGj3eKMOBZrzBYf5n8KXeBKE4ybHl
         wkPK/1eYpwEg3hxLoeAKET1Ryr88Td8IUpgh7FCRbe5g2aH3+bwn7zUbYsd0ADnkHkM+
         oPe2otEiPTXoKSbkdvo1JTXWwOGxo4OLIuDqM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=ck+0C+hzODiEpgj2Rv3Y0KQLCAx7kQhd/ke5BpDIsP/t9Ta7gryBEflW+9gwsxv360
         Dd5SQS49V4r5PML/7g4ZpH0VsjvSqq5LqgoNMQH8kUgPF+b9qKNrg114jZBGAWVhqt/F
         Id7teKP5sfWyr0OlkPzVTvxR8+fR6PThTPDQs=
Received: by 10.216.86.142 with SMTP id w14mr1274384wee.33.1269012326319; Fri, 
	19 Mar 2010 08:25:26 -0700 (PDT)
In-Reply-To: <b4087cc51003190805h1eb91af9wf0c8e987f9a75026@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142614>

On Fri, Mar 19, 2010 at 4:05 PM, Michael Witten <mfwitten@gmail.com> wr=
ote:
> On Fri, Mar 19, 2010 at 08:56, Erik Faye-Lund <kusmabite@googlemail.c=
om> wrote:
>> On Fri, Mar 19, 2010 at 3:40 PM, Michael Witten <mfwitten@gmail.com>=
 wrote:
>>> On Fri, Mar 19, 2010 at 08:08, Jakub Narebski <jnareb@gmail.com> wr=
ote:
>>>> First, the user.name and user.email does not need to be name and e=
mail
>>>> from some email account. =A0It might be some "canonical name" and
>>>> "canonical email".
>>>
>>> The vast majority of patches come in through email; the git tools
>>> expect the user.name and user.email to reflect physical email accou=
nt
>>> information.
>>
>> What git tools would that be?
>
> Anything involving emailed patches.

Which are...?

>
>> The only one I know of that does
>> anything near assuming that is git send-email, and it only uses
>> user.email if neither sendemail.from is configured nor --from option
>> is specified. And even when it does, it prompts the user so it can b=
e
>> changed if called from a terminal. So I wouldn't say that it assumes
>> anything about the "physicalness" of user.email, it just uses it's a=
s
>> the most sane default unless anything else has been specified.
>
> It's useless to spoof the From field because many email services won'=
t
> send it, a point I already covered in the email you quoted.
>
> When a patch is finally emailed, it's the From field that is used for
> Author attribution.

The From-field isn't assumed to be a physical-address, but the
=46rom-header is. If the From-field and the From-header are identical,
the From-field doesn't get emitted. This is the same mechanism that is
used when people forward patches from other authors, and there's no
attempts to validate the From-field, only the From-header.

So no, the author-email shouldn't need to be a physical address as far
as send-email is concerned.

--=20
Erik "kusma" Faye-Lund
