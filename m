From: demerphq <demerphq@gmail.com>
Subject: Re: push.default: current vs upstream
Date: Wed, 4 Apr 2012 09:57:31 +0200
Message-ID: <CANgJU+VN26Lx1YBdfHvDY9W8Tifc2dsKMLFoyx9EhtO4pANAZw@mail.gmail.com>
References: <7vd37wv77j.fsf@alter.siamese.dyndns.org>
	<20120329095236.GA11911@sigill.intra.peff.net>
	<7vbonfqezs.fsf@alter.siamese.dyndns.org>
	<20120329221154.GA1413@sigill.intra.peff.net>
	<7vfwcqq2dw.fsf@alter.siamese.dyndns.org>
	<20120330071358.GB30656@sigill.intra.peff.net>
	<7vty15ltuo.fsf@alter.siamese.dyndns.org>
	<vpqty12h995.fsf@bauges.imag.fr>
	<7vlimegjw9.fsf@alter.siamese.dyndns.org>
	<vpqy5qejbjl.fsf@bauges.imag.fr>
	<7vobraf057.fsf@alter.siamese.dyndns.org>
	<vpqwr5ydkqt.fsf@bauges.imag.fr>
	<7vzkatex02.fsf@alter.siamese.dyndns.org>
	<vpqiphhdfzw.fsf@bauges.imag.fr>
	<CANgJU+V57Yz2FXStsYtL38td7FLR=ihaKzvbOBqzbR=qEFgESw@mail.gmail.com>
	<vpqd37pbzqw.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Apr 04 09:57:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFL62-0006RZ-G3
	for gcvg-git-2@plane.gmane.org; Wed, 04 Apr 2012 09:57:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755972Ab2DDH5d convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Apr 2012 03:57:33 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:63101 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755820Ab2DDH5c convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Apr 2012 03:57:32 -0400
Received: by ghrr11 with SMTP id r11so233403ghr.19
        for <git@vger.kernel.org>; Wed, 04 Apr 2012 00:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=8V/DJJ/3x2Yvp1wJ11TxMBg48OL/zDZWoeaCRwCPgoY=;
        b=rKDfrUbYdrCMJwFKe014uac9N3+c8rRTnUVuKYK9K66i7h+ZSTHFpG3d/XA5od2AU5
         rwiqmCCX9ehNwlKjyzWfa6n3/EQD7w/hl4v50yP+ZCzJG5YUUanA+tnD+jzXnowO9AXE
         YxvQsDLrglY2DctxquYWjrFhUchaSepp0GYtjP8101IduJ355RyOJ6k2F7dZeDPK+k7E
         pd2ONXn2c7n2ey4q6JtiGo6hMFQ1Xa00dk53PmFY8eLKA8s3v/GZS4QvS9uAv507u00P
         MHUBF9AonO96CGdL4BABRGp3DfaShl2Z+9MMGyOQefFg/hStqnMdQLkPuk4qyz8XLAUF
         MZPQ==
Received: by 10.236.75.163 with SMTP id z23mr2158438yhd.124.1333526251485;
 Wed, 04 Apr 2012 00:57:31 -0700 (PDT)
Received: by 10.236.111.11 with HTTP; Wed, 4 Apr 2012 00:57:31 -0700 (PDT)
In-Reply-To: <vpqd37pbzqw.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194685>

On 2 April 2012 23:16, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> wrot=
e:
> demerphq <demerphq@gmail.com> writes:
>
>> And actually I find your use of "git pull" and "pull" in the
>> expression "pull from a branch other than one with the same name"
>> confusing. Barring misconfiguration pull operates on only one local
>> branch and it is usually the one with the same name. However push
>> operates on multiple local branches.
>
> It does with push.default =3D matching, but with either options we ar=
e
> discussing here, argumentless "git push" would push only one branch.
> The choice we have is whether to push to the branch with the same nam=
e,
> or to the branch from which "git pull" would take the changes.

Ah, then I misunderstood your point. Probably because of the point you
make next.

> (I realize that in this discussion, "current" may be misleading. I me=
an
> "push.default=3Dcurrent", not "the behavior we have currently")
>
>> Lastly I have never really encountered any confusion with explaining
>> the default behaviour of git-fetch, nor actually git-pull, but I hav=
e
>> encountered lots of confusion of people using git-push. =A0They expe=
ct
>> git-push to be the opposite of git-pull not git-fetch.
>
> I do also expect "git pull" to be symmetrical to "git pull", and
> "push.default=3Dupstream" is the closest to symmetry.

After clarifying what he meant off-list I'd just like to say that I
agree with Matthieu. Picking a default that makes git-push not be the
opposite of git-pull will end up surprising some people some of the
time. Enough that I suspect that this conversation will be coming up
again in the future.

cheers,
Yves


--=20
perl -Mre=3Ddebug -e "/just|another|perl|hacker/"
