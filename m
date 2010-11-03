From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] Remove restriction on notes ref base
Date: Wed, 3 Nov 2010 17:30:00 +0100
Message-ID: <AANLkTin_NuzQocOab+w=B3Ka+n22j2-OXQu8=J6uzByS@mail.gmail.com>
References: <1288657003-17802-1-git-send-email-kroot@google.com>
 <AANLkTinN1UXSmkxOg59pT_xVd2eWS0Ms2sgAweLv7hbg@mail.gmail.com>
 <7vsjzj1v49.fsf@alter.siamese.dyndns.org> <201011022358.11340.johan@herland.net>
 <20101103064137.GC7606@burratino> <7vsjzixty5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Shawn Pearce <spearce@spearce.org>,
	Kenny Root <kroot@google.com>,
	Thomas Rast <trast@student.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 03 17:30:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDgEE-0000GR-UE
	for gcvg-git-2@lo.gmane.org; Wed, 03 Nov 2010 17:30:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755702Ab0KCQaW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Nov 2010 12:30:22 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:47177 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755666Ab0KCQaV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Nov 2010 12:30:21 -0400
Received: by ywc21 with SMTP id 21so602803ywc.19
        for <git@vger.kernel.org>; Wed, 03 Nov 2010 09:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=X2On7h1GeAqCFed3zWpki1/O1SIdTNajH+JXcXj4xCQ=;
        b=hqaBsj6mgyOXPSlwkbWK90LQ1CAUrLAThhqaz3QOfoZ1fJuyQPitOZfDXpjdd5FSOA
         YixFFbozikagnpkzUwM8QRhCM+4te6W7zAAMNZkIpaR0AD4qXO6NyH5EmNyTV+zfC9AJ
         wjUlRi654LetQTYWGlKvG9S7VdmkrzpR68fp8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=weT2QiHGYGEKaKT+4gbFBTn8FQLgl7NAVyJ5kspr/ilJfemSBrV90f1+U1bF6K540R
         Yqc+0SQFqpny1mnQOJX/9lT3KUp4IPTiDubM7j+XZLlRYPCNkb3M6+uVXbUFBQiM/8gL
         BOZ7AHidhVDH7DdKzqppcGaHuO51Sf6A6P1FY=
Received: by 10.150.134.13 with SMTP id h13mr933927ybd.84.1288801820861; Wed,
 03 Nov 2010 09:30:20 -0700 (PDT)
Received: by 10.150.58.11 with HTTP; Wed, 3 Nov 2010 09:30:00 -0700 (PDT)
In-Reply-To: <7vsjzixty5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160608>

Heya,

On Wed, Nov 3, 2010 at 17:17, Junio C Hamano <gitster@pobox.com> wrote:
> I was actually thinking more along the lines of "not keeping track of
> remote state at all". =C2=A0We don't do that for tags either.

I would rather see us go the other way (and make the tags refspec put
tags under refs/tags/remotes/.../). I can understand not scoping tags
(since they're supposed to be immutable, and are usually global), but
I don't think the same holds for notes. Notes _are_ versioned, and
it's expected that users will collaborate.

--=20
Cheers,

Sverre Rabbelier
