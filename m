From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: what are the chances of a 'pre-upload' hook?
Date: Mon, 28 Nov 2011 13:47:44 +0530
Message-ID: <CAMK1S_hX3fEf1nL28yxASLw_cveJbC5aQRdixgBF6zaPyAEsdA@mail.gmail.com>
References: <CAMK1S_jaEWV=F6iHKZw_6u5ncDW0bPosNx-03W9bOLOfEEEY1Q@mail.gmail.com>
	<CAMK1S_gh_CsWc-DnbOuUwn+H1i3skm99xzDbWe-wxsKKS0Qw-w@mail.gmail.com>
	<20111125144007.GA4047@sigill.intra.peff.net>
	<7v7h2my0ky.fsf@alter.siamese.dyndns.org>
	<20111126225519.GA29482@sigill.intra.peff.net>
	<7vr50uwk7x.fsf@alter.siamese.dyndns.org>
	<20111126233133.GA31129@sigill.intra.peff.net>
	<CAPc5daXY_4aimugj8Z4BFE8YvBSM1K+evPU69rLGH5ETo6PO=Q@mail.gmail.com>
	<20111126235135.GA7606@sigill.intra.peff.net>
	<CAPc5daUodry_=6pZxA=QOpuRUj9C2ed9Gzp6E1_G93iGfOOvOA@mail.gmail.com>
	<20111127000603.GA7687@sigill.intra.peff.net>
	<7v8vn2vt8p.fsf@alter.siamese.dyndns.org>
	<CAMK1S_jbofsWyag3Sospz8wYHqD4Z1Fs0p+MJWi02eCq0e+uHQ@mail.gmail.com>
	<7vzkfgvjdo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 28 09:17:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RUwPO-000407-T5
	for gcvg-git-2@lo.gmane.org; Mon, 28 Nov 2011 09:17:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751530Ab1K1IRq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Nov 2011 03:17:46 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:45804 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751012Ab1K1IRp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Nov 2011 03:17:45 -0500
Received: by ghrr1 with SMTP id r1so4927549ghr.19
        for <git@vger.kernel.org>; Mon, 28 Nov 2011 00:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=4Lml+tkGWMgNHpvTymydTbLWy0yPGreoHCFh4cqUAoA=;
        b=ba1UL7L/v7NjNRozzm9420Jqii4gN/91B/PDK1XVuVrvXh9n63aUt4nG2AbRgBAIrX
         /1RxJSQTkABDhNthAULJ64k9FGX75ROdcBj9/cgUKoTOjMbYKlSKkZk7E+bO0IyKBsoH
         5p9m4RcQf/kQcCAfRnXAmBfepTCHrget+XbHs=
Received: by 10.182.45.102 with SMTP id l6mr12283827obm.0.1322468264790; Mon,
 28 Nov 2011 00:17:44 -0800 (PST)
Received: by 10.182.6.41 with HTTP; Mon, 28 Nov 2011 00:17:44 -0800 (PST)
In-Reply-To: <7vzkfgvjdo.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186003>

On Mon, Nov 28, 2011 at 12:11 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Sitaram Chamarty <sitaramc@gmail.com> writes:
>
>>> I actually like the idea of allowing pre-upload-pack hook on git://=
 and
>>> possibly http:// only....
>>>
>>> One scenario I do not want to see is this. Suppose ...
>>
>> I'm sorry I started this discussion. =C2=A0I worked around it, thoug=
h it's
>> a bit kludgy, so maybe time to drop the debate.
>
> I do not want you to feel sorry, and I do not understand why you feel=
 that
> way.

Because I did not think it was so complicated...? :-)

> I think a reasonable and safe way to trigger an action in response to=
 a
> request to fetch from a repository _is_ a sensible thing to wish for.=
 So
> far, we established that we cannot just simply add pre-upload hook ba=
ck in
> and be done with it, as that is not a safe way. We learned something.

> Jeff may be right that any approach based on hooks cannot be made tot=
ally
> safe. But the discussion can lead to a workable alternative. The "ena=
ble
> the hook only on git:// and http:// and no other" approach might or m=
ight
> not be such a workable alternative. The "try talking to a service pro=
cess
> via named pipe, instead of spawning a hook" might or might not be suc=
h a
> workable alternative. Other possibilities may be there to be explored=
=2E

There are only 2 cases: git-upload-pack runs as invoking user, or it
runs as some common user/repo owner.

I see pre-upload hooks for case 1 as being hard/impossible to do,
while case 2 is trivial (just check if the hook file owner =3D=3D UID o=
f
the git-upload-pack process).

Yes, this means pre-upload won't work identically in *all* setups.
But as you said somewhere: perfect is the enemy of good.
