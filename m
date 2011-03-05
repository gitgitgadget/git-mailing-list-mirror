From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: Re: [PATCH] Add link to git-cherry(1) in git-cherry-pick(1)
Date: Sat, 5 Mar 2011 20:26:25 +0100
Message-ID: <AANLkTikumH9gSMtJO2FR=oGPh4NP-xEYYxdcv8heH9J1@mail.gmail.com>
References: <4D728A6A.8090507@gmail.com>
	<AANLkTi=QZhtByUe5h5w1MFrQ703MsWpoWHZcxvFsvNZk@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 05 20:26:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pvx7Y-0000oH-Rk
	for gcvg-git-2@lo.gmane.org; Sat, 05 Mar 2011 20:26:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754008Ab1CET01 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 Mar 2011 14:26:27 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:64998 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753897Ab1CET01 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Mar 2011 14:26:27 -0500
Received: by vxi39 with SMTP id 39so2866545vxi.19
        for <git@vger.kernel.org>; Sat, 05 Mar 2011 11:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:content-type:content-transfer-encoding;
        bh=hwojR8/ub0akbFdJfCL+BOm8Hu1FaRyYqww9j4dqX3A=;
        b=rPQpS1n2AFMj/bhdyqVy3q1W4Xi9zvN1wfWNxvl6la0FiJ2Xp5GQ/+6gdgnsqlez2q
         kEAtGzkU/ROrPHW/HG00gUIhF7Ajx5X04CKiyY/kmj/abqaIo3am5jYkpoz96GE9uEWm
         b6knhT5XfnWf1YmvyZhBeycj3VN0nVFhjBcyk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=ErT0yV7o6WOmvix4ByMpdW8DHqDjne8wdZK4da2hTHp8fjWzXUVL/Xl3jBVF2cEgzo
         vd5g+a/MPamQpSc2FAhdZeGKHJ8afpbNmGmphTcRGxD+CZY4O9t40AnkGZP6y4QXqSnH
         UYy1ryoxXfnNrTXJsdIZTwMug011JI3Lcm8zk=
Received: by 10.220.191.74 with SMTP id dl10mr556146vcb.104.1299353185977;
 Sat, 05 Mar 2011 11:26:25 -0800 (PST)
Received: by 10.220.61.140 with HTTP; Sat, 5 Mar 2011 11:26:25 -0800 (PST)
In-Reply-To: <AANLkTi=QZhtByUe5h5w1MFrQ703MsWpoWHZcxvFsvNZk@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168506>

Ignore that - I didn't understand how the 'cherry' works.

Anyway, two questions:
1. is there a reason why git-cherry is separate command and not part
of git-branch?
2. is there a way to make gitk show cherry-picks (or plans for implemen=
ting it)?


On Sat, Mar 5, 2011 at 8:12 PM, Piotr Krukowiecki
<piotr.krukowiecki@gmail.com> wrote:
> Hm now I started to wonder: is git cherry the same as git branch --co=
ntains?
>
> On Sat, Mar 5, 2011 at 8:09 PM, Piotr Krukowiecki
> <piotr.krukowiecki@gmail.com> wrote:
>>
>> Signed-off-by: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
>> ---
>> =A0Documentation/git-cherry-pick.txt | =A0 =A02 +-
>> =A01 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-c=
herry-pick.txt
>> index 749d68a..c078cc9 100644
>> --- a/Documentation/git-cherry-pick.txt
>> +++ b/Documentation/git-cherry-pick.txt
>> @@ -162,7 +162,7 @@ Documentation by Junio C Hamano and the git-list=
 <git@vger.kernel.org>.
>>
>> =A0SEE ALSO
>> =A0--------
>> -linkgit:git-revert[1]
>> +linkgit:git-revert[1], linkgit:git-cherry[1]
>>
>> =A0GIT
>> =A0---
>> --
>> 1.7.4.1.179.gb9a20
>>
>> --
>> Piotr Krukowiecki
>>
>
>
>
> --
> Piotrek
>



--=20
Piotrek
