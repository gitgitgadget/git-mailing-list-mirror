From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] gitk: disable checkout of remote branch
Date: Fri, 6 Nov 2009 09:30:08 +0100
Message-ID: <fabb9a1e0911060030u779ddb64x6017e06f44ac2c10@mail.gmail.com>
References: <2e24e5b90911030800j22b00372r99a56c3f847a3644@mail.gmail.com> 
	<fabb9a1e0911030807h6b76b661pef75628a1255356@mail.gmail.com> 
	<1257295737457-3942366.post@n2.nabble.com> <2e24e5b90911031758t651735f9xe9d078079112cfa6@mail.gmail.com> 
	<1257315478920-3943388.post@n2.nabble.com> <fabb9a1e0911032241u3735fa30heaa195d959879f5a@mail.gmail.com> 
	<20091104072709.GC24263@coredump.intra.peff.net> <7vhbtai2uy.fsf@alter.siamese.dyndns.org> 
	<20091105074808.GA12114@coredump.intra.peff.net> <7v8wek7a6z.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Tim Mazid <timmazid@hotmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 06 09:30:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6KDM-00007d-4A
	for gcvg-git-2@lo.gmane.org; Fri, 06 Nov 2009 09:30:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754801AbZKFIaZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Nov 2009 03:30:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754754AbZKFIaY
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Nov 2009 03:30:24 -0500
Received: from ey-out-2122.google.com ([74.125.78.26]:13188 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754743AbZKFIaY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Nov 2009 03:30:24 -0500
Received: by ey-out-2122.google.com with SMTP id 25so207103eya.19
        for <git@vger.kernel.org>; Fri, 06 Nov 2009 00:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=yDb5b08lZz/+lAKurbHIshoVig9ZjqYd+VMpcQbah+I=;
        b=KkqdHde1sUUoby8nI07sBHgY8RCMpcHu1pxgNiG4qyYiwwvhXS5/dyujEOz9WoI6l5
         0qBPJyJZcdkR7HR8ik/FeR0WualiNngUdY4TEy0LGYO2Odc6CtSB/uK++4Dr45OEM6I2
         NirNlbWybC3tubimHTEMJRh6imFTTKPtIKBqY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=NNj1T4nhr7XyS06zZk8eJxF1Ldyua+1Y5NoFxV8c+kYSYnMRjBlnTWzFpprjX5zNId
         OdDIgZBX6OUFrOHQ52E4JyMY7fojbcj21/GHWM/kqQgz9kgkmzmUt1ZpJs0+7IB6qVKb
         Pbla8jKA97Z3rlvRKlb1Uydh0V2auW83oXOJ8=
Received: by 10.216.88.83 with SMTP id z61mr1327521wee.140.1257496228573; Fri, 
	06 Nov 2009 00:30:28 -0800 (PST)
In-Reply-To: <7v8wek7a6z.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132284>

Heya,

On Fri, Nov 6, 2009 at 01:45, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>> Sorry, yes, I just saw Sverre's comment and misread the original
>> proposal. =A0Checking out "$remote/$branch" will still detach the HE=
AD,
>> and I don't think anybody has a previous proposal to change that.
>
> Heh, I think both of us forgot that we decided it is safe enough not =
to
> wait for 1.7.0 already, because the situation this kicks in has alway=
s
> resulted in an error. =A0We have it in master since e3de372 (Merge br=
anch
> 'jc/checkout-auto-track', 2009-10-30).

Sorry for causing so much confusion, I misremembered what the patch
was about ("git checkout <branch>" vs "git checkout
<remote>/<branch>"). Apologies.

--=20
Cheers,

Sverre Rabbelier
