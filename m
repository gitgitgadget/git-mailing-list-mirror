From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [RFC/PATCHv8 00/10] git notes
Date: Tue, 19 Jan 2010 16:54:26 +0100
Message-ID: <81b0412b1001190754m37ed01b0nd93b318d77d88a75@mail.gmail.com>
References: <1258681154-2167-1-git-send-email-johan@herland.net>
	 <7vk4xl5y3z.fsf@alter.siamese.dyndns.org>
	 <20091120192800.6117@nanako3.lavabit.com>
	 <7vk4xl1nkl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	spearce@spearce.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 19 16:54:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXGPc-0008Fl-1L
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jan 2010 16:54:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754305Ab0ASPyb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Jan 2010 10:54:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754326Ab0ASPya
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jan 2010 10:54:30 -0500
Received: from mail-bw0-f219.google.com ([209.85.218.219]:39661 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753938Ab0ASPy2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Jan 2010 10:54:28 -0500
Received: by bwz19 with SMTP id 19so2849159bwz.28
        for <git@vger.kernel.org>; Tue, 19 Jan 2010 07:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=W0SD3liPUHlmuFRhgVCMaZAgaENNBRPnf8ihl++xKfM=;
        b=wWyImsGKdOH08OudWyOesKpZcNRs6O5geAehf5epdUvsVu1UxbMVR1vwQh08d+apdk
         y9kVwHaBcRjBDF7DS/44XInby1wdBtfs3lj/IHLZyQ1UOFY0e3rrHOr+AuyW0y+rDBp7
         R6EHDg/0q7nqg7E3Oxi+Q94JcMP0CJ5sbSCHI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=wimauo2YIywCpEiPUw42WY2pWk0/RgnOrhzXBdeunMpPEqaTu1YGltOZhIOEQAiGff
         7nVrvwdPJxzafHIMfySSoHcsWhgVCkpVf+T5Wrp+fUjLEfDMqygi7Q22U93WhSn3VE4A
         iLvvzfiHReFwDBlWrU9NPn3UBB7Xn8m/iuiiY=
Received: by 10.204.4.203 with SMTP id 11mr4333213bks.69.1263916466376; Tue, 
	19 Jan 2010 07:54:26 -0800 (PST)
In-Reply-To: <7vk4xl1nkl.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137469>

On Fri, Nov 20, 2009 at 11:46, Junio C Hamano <gitster@pobox.com> wrote=
:
> @@ -716,7 +719,7 @@ int cmd_checkout(int argc, const char **argv, con=
st char *prefix)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!strcmp(ar=
g, "-"))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0arg =3D "@{-1}";
>
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (get_sha1(arg, =
rev)) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (get_sha1_mb(ar=
g, rev)) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0if (has_dash_dash) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* c=
ase (1) */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0die("invalid reference: %s", =
arg);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0if (!patch_mode &&

This is a bit of a problem on Windows, as the arg (eventually containin=
g
something like "master..."), will be passed to resolve_ref below. Now, =
Windows,
being the piece of shit it is, will lie and tell that a file
"refs/heads/master..."
exists and be same as "refs/heads/master". This breaks "checkout to mer=
ge
base" on Windows and t2012 in particular.

BTW, why should the arg be run through resolve_ref at all if
get_sha1(_mb) has succeeded?
Isn't the commit already resolved by lookup_commit_reference_gently?
