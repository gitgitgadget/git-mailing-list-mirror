From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/2] format-patch: fix dashdash usage
Date: Fri, 27 Nov 2009 01:23:01 +0200
Message-ID: <94a0d4530911261523q25147f12h2e6c9e4fe4f6b12b@mail.gmail.com>
References: <1259262720-24077-1-git-send-email-felipe.contreras@gmail.com>
	 <1259262720-24077-2-git-send-email-felipe.contreras@gmail.com>
	 <7vd4355aaw.fsf@alter.siamese.dyndns.org>
	 <94a0d4530911261414o533aa108l202d4c6926da361e@mail.gmail.com>
	 <7v7htc3mqo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 27 00:23:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDngE-0001M0-3M
	for gcvg-git-2@lo.gmane.org; Fri, 27 Nov 2009 00:23:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753362AbZKZXW4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Nov 2009 18:22:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753336AbZKZXW4
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Nov 2009 18:22:56 -0500
Received: from mail-iw0-f171.google.com ([209.85.223.171]:40456 "EHLO
	mail-iw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753192AbZKZXWz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Nov 2009 18:22:55 -0500
Received: by iwn1 with SMTP id 1so671332iwn.33
        for <git@vger.kernel.org>; Thu, 26 Nov 2009 15:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=162MX2sVQEGrngX6b2/9oUjzVeAHYvIOj8myPEVw/IY=;
        b=MDnx6mHnMPMQn57NrWj2vW4/wNml/4sRhQv//cHLtSM9QlafLeBmvrTopPR6enTZNJ
         bWrhdCOy/acBWrCS1UyH7o1TD2aV7Z/GMSqQpWdsm27xHHZ3EcWZp/czW6zet1/tHhPo
         U9woZWwycxP6f6YjQ6xopLcEsYD7EQKpjyydk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=MPANSDWzJBYfGoK62EHb0zyEeXKtSSdKwoxBL7CxEGk9oju8mrPTh3mCbYJu12inqz
         zRktgT9d2XJESD4d0UgUHmDrJwS94KNCvM3vXgGh3/gqOddggZMxc622SFjkNiAC5jLc
         GKdA8B5Lpi2C1j4nd3kqmJBoRM9DeBOpiB/24=
Received: by 10.231.120.84 with SMTP id c20mr661531ibr.47.1259277781562; Thu, 
	26 Nov 2009 15:23:01 -0800 (PST)
In-Reply-To: <7v7htc3mqo.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133846>

On Fri, Nov 27, 2009 at 1:11 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Is it clearer what I meant? =C2=A0More importantly, did I get the det=
ails
> right?

Yeah, I guess so.

> Hmm, I have not seen a clear "yes, because..." yet.

I'll repeat:
Not everyone has clean branches only with pertinent patches.

That's why revision filtering options make sense.

> For one thing, Documentation/git-format-patch.txt does not even hint =
that
> you can give pathspecs. =C2=A0builtin_format_patch_usage[] doesn't, e=
ither. =C2=A0As
> I wrote the initial version of format-patch I can say with some autho=
rity
> that use with pathspecs were never meant to be supported---if it work=
s, it
> works by accident, giving long enough rope to users to potentially ca=
use
> themselves harm.
>
> I am inclined to think that we shouldn't encourage use of pathspecs (=
just
> like we never encouraged use of options like --name-only that never m=
akes
> sense in the context of the command) but I am undecided if we also sh=
ould
> forbid the use of pathspecs (just like we did for --name-only recentl=
y).

How about 'git format-patch --full-diff'? Isn't that a valid way to
filter patches just like --author, --grep, and so on?

--=20
=46elipe Contreras
