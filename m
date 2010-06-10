From: Diane Gasselin <diane.gasselin@ensimag.imag.fr>
Subject: Re: [RFC/ PATCH 4/5] t3030: update porcelain expected message
Date: Thu, 10 Jun 2010 09:47:10 +0200
Message-ID: <AANLkTikwLq2KDnMfATULa1cDzjrzWErqDrLfRlWr1CEl@mail.gmail.com>
References: <1276087446-25112-1-git-send-email-diane.gasselin@ensimag.imag.fr> 
	<1276087446-25112-2-git-send-email-diane.gasselin@ensimag.imag.fr> 
	<1276087446-25112-3-git-send-email-diane.gasselin@ensimag.imag.fr> 
	<1276087446-25112-4-git-send-email-diane.gasselin@ensimag.imag.fr> 
	<1276087446-25112-5-git-send-email-diane.gasselin@ensimag.imag.fr> 
	<1276087446-25112-6-git-send-email-diane.gasselin@ensimag.imag.fr> 
	<vpq1vcgym6j.fsf@bauges.imag.fr> <20100610015919.GA32671@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org,
	Axel Bonnet <axel.bonnet@ensimag.imag.fr>,
	=?ISO-8859-1?Q?Cl=E9ment_Poulain?= 
	<clement.poulain@ensimag.imag.fr>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 10 09:47:38 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMcUC-0000sw-DD
	for gcvg-git-2@lo.gmane.org; Thu, 10 Jun 2010 09:47:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755099Ab0FJHr1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Jun 2010 03:47:27 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:56953 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752633Ab0FJHr0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Jun 2010 03:47:26 -0400
Received: by fxm8 with SMTP id 8so4045639fxm.19
        for <git@vger.kernel.org>; Thu, 10 Jun 2010 00:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:sender:received
         :in-reply-to:references:from:date:x-google-sender-auth:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=8XieDYyt833XQN1yOCEDeYG8N/yRhtUgQDCOrX3gvog=;
        b=aY/Q5NkG62FEqL9Q7sCBEMNyWc+xyhu9hhhIMY49bNwd7izrySci8riZqK6thciaaz
         bbUH8DyPy1AOYLrxiZDJpx+dBoGFfJ2hY8/SPVi9oTZTGgomyI8zgEJMqgG209ijTRFh
         ipv92mtYeR6yJRYc1UbFy/ahCZpsyvWFGB2T0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=WeMXDJcmsKYJd6e3g3j9mSBqHJAlQ9ZOmfH3ACf+yZOFY4BenST7WBxSMijHXG0WMb
         ajWXoEHHsdpVYxx1o9ZyQg6kV7i/MNm6EdCkNMEtgHd9G/M/wrQgY9U+JPXsA5O7lkks
         dO8AxI36WMpDnDuv/dKcEOSvxSYCon7V7upYM=
Received: by 10.239.132.203 with SMTP id 11mr1371819hbs.80.1276156045155; Thu, 
	10 Jun 2010 00:47:25 -0700 (PDT)
Received: by 10.239.172.204 with HTTP; Thu, 10 Jun 2010 00:47:10 -0700 (PDT)
In-Reply-To: <20100610015919.GA32671@coredump.intra.peff.net>
X-Google-Sender-Auth: 2z0mR1FJsTHVIPNEV_a_XWLtXPo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148838>

Le 10 juin 2010 03:59, Jeff King <peff@peff.net> a =E9crit :
> On Wed, Jun 09, 2010 at 10:40:20PM +0200, Matthieu Moy wrote:
>
>> Diane Gasselin <diane.gasselin@ensimag.imag.fr> writes:
>>
>> > From: Diane <diane.gasselin@ensimag.imag.fr>
>>
>> You did something strange with git format-patch or send-email. This
>> From header should appear in the header of your email, but not in th=
e
>> body.
>
> The commit author is missing the last name, so send-email correctly
> includes the extra "From" header. Probably the user.name config varia=
ble
> needs updated (and the commit can be rebased and amended with
> --reset-author to take the new author).
>
I had my user name changed at a moment so I thought maybe it was due to=
 that.
Thanks for the tip

>> > +cat> expected2 <<EOF
>> > +error: Your local changes to the files:
>> > + =A0 a
>> > +would be overwritten by merge.
>> > +EOF
>>
>> I'd have phrased it like this:
>>
>> error: Your local changes to these files would be overwritten by mer=
ge:
>> =A0 =A0 =A0 a
>>
>> to avoid splitting the message in two parts. It's more consistant wi=
th
>> the rest of Git (git status or git reset for example). Also, your
>> version would become hard to read if the file list is long.
>
> Yes, I think your version is much more readable.
>
> -Peff
>
Yes, I changed it. It makes grep much more easier for the tests.
=46or some errors, if in porcelain, the order of the arguments file and
action needs to be reversed but this is not a problem.
