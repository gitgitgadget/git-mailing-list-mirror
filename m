From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH RFC/RFD] clone: quell the progress report from init
Date: Tue, 30 Mar 2010 10:43:03 +0200
Message-ID: <81b0412b1003300143s55a93fcqf9a6d5d727a4e786@mail.gmail.com>
References: <4BAB2234.4070202@drmicha.warpmail.net>
	 <7b9006620fab4214ee0db53ebc9e0caffc397959.1269506526.git.git@drmicha.warpmail.net>
	 <7veij6lvze.fsf@alter.siamese.dyndns.org>
	 <alpine.LFD.2.00.1003261611130.694@xanadu.home>
	 <7v7houxu8n.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@fluxnic.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>,
	Neal Kreitzinger <neal@rsss.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 30 10:44:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwX2l-0000Rr-CY
	for gcvg-git-2@lo.gmane.org; Tue, 30 Mar 2010 10:43:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755820Ab0C3InK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 30 Mar 2010 04:43:10 -0400
Received: from mail-bw0-f209.google.com ([209.85.218.209]:59650 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754186Ab0C3InI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Mar 2010 04:43:08 -0400
Received: by bwz1 with SMTP id 1so4167883bwz.21
        for <git@vger.kernel.org>; Tue, 30 Mar 2010 01:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=3osQW4n5WWB0UczkAlWpTQbKjk0UqohuunNVChVXM8Y=;
        b=a7SPGdSyiausgN9Cia5hX45/pAdRDzPf/kt43KdS25vMKyaaSeJRJUTTf/zOIkNOUc
         FOAHCyWaCmxetYsS1XFUcT9Umfw90h82XecIaFpZMiOwqDKdl+/9gdaheoKyEOd19ah6
         /2wCCe9Uar5PboGtPu9eoWGgajllh8jychpB0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=fwIZ0xt2xLyImLT9vyAJJAR/tV6v+Hw9DvbJ0+YEOp+3Vr4LNfgWgIMy4SLD4VCRpw
         yqFcKTZbt9MAkysGStGeaYspPtlUZTGi6v7uihkSb+Au5Jv40coOLl57O3i31qGhKM7s
         OJZ5q2Hd2drkTP9ovIWuegjOSBtUY2z9ovOU8=
Received: by 10.204.112.77 with HTTP; Tue, 30 Mar 2010 01:43:03 -0700 (PDT)
In-Reply-To: <7v7houxu8n.fsf@alter.siamese.dyndns.org>
Received: by 10.204.81.145 with SMTP id x17mr1085392bkk.31.1269938583817; Tue, 
	30 Mar 2010 01:43:03 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143555>

On Tue, Mar 30, 2010 at 07:18, Junio C Hamano <gitster@pobox.com> wrote=
:
> Nicolas Pitre <nico@fluxnic.net> writes:
>
>> Personally I like your suggestion above. =C2=A0A clone is not someth=
ing you
>> perform repeatedly, and it is the first thing that random people tol=
d to

Well, I have git clone in my top-20 used commands. I'm reasonably sure
it is used many times in a row too.

>> use Git to grab a piece of code will do. =C2=A0Better give them some=
 comfort
>> by telling them what is happening.
>
> Here is what such a change may look like. =C2=A0I'll leave adjusting
> documentation (namely, tutorials) and perhaps tests as an exercise to=
 the
> readers ;-)

There still is no way to make things quiet by default.

And at least for me the annoyance was when using it in command line,
interactively. So yes, it makes it possible to make clone quieter, but =
I
wont use it, because I have to either make an alias for git (and that
on every system I might come upon), or type in "-q" every time, at whic=
h
case I can also live with a little more output.

But even if it is of no immediate use to me personall, I still like the=
 patch:
now I can make some scripts quieter (with less risk of removing somethi=
ng
interesting by piping everything to /dev/null).
