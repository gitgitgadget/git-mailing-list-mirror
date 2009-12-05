From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Gui criticism
Date: Sat, 5 Dec 2009 22:25:59 +0200
Message-ID: <94a0d4530912051225y2d193a1fqfb38ebcce95719c3@mail.gmail.com>
References: <loom.20091205T194800-496@post.gmane.org>
	 <94a0d4530912051137u682a3a99ved9d19338b881b13@mail.gmail.com>
	 <7v3a3prxdt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ram Rachum <cool-rr@cool-rr.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 05 21:26:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NH1Cg-00027k-Qo
	for gcvg-git-2@lo.gmane.org; Sat, 05 Dec 2009 21:26:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755679AbZLEUZy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 Dec 2009 15:25:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755533AbZLEUZy
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Dec 2009 15:25:54 -0500
Received: from mail-iw0-f171.google.com ([209.85.223.171]:44666 "EHLO
	mail-iw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755287AbZLEUZx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Dec 2009 15:25:53 -0500
Received: by iwn1 with SMTP id 1so2296287iwn.33
        for <git@vger.kernel.org>; Sat, 05 Dec 2009 12:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=v7LAF3Wgptbkg8W5FbxnF2Dd1Jr4rXgfBSY49KH7mn4=;
        b=todhjirP20w6WgQtmbNTGnX7gu90eOxJx/ILEvZBiiBEdj7nMQGLb/i382aqBTMJjw
         BxWWRmqJYBhyR9H3oGvTGe5/crzu3J7Y30H2e0tSgOStcA4z8u5GaV9bRk/U9T6yDipr
         77qVNKDGI39F3rTz01442Be+xwF9FYroAUoxA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=VBpzZbWe5IqiF+0cxRZrFfV5yitrDeo1etE/FDhLejVqcq26sBroEyeFEO/U3DJvJK
         Cz3fbzyTDByAr/LZ8f27Ieny0MgkZWKVFI+/pUZv0nd3NM4mGQrMiFmH/Fo8cH/oWsI+
         sGRy943wDX+cxBEKnbdUc5l6qs7X5y3W1s7IU=
Received: by 10.231.120.136 with SMTP id d8mr3099712ibr.14.1260044759862; Sat, 
	05 Dec 2009 12:25:59 -0800 (PST)
In-Reply-To: <7v3a3prxdt.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134620>

On Sat, Dec 5, 2009 at 10:14 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> I don't think the mailing list is the best place for this, that's wh=
y
>> I just started a project in SourceForge, so that users can post thes=
e
>> kinds of issues in the ideatorrent:
>> https://sourceforge.net/apps/ideatorrent/git-ux/ideatorrent/
>
> Two issues and a half offhand after entering one:
>
> =C2=A0- I found the experience of adding an "idea" too clunky and slo=
w.
> =C2=A0 Writing a well thought out e-mail can be done in the same time=
=2E

Yeah, I agree; it's too slow right now, but it's the only way I've
found to host some kind of ideastorm.

The difference with e-mails is that ideas get votes, which helps to
find out what users really want:
http://brainstorm.ubuntu.com/

Also, the main action to do in this system should be "vote", that's
the action that should be fast.

> =C2=A0- Although enforcing a minimum structure of "idea" description =
is a good
> =C2=A0 thing to do, I found the current structure presented by that w=
eb page
> =C2=A0 lacks focus. =C2=A0It has problem description and a rather bro=
ad and vague
> =C2=A0 "idea", and it feels to me that it is promoting entering any g=
arbage
> =C2=A0 without discussing feasibility, "pros-and-cons" or necessary s=
teps to
> =C2=A0 achieve a particular goal.

That's why ideas go to a sandbox, and then maintainers approve or rejec=
t them.

> =C2=A0- The largest issue of this kind of system is who will be moder=
ating and
> =C2=A0 how capable they are.

Indeed, that's one issue, but also, it needs a large inflow of votes,
and when popular ideas are identified, then it needs people to
actually implement them.

--=20
=46elipe Contreras
