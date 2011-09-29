From: Michael Witten <mfwitten@gmail.com>
Subject: Re: In favor of "git commit --no-parent"
Date: Thu, 29 Sep 2011 22:29:35 +0000
Message-ID: <CAMOZ1Bspiz-J4Z7d8t7+jA_rKmzKcjhxuUpUSv7BrjJ=kCBfBQ@mail.gmail.com>
References: <1316960136073-6829212.post@n2.nabble.com> <1316961212.4388.5.camel@centaur.lab.cmartin.tk>
 <7vaa9r2jii.fsf@alter.siamese.dyndns.org> <1317073309.5579.9.camel@centaur.lab.cmartin.tk>
 <vpq39fi9gf5.fsf@bauges.imag.fr> <69d6fb3199bc4f74b25dae7992a9f132-mfwitten@gmail.com>
 <vpqsjni6kkk.fsf@bauges.imag.fr> <553B5FA1A43748B1ADD759572EADA6FF@PhilipOakley>
 <e4f46b39e9ed4203bfab8a81e25eb600-mfwitten@gmail.com> <7vaa9oz9rl.fsf@alter.siamese.dyndns.org>
 <271cc2ed03774b4988bb61cb3e79750e-mfwitten@gmail.com> <7vmxdnte0j.fsf@alter.siamese.dyndns.org>
 <CABURp0q8YhTS-GDYOANEa19P-V2wf_EUTo=RHqnhDB619w=y-w@mail.gmail.com>
 <7vd3ejrqin.fsf@alter.siamese.dyndns.org> <7v4nzvrp3k.fsf@alter.siamese.dyndns.org>
 <CABURp0rjBdx+=_8R5g16fNKWis3=GgJw9SQ9D53H6xu_-Tq3Uw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@elego.de>,
	vra5107 <venkatram.akkineni@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Raible <raible@nextest.com>,
	Philip Oakley <philipoakley@iee.org>,
	Jeff King <peff@peff.net>, Jay Soffian <jaysoffian@gmail.com>,
	git@vger.kernel.org
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 30 00:30:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9P7b-000296-Jk
	for gcvg-git-2@lo.gmane.org; Fri, 30 Sep 2011 00:30:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754475Ab1I2WaH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 29 Sep 2011 18:30:07 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:60647 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751517Ab1I2WaF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Sep 2011 18:30:05 -0400
Received: by iaqq3 with SMTP id q3so1152083iaq.19
        for <git@vger.kernel.org>; Thu, 29 Sep 2011 15:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=LhsLOExMlNsuEGqZtinPpJ8xDrBIE+M3jemRfkF2INM=;
        b=cf4I4+I7mx/CucsWJkD6ei3gKiaTQwrC2Ufn1pXmujolUrCoxiXJL4HUKaPhG8C2gG
         5R1olSawkD3lHn4OM3XGF/lU3uMyt4Voev7G3VvJWQSxunK/OvMtXQ7P93V6bH4Cw9/p
         e3EMA1wHaMxt9ISj4vMRdX+T4joti27pUpBDI=
Received: by 10.42.173.70 with SMTP id q6mr1634481icz.48.1317335405094; Thu,
 29 Sep 2011 15:30:05 -0700 (PDT)
Received: by 10.42.171.194 with HTTP; Thu, 29 Sep 2011 15:29:35 -0700 (PDT)
In-Reply-To: <CABURp0rjBdx+=_8R5g16fNKWis3=GgJw9SQ9D53H6xu_-Tq3Uw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182452>

On Thu, Sep 29, 2011 at 22:07, Phil Hord <phil.hord@gmail.com> wrote:
> If I understand right, the mechanics of the initial creation is what
> bothers you. =C2=A0Is that right? =C2=A0If so, we're on the same page=
 here,
> because it bothers me too. =C2=A0The commit or checkout alternatives =
seem
> like two halves of a turd sandwich. =C2=A0Both ends are wrong somehow=
, and
> it's because of the state of the working directory in the interim.

Creating a Hidden History (Junio is OK with this usage):

  $ cd repo
  $ git checkout -b hidden-history
  $ # Hack away as usual or not
  $ git status # As with any other commit.
  $ git commit --no-parent

Creating a completely Separate History (Junio doesn't like this):

  $ cd repo
  $ git checkout --orphan separate-history
  $ git rm -rf . # This SHOULD be automatic.
  $ # add files as with an empty repo.
  $ git status # As with an empty new repo; lots of "new file"
  $ git commit

Those are the 2 halves, and they are correct for their purposes;
however, I would agree that "git init" is better instead of
"git checkout", especially when there should be an automatic
use of "git rm -rf .".

Consider trying the "Hidden History" scenario with the current
approach, which only allows for "git checkout --orphan":

  $ cd repo
  $ git checkout --orphan separate-history
  $ # Hack away as usual or not
  $ git status # lots of "new file" notifications obscuring my changes
  $ git commit

The main issue with "git commit --no-parent" is [supposedly] safety, bu=
t it
can be made pretty safe:

  $ cd repo
  $ # Hack away as usual or not
  $ git status # As with any other commit.
  $ git commit --no-parent
  Error! There must be another branch head directly referencing the
  same commit that is directly referenced by the current branch head!
  $ git checkout -b hidden-history
  $ git commit --no-parent

In the vast majority of cases, that rule will prevent people from
losing history inadvertantly, and no extra "--force" is required.
