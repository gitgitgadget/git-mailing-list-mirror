From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: git fast-export and lightweight tags
Date: Tue, 7 Jun 2011 16:48:06 +0200
Message-ID: <BANLkTin8w9v4GAn4V=PB-ZbtWWp4kTmRRQ@mail.gmail.com>
References: <20110607110213.GA2698@frolo.macqel> <BANLkTikiNeufjH30HeApW6-71T2vOpKrxQ@mail.gmail.com>
 <20110607143321.GA18671@frolo.macqel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Philippe De Muyter <phdm@macqel.be>
X-From: git-owner@vger.kernel.org Tue Jun 07 16:48:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTxaO-0005uW-JQ
	for gcvg-git-2@lo.gmane.org; Tue, 07 Jun 2011 16:48:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754533Ab1FGOsr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Jun 2011 10:48:47 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:62302 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752806Ab1FGOsq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Jun 2011 10:48:46 -0400
Received: by qwk3 with SMTP id 3so2172028qwk.19
        for <git@vger.kernel.org>; Tue, 07 Jun 2011 07:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=GURWYUc4OWU84xb2Nb1pMiYtTcbLhasvL+hg1G6g3yg=;
        b=Aej8ZJwNP1AIz+tY6/y6qpkqcQiYFU4f3tH/3HaanX7JUPFXxHwN/5DNCSO5Kdl+uL
         SxzwjFqV063278Q6pdYf7k233zw7tSHOuGRIx8fJQvnW3CZAklcbGBPqXv1gnIuOgmm5
         w5FflkCWO8DtyqbbV6CnmnXVssD4wsiVFmKRk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=CIP5n4kfwyM46CGXIFD+MvWItvcmozBUJUH5GoSWXjpBUAacidXEBwVRnM1d43qXsY
         tSMU8cu+IwMoTjEgPhyN1w6c94Pjf1UrcBOyZ7R3gZc9lH82X31acKXY3l2CG0gxBK3y
         iScAQJl2WFhoCgI9wyC4aechZGg/2Vw6L4ZUw=
Received: by 10.229.135.12 with SMTP id l12mr4622063qct.53.1307458126092; Tue,
 07 Jun 2011 07:48:46 -0700 (PDT)
Received: by 10.229.83.203 with HTTP; Tue, 7 Jun 2011 07:48:06 -0700 (PDT)
In-Reply-To: <20110607143321.GA18671@frolo.macqel>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175209>

Heya,

On Tue, Jun 7, 2011 at 16:33, Philippe De Muyter <phdm@macqel.be> wrote=
:
> Yes, that works, but neither
>
> $ git help fast-export
>
> nor
>
> $ git fast-export
>
> mention it :(

Kind of.

[<git-rev-list-args>=E2=80=A6]
A list of arguments, acceptable to git rev-parse and git rev-list,
that specifies the specific objects and references to export. For
example, master~10..master causes the current master reference to be
exported along with all objects added since its 10th ancestor commit.

But, yeah. Not very intuitive I agree.

--=20
Cheers,

Sverre Rabbelier
