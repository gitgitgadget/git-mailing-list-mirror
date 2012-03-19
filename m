From: demerphq <demerphq@gmail.com>
Subject: Re: Please discuss: what "git push" should do when you do not say
 what to push?
Date: Mon, 19 Mar 2012 23:20:28 +0100
Message-ID: <CANgJU+VF-3LnwkrWgSQ1r50R=zjw8vsK1G686OqetSUGHuFcfw@mail.gmail.com>
References: <7v7gyjersg.fsf@alter.siamese.dyndns.org>
	<7vty1ndcoi.fsf@alter.siamese.dyndns.org>
	<4F6461D7.40303@pileofstuff.org>
	<7vipi1d9r7.fsf@alter.siamese.dyndns.org>
	<4F6792DE.80208@pileofstuff.org>
	<7v62e09sig.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andrew Sayers <andrew-git@pileofstuff.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 19 23:20:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9kwO-0003kC-6m
	for gcvg-git-2@plane.gmane.org; Mon, 19 Mar 2012 23:20:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757644Ab2CSWUa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Mar 2012 18:20:30 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:54925 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755736Ab2CSWU2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Mar 2012 18:20:28 -0400
Received: by yhmm54 with SMTP id m54so5973847yhm.19
        for <git@vger.kernel.org>; Mon, 19 Mar 2012 15:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=ZUhey6B3yX4HOVa3Gb52pi3LCB+rXUimzDktwuzQv0k=;
        b=QHW0S5sGpa3ZS9KGitKtyFbXAHr1IpliOvyEqZieFrOzjGzM4OzQN7Tj4FV9707H4O
         6sgklFHs0iAheeUZPs8FRm4DLzzB1btggTFBKamogoHLlrd+otj7/fkucUi93/SGz1ub
         QQc0vOi9sOZ1bGFASolsjPaK5xAquSXEyZYKYcKk5CAVpojJXrI9rAkwt2Cesrw6yC1B
         1Ykw5WOFVwN98yRS8LKGKiBhZLdZJyJjZOtTGdjcgYWiwC0loDdyzo8fNM2U949hLnsj
         X2FAAL+mmxVaModbhdi/GH4hllIYoU9hc2sxADjY9FSEAaUE6X9o7cInqLgPzYQh5Dhl
         3g3g==
Received: by 10.236.80.4 with SMTP id j4mr14035730yhe.120.1332195628066; Mon,
 19 Mar 2012 15:20:28 -0700 (PDT)
Received: by 10.236.176.1 with HTTP; Mon, 19 Mar 2012 15:20:28 -0700 (PDT)
In-Reply-To: <7v62e09sig.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193466>

On 19 March 2012 22:43, Junio C Hamano <gitster@pobox.com> wrote:
> Andrew Sayers <andrew-git@pileofstuff.org> writes:
>
>> On 18/03/12 18:50, Junio C Hamano wrote:
>>>
>>> ... but in short, it is not a problem we can solve
>>> (nor we should be solving), as long as we have a reasonable migrati=
on plan
>>> and if the user is locked out of that migration plan---whoever is d=
oing
>>> the locking-out is taking responsibility for these users who are ou=
t of
>>> our reach.
>>
>> I take the point that distros have their own support infrastructure,=
 so
>> perhaps this would be a better example:
>>
>> Many administrators in corporate environments will install git from
>> source, because they don't trust RPM/need some feature in the latest
>> version/are just that way inclined. =A0Having installed it, they ten=
d to
>> sit on that version for a few years ...
>
> The same response applies. These administrators are taking responsibi=
lity
> for their users by making them out of our reach.
>
>> ... a
>> slightly better solution:
>>
>> When a user upgrades to a mid- or post-change version of git, I thin=
k
>> it's a good idea for them to be warned about the change of behaviour=
=2E
>> But new users, and old users with new repositories, gain nothing fro=
m
>> the little history lesson.
>
> You are right for new users, but are wrong for old users who aren't a=
ware
> of the switch-over, *and* are harmed by the switch-over.

What is your definition of "harmed" in this case? I do not see how a
change like this could cause harm. I can see how it could cause
disharmony, but that is not the same. I thought the worse case here is
minor inconvenience, not data loss or anything else that is obviously
harmful.

cheers,
Yves

--=20
perl -Mre=3Ddebug -e "/just|another|perl|hacker/"
