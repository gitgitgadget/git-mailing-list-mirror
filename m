From: Michael Witten <mfwitten@gmail.com>
Subject: Re: What's in a name? Let's use a (uuid,name,email) triplet
Date: Fri, 19 Mar 2010 09:05:53 -0600
Message-ID: <b4087cc51003190805h1eb91af9wf0c8e987f9a75026@mail.gmail.com>
References: <4ba2293f.c5c2f10a.5e9c.5c4a@mx.google.com> <m3tyscjt7h.fsf@localhost.localdomain> 
	<b4087cc51003190740h680b5dech4edd7a5000f180ee@mail.gmail.com> 
	<40aa078e1003190756h190af29ao472508aaf624efe3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Fri Mar 19 16:06:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsdmM-0003dB-QD
	for gcvg-git-2@lo.gmane.org; Fri, 19 Mar 2010 16:06:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750986Ab0CSPGQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Mar 2010 11:06:16 -0400
Received: from mail-fx0-f219.google.com ([209.85.220.219]:61594 "EHLO
	mail-fx0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750705Ab0CSPGP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Mar 2010 11:06:15 -0400
Received: by fxm19 with SMTP id 19so685749fxm.21
        for <git@vger.kernel.org>; Fri, 19 Mar 2010 08:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=EpHPbkyT59OZA62B5TaWODcRVqqlqCZ3htcUIYwol/o=;
        b=k22pbC7QD90h26wCmmusQjiS5vPif1OZKx8qo7o5Ww/umGiKHaGPjBs0j3CYcjWsqo
         zmMXG1H1c9/gIFYCv28dETU2LWQc2r4N1V7WMY2ltBRbowv0nQ7a49OiPq4Rdvl/AMbD
         gu/3yPNZyoKKVpvUYR64g5vAzBts0t+brEYmc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=rz2aCAAi04kalbquOJRD9Du4R1v0ZoiCIAKMKoc2eLBGg3gdpW9GoncPLU1RshyzY0
         ska9BRkyML1CN02BabMfxPw1Bo7xCIFX7WRHZigsFqbKtIJMBhqrgo75vUI7Oc1YoLtv
         W2wtNp+jUs3ZysXET3oyGqXgHRNcqJzQAEDmY=
Received: by 10.239.190.65 with SMTP id w1mr1669079hbh.126.1269011173139; Fri, 
	19 Mar 2010 08:06:13 -0700 (PDT)
In-Reply-To: <40aa078e1003190756h190af29ao472508aaf624efe3@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142611>

On Fri, Mar 19, 2010 at 08:56, Erik Faye-Lund <kusmabite@googlemail.com=
> wrote:
> On Fri, Mar 19, 2010 at 3:40 PM, Michael Witten <mfwitten@gmail.com> =
wrote:
>> On Fri, Mar 19, 2010 at 08:08, Jakub Narebski <jnareb@gmail.com> wro=
te:
>>> First, the user.name and user.email does not need to be name and em=
ail
>>> from some email account. =C2=A0It might be some "canonical name" an=
d
>>> "canonical email".
>>
>> The vast majority of patches come in through email; the git tools
>> expect the user.name and user.email to reflect physical email accoun=
t
>> information.
>
> What git tools would that be?

Anything involving emailed patches.

> The only one I know of that does
> anything near assuming that is git send-email, and it only uses
> user.email if neither sendemail.from is configured nor --from option
> is specified. And even when it does, it prompts the user so it can be
> changed if called from a terminal. So I wouldn't say that it assumes
> anything about the "physicalness" of user.email, it just uses it's as
> the most sane default unless anything else has been specified.

It's useless to spoof the From field because many email services won't
send it, a point I already covered in the email you quoted.

When a patch is finally emailed, it's the From field that is used for
Author attribution.

You see? Your identity has been tied to whatever email service you
happen to use at any given time rather than to something with more
long term stability.
