From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Making error messages stand out (Re: [RFC/PATCH 0/9] commit: more 
	focused advice in the no-changes-staged case)
Date: Fri, 30 Jul 2010 13:44:24 -0500
Message-ID: <AANLkTi=ao2RY8NGm4cACqz3_5zfT2zvXB4JHOopBD9T5@mail.gmail.com>
References: <20100725005443.GA18370@burratino> <AANLkTilnQhsopnuAf0nja8Qq63VrOlt0_uCJrqYv5X-v@mail.gmail.com> 
	<201007251122.41166.trast@student.ethz.ch> <20100729235151.GB6623@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@student.ethz.ch>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 30 20:45:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OeuaL-0002kr-NV
	for gcvg-git-2@lo.gmane.org; Fri, 30 Jul 2010 20:45:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759612Ab0G3SpH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Jul 2010 14:45:07 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:32994 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932314Ab0G3Sot convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Jul 2010 14:44:49 -0400
Received: by yxg6 with SMTP id 6so754915yxg.19
        for <git@vger.kernel.org>; Fri, 30 Jul 2010 11:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=t8qGqVFkc7sLZtcRlcjDN8MOb4Nortw8f/SU08NNgkQ=;
        b=spd0lLxnnX4iXVfQSIwcYvt+Ca9MAhLWx9zeicmLZRvL7aeyYfTkVE9GDHCsoJ6Sqy
         JMYEVWJogC2OjMK1ESWEHf+tv5ivXPPm+U1LvCbCP0IAtTFeSHHVVlhJVkxsHOqtWEGa
         21VUXKOozZANGiAcY4ttCMGeAZQuO78VCK1L0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=aKka6WQArt3F1Flm4EvFpbxWJFG/iCzgbtXVzFvc0++WqrCFn0XUEoLGDHZiJ7vshm
         wjDm55snjjFbmKzfyiJ0rAJ0HyAHwCak0SMPmZRDUSZ686Ti7ZBv7rUIVYxGoodBC2Eh
         yw3mknBmIqe+8QqlFm4LeQ7HikKZf9wvUQ2UE=
Received: by 10.150.175.17 with SMTP id x17mr3602375ybe.300.1280515485093; 
	Fri, 30 Jul 2010 11:44:45 -0700 (PDT)
Received: by 10.150.66.12 with HTTP; Fri, 30 Jul 2010 11:44:24 -0700 (PDT)
In-Reply-To: <20100729235151.GB6623@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152259>

Heya,

On Thu, Jul 29, 2010 at 18:51, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> though, I find the best solution is to use short, formulaic messages:
>
> =C2=A0...
> =C2=A0Recorded resolution for 'dir/a'.
> =C2=A0[detached HEAD aa9ae6b] related change
> =C2=A0 1 files changed, 1 insertions(+), 1 deletions(-)
> =C2=A0fatal: could not apply 649420f... second
> =C2=A0hint: after resolving the conflicts, mark the corrected paths
> =C2=A0hint: with 'git add <paths>' and run 'git rebase --continue'

Yes please. This would be _extremely_ helpful!

--=20
Cheers,

Sverre Rabbelier
