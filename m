From: Phil Hord <phil.hord@gmail.com>
Subject: Re: Auto update submodules after merge and reset
Date: Sun, 11 Dec 2011 09:43:37 -0500
Message-ID: <CABURp0qmOQy0=1d7RwXMO3Bm7GwXh-60fwOKFHhyG3kDkxqxxg@mail.gmail.com>
References: <4ED57EED.4040705@qualcomm.com> <4ED5E9D2.4060503@web.de>
 <jbnadt$hf8$1@dough.gmane.org> <4EDFE75C.5050201@web.de> <4EE07FCD.8090702@ursus.ath.cx>
 <CABURp0rcT2FR3uOmhyPUV5W3pu7WuJzjXktmUq0eb4nOiUwDKA@mail.gmail.com> <4EE2B8C3.6000906@ursus.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org
To: "Andreas T.Auer" <andreas.t.auer_gtml_37453@ursus.ath.cx>
X-From: git-owner@vger.kernel.org Sun Dec 11 15:44:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZkdJ-0007vO-TH
	for gcvg-git-2@lo.gmane.org; Sun, 11 Dec 2011 15:44:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751636Ab1LKOoA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Dec 2011 09:44:00 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:49706 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750881Ab1LKOn7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Dec 2011 09:43:59 -0500
Received: by wgbdr13 with SMTP id dr13so9379538wgb.1
        for <git@vger.kernel.org>; Sun, 11 Dec 2011 06:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=vgyEXwn1s1OzzaJraF6GdobuMGhdaG+H91JoK/iDujg=;
        b=F6TnWR2rMl3a98rKsGTrvL1rM9RbvygKr303EKeodKFQZaOgpJpJWR5FMMrCXcGYjD
         fzCpNSzkwZpPymCafqz5KDr+vxF2svcfbXwNoYPlog6Njtk+XVI0YJmu0UeN2JFKjBrs
         9HoXxEFakgj8t2U5IfQh5yJy97OGfAuUaoW5s=
Received: by 10.216.188.8 with SMTP id z8mr30279wem.105.1323614638195; Sun, 11
 Dec 2011 06:43:58 -0800 (PST)
Received: by 10.216.120.199 with HTTP; Sun, 11 Dec 2011 06:43:37 -0800 (PST)
In-Reply-To: <4EE2B8C3.6000906@ursus.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186802>

On Fri, Dec 9, 2011 at 8:41 PM, Andreas T.Auer
<andreas.t.auer_gtml_37453@ursus.ath.cx> wrote:
>>> It is even nice to see which commits in the submodule belong to wha=
t
>>> branches in the superproject or to what release version (so trackin=
g
>>> superproject tags would make sense, too). If you have a submodule t=
hat
>>> has
>>> more than one superproject but these are well-defined, it could be =
solved
>>> using refspecs (e.g. refs/super/foo/* for one and refs/super/bar/* =
for
>>> the
>>> other superproject), but currently I can't think of a context where=
 this
>>> makes sense.
>>
>> I can, but this does put the cart before the horse. =A0The submodule=
 is
>> subservient to the super project in all my setups. =A0The submodule =
is
>> not aware who owns him. =A0He is a bit like the DAG in reverse. =A0H=
e
>> knows one direction only (children), not the other (parents).
>
> In the setup I have in mind, the submodules are not subservient to th=
e
> superproject, but a part of the whole project.

I see that.  I have a similar project with about 20 submodules.  None
of them are useful on their own; they are logical divisions of a large
project.

Architecturally, submodules are oblivious of their super-projects in
all other respects.  Changing the architectural underpinnings should
be a last resort, I think.

Phil
