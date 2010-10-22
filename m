From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: should Documentation/howto/setup-git-server-over-http.txt be
 marked obsolete?
Date: Fri, 22 Oct 2010 19:25:31 +0530
Message-ID: <AANLkTinv3kzvtC_Pq4F0cM_JqU7-Q2a=sWs8YSxbMiPs@mail.gmail.com>
References: <AANLkTimJe9vEUwWM482NLmfHGYjnsKD5RAryQO=Zyqjj@mail.gmail.com>
	<7vsjzyrh2w.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 22 15:55:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9I5r-0005r3-0f
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 15:55:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756410Ab0JVNzd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Oct 2010 09:55:33 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:40420 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754908Ab0JVNzc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Oct 2010 09:55:32 -0400
Received: by gyg4 with SMTP id 4so615167gyg.19
        for <git@vger.kernel.org>; Fri, 22 Oct 2010 06:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=OMpkBnmNpSxlpiqbwuIm56oh0DOpyEpe3btkyRyhCD0=;
        b=Jc/tPanM8rfl5Fvi3OfqgBgRiRfVMmcyXZTZhT/G29LcIzkKvoEBe/WEur0bXzgVa/
         RtN9XZ3t8N0RbH1Zlj3M58pZSPP7StrdoMAKIxH1McriA/XzTka8sctHEAEW0JTFL/00
         a9J+9QGZOw3Uti5IWMfh9mB92cqWZAZJem/Es=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=k8qz68SvJzAfamCO+SKWSejNnr2K4I8afs7ACIGIKgh1aACVn4w1fle4lyC8X+00A/
         hxPglkbKcusx2zUfUqCj2tOTzcd7SQqcTtGJr7gXAzmI02iX1ddDMk2G6w2FcDyMeg26
         +B8F5zX67LvzNrQKe2QKdPMxI60AOElIWlo9w=
Received: by 10.90.53.14 with SMTP id b14mr2290225aga.122.1287755731159; Fri,
 22 Oct 2010 06:55:31 -0700 (PDT)
Received: by 10.90.83.17 with HTTP; Fri, 22 Oct 2010 06:55:31 -0700 (PDT)
In-Reply-To: <7vsjzyrh2w.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159688>

On Fri, Oct 22, 2010 at 9:53 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Sitaram Chamarty <sitaramc@gmail.com> writes:
>
>> Subject line says it all... While working with people trying to use
>> gitolite's new support for the "smart HTTP" mode, I find sometimes
>> they get side-tracked by this document.
>
> Not everybody uses gitolite, and I do not think we have broken the du=
mb
> HTTP support (however broken the original was ;-) to render the docum=
ent
> obsolete.

My apologies; I didn't realise my mail would come across like that.

Let me clarify.  "While working with gitolite users" was only meant to
explain how *I* came across the issue, nothing more.

I assumed that the new -- much more efficient (correct?) transport
would make the older (dumber) transport obsolete, and I didn't realise
it had any advantages over the new one.

> Perhaps we should do three and half things:
>
> =C2=A0- The said documentation should be fine as is if the reader is =
trying to
> =C2=A0 set up a dumb HTTP push support; otherwise it should be update=
d.
>
> =C2=A0- It would be really nice if somebody wrote a similar document =
describing
> =C2=A0 how to set up a smart HTTP server, and put it next to the said
> =C2=A0 documentation.

I just followed "man git-http-backend" and it all worked.  Should there=
 be more?

> =C2=A0- When the above two is done, insert one line "This describes a=
n older
> =C2=A0 way; see <<insert the name of the other document here>> for in=
sn to set
> =C2=A0 up an experimental smart HTTP server" at the beginning of the =
original
> =C2=A0 document.
>
> and finally:
>
> =C2=A0- On the gitolite side, refer to the "new" document in git.git
> =C2=A0 documentation set.

It does refer to the new one, otherwise no one would have been able to
use those instructions!

Just that some people... I don't know.. gloss over the exact filename
maybe... or they find the other one first and think it's the right
one...

Anyway, you're partly right -- I probably should highlight it better in=
 my docs.

Thanks

--=20
Sitaram
