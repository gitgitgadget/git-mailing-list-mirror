From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 04/15] Makefile: "pot" target to extract messages marked
 for translation
Date: Mon, 21 Feb 2011 13:35:30 +0100
Message-ID: <AANLkTi=ewuq=QS=MTyOF95FUBJNoQ=f2CY53GEZOVOAL@mail.gmail.com>
References: <1298143495-3681-1-git-send-email-avarab@gmail.com>
	<20110221040012.GB26968@elie>
	<20110221101229.GA32137@elie>
	<20110221101530.GE32137@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 21 13:35:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PrUzJ-0001X4-BA
	for gcvg-git-2@lo.gmane.org; Mon, 21 Feb 2011 13:35:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755643Ab1BUMfc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Feb 2011 07:35:32 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:60429 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753844Ab1BUMfc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Feb 2011 07:35:32 -0500
Received: by fxm17 with SMTP id 17so1410026fxm.19
        for <git@vger.kernel.org>; Mon, 21 Feb 2011 04:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=StaY8RYv8jAHUcNk/FwajpqI7mzS3OT/0POw0MigjIU=;
        b=IbaT4n9ndR85dvRiqUeX4bpOq0WkgxVr8DNQJEGLFpvZpuNxRhLRyYmKBMnMlSiirC
         OV9eiPEFVvSKMdmKc8PAthVFH4Y/Ylcg+l+VUMGjNKoS5NrMsHo3aPB5tPRchjtWqO9l
         UNEn9yu718bgdF2Fpqu5DFdz/Li21fljRVu24=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=EqDVu51Qo9c3ARylpDKyOd8E1xFW4I8BmalEmUPFnWBRduSvjdpMxz8luehGljfo9Z
         /r4NozaDFZH/AzBff20v4w5fDaIBhBriTj2IEHprz5fcnK0KoC9HFberyCI5YctuFIt5
         wUNgAaBTGFt7lyixj2++dPHuioeiGeCLLLbzE=
Received: by 10.223.113.73 with SMTP id z9mr1762012fap.41.1298291730865; Mon,
 21 Feb 2011 04:35:30 -0800 (PST)
Received: by 10.223.2.201 with HTTP; Mon, 21 Feb 2011 04:35:30 -0800 (PST)
In-Reply-To: <20110221101530.GE32137@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167477>

On Mon, Feb 21, 2011 at 11:15, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> From: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> Date: Tue, 31 Aug 2010 16:35:16 +0000
>
> Add rules to generate a template (po/git.pot) listing messages marked
> for translation in the C portion of git.

Can we please not apply this? I have a series of patches for this that
I'm submitting later, it's easier for me if don't have conflicts with
stuff like this.

I don't think it's a big deal that we have _() C translations in the
source for some time without the capability to generate POT files from
them.
