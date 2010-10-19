From: Miles Bader <miles@gnu.org>
Subject: Re: Git terminology: remote, add, track, stage, etc.
Date: Tue, 19 Oct 2010 16:48:39 +0900
Message-ID: <AANLkTinb0149C88Mzx6m4_2BdhpW12OwQ+uP6XzQ5yLx@mail.gmail.com>
References: <8835ADF9-45E5-4A26-9F7F-A72ECC065BB2@gmail.com>
 <vpq8w1v5gce.fsf@bauges.imag.fr> <buopqv6kcsd.fsf@dhlpc061.dev.necel.com> <8B950268-7F6E-40E5-9D6C-F150EBEA4F0C@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Thore Husfeldt <thore.husfeldt@gmail.com>, git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Tue Oct 19 09:49:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P86wp-0004On-CG
	for gcvg-git-2@lo.gmane.org; Tue, 19 Oct 2010 09:49:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754189Ab0JSHtW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Oct 2010 03:49:22 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:42225 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753867Ab0JSHtV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Oct 2010 03:49:21 -0400
Received: by gxk21 with SMTP id 21so550679gxk.19
        for <git@vger.kernel.org>; Tue, 19 Oct 2010 00:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:sender:received
         :in-reply-to:references:from:date:x-google-sender-auth:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=Omabm/CrdLGYRKdm4pTGfD00vlgoAt+ny8WgdPY3ehE=;
        b=jWkVvEtcjuFOKzaR9eISRPRPlLrkbwzsWq1DGLL7WdKiVmq0DQO4yotYxr5zkvYwXA
         FjaMOrOVBWoTvZKYuXs9bOoSrRAb5DVSECfAWxg0BiMz2NSYitmLQPP4LvAVjNi3bRml
         AHeDpP6pvxOBAJ1wL4XaNV1Rzf5Dtcu3MmxJU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=Edgq0xmQ8c1ZVp33EfGldMw0oLO4CMudG/rkMwXPZb+S/K+gmvj1JHBRRHASxMK0Iv
         SOcPimE0YTcbe4WQ21CFVo8gEbW6Eb9lGzcqPMikurUoLLy8rR20z75CuPaYbMZJu8Ej
         72mpgZyEB5ZpKO92/xQDcBVmcei53TlSKtTqM=
Received: by 10.42.96.72 with SMTP id i8mr2091017icn.155.1287474559867; Tue,
 19 Oct 2010 00:49:19 -0700 (PDT)
Received: by 10.231.58.197 with HTTP; Tue, 19 Oct 2010 00:48:39 -0700 (PDT)
In-Reply-To: <8B950268-7F6E-40E5-9D6C-F150EBEA4F0C@wincent.com>
X-Google-Sender-Auth: r8ILEVoLe9aepvOBly74TFCLaoo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159311>

On Tue, Oct 19, 2010 at 4:19 PM, Wincent Colaiuta <win@wincent.com> wro=
te:
> We should smooth out these road-bumps (in so far as we can, with resp=
ect to backward compatibility and such) rather than just hand-waving th=
em away saying that they are a natural consequence of demolishing the C=
VS world view and replacing it with something better. That's not true a=
t all; mistakes _were_ made with the terminology, and unfortunately we =
have to live with some of them because they can't be changed in a non-b=
reaking way, but the changes that we _can_ make to remove the confusion=
, we should make them.

Sure, I'm not claiming that git's perfect or can't be improved.  [As I
noted, I have my own list of complaints about its terminology.]

However, just as it's wrong to ignore all complaints for such reasons,
it's _equally_ wrong to assume the opposite and think that all such
complaints are justified.  Some differences in terminology _are_ due
to a very different model, and can't simply be papered over.  It isn't
"hand-waving" to point this out.  They might (and should) be better
documented/explained, but there are definitely terms and concepts
where the only reasonable solution is for newbies to have some
patience and take some time to learn them.

My impression of the original post was that it contained a little of bo=
th.

-Miles

--=20
Cat is power. =A0Cat is peace.
