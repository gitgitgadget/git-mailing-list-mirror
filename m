From: Leila <muhtasib@gmail.com>
Subject: Re: [PATCH] git-status: Show empty directories
Date: Mon, 11 Jun 2012 15:00:18 -0400
Message-ID: <CAA3EhHLfrb7VV51pEVxsi9ut3zFunbsb=MwqUGi-Yjg3uyT0qQ@mail.gmail.com>
References: <1339270806-65013-1-git-send-email-muhtasib@gmail.com>
 <7vr4tnab9e.fsf@alter.siamese.dyndns.org> <CAA3EhHLWDtUeNB+RZA064Omwxh7SEYhSc53U0nuiSTNzioKnug@mail.gmail.com>
 <7vehpl7pn0.fsf@alter.siamese.dyndns.org> <CAA3EhHLDwiCixY2xPRQOsvSv+AAKWUEWo1QgnpZrgDeeMe8wTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 11 21:00:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Se9r1-00087r-OI
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jun 2012 21:00:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750896Ab2FKTAk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Jun 2012 15:00:40 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:34071 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750782Ab2FKTAj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Jun 2012 15:00:39 -0400
Received: by vbbff1 with SMTP id ff1so2452619vbb.19
        for <git@vger.kernel.org>; Mon, 11 Jun 2012 12:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=5AH7KFjT8vNBLni54v7Sr28NWy89eQxAO+JXPM+E7Ag=;
        b=WOq5jL6H11WZpeKWUW2AeZKBEKun1rGeQOAqONd2A3Kpn4Lx5PshuBT1t9MOgaKqJV
         t3LxvFehhImrNDpEWT0R2uMmHrOSpCuZNYzX3DRPfC9lGnYbz0gIKvE3V4OIUXxmmlhg
         2ki9PulDCaDr79VenEJ2vWhwSAEURMyMpFj/LttFXmTDO6tuuzOqTDWD551IxDJwjF5Q
         Lu+shiiUnupynRbZWionMPod1A5aPRoe3lgsuRxCkBQ1NrKBeOs1qoFbSYDes1Q9Ay3E
         lDr+v33yIhZL5aPiLeQkQtgPm/UtwKTGawS19u7qktTiITQgnaGOzJ3moISXfzsKW5zV
         bhkQ==
Received: by 10.52.172.203 with SMTP id be11mr4306930vdc.40.1339441238625;
 Mon, 11 Jun 2012 12:00:38 -0700 (PDT)
Received: by 10.52.37.233 with HTTP; Mon, 11 Jun 2012 12:00:18 -0700 (PDT)
In-Reply-To: <CAA3EhHLDwiCixY2xPRQOsvSv+AAKWUEWo1QgnpZrgDeeMe8wTg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199701>

On Mon, Jun 11, 2012 at 2:51 PM, Leila <muhtasib@gmail.com> wrote:
> On Mon, Jun 11, 2012 at 12:57 PM, Junio C Hamano <gitster@pobox.com> =
wrote:
>> Leila <muhtasib@gmail.com> writes:
>>
>>>> Having said all that, I personally doubt this is a useful change. =
=A0I
>>>> may have thought of adding a README file to a relatively new proje=
ct that
>>>> does not yet have one while in shower but I haven't even created t=
he
>>>> file in the working tree. =A0And I forget about it once I get to t=
he
>>>> office. =A0Should the system remind me to create README and then a=
dd?
>>>> Your patch would not give me such a reminder once the top-level
>>>> directory is populated (because it is no longer empty). =A0Even if=
 I
>>>> were planning to add Documentation/README instead, I would get suc=
h
>>>> a reminder only if the Documentation directory is empty. Once the
>>>> directory is populated, I wouldn't get "create README and then add=
".
>>>> Why should an empty directory so special?
>> Please read what you quoted again. =A0I may have forgotten to create
>> and add README
>>
>> =A0- at the toplevel directory; or
>>
>> =A0- in the Documentation directory that already has other tracked
>> =A0 files; or
>>
>> =A0- in the Documentation directory that does not have any file yet.
>>
>> Why do I get a reminder for only the last case? =A0Also please reali=
ze
>> that at no point in the scenario I am interested in adding an empty
>> directory. =A0"How does one add empty directories" is irrelevant to =
my
>> question.
>>
>> A more reasonable answer would have been "the reminder is not about
>> a yet-to-be-created README file, but is about an empty directory you
>> might have wanted to place something---there is no way for Git to
>> guess that you wanted the new file to be README, but at least having
>> a totally empty directory laying around may be an indication that
>> you wanted to do something intereseting in it but haven't yet". =A0I=
f
>> the proposed commit log message justified the behaviour to treat
>> only the third one specially that way, I suspect it may make some
>> sense.
>
> I apologize, I misread the scenario and thought you were asking a
> different question.
>
> The patch/new implementation I put forth reminds you that you have an
> empty dir. The reminder that you have an empty dir =A0isn't about a
> yet-to-be-created README file, but about an empty directory that you
> may have wanted to do something interesting in but haven't yet (like
> create a README/some other file or delete it even). It servers as
> helpful reminder to do something with that empty dir. Is that better?

Oh and since it's not about the reminder to add a README file, it
doesn't do anything for the first 2 cases that you mention. Adding a
README is just an example of a use case for this patch.

That being said, I like the idea that you put forth about changing the
wording of the message next to the empty dir to something more
constructive or alert like, so the user can take action regarding the
empty dir.
