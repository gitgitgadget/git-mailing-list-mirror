From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 10/13] transport-helper: implement marks location as capability
Date: Sun, 29 Aug 2010 20:35:51 -0500
Message-ID: <AANLkTinyuCoC7P2kSS7epgfO3xjJ8mTEQ+P8qtsEmAct@mail.gmail.com>
References: <1283053540-27042-1-git-send-email-srabbelier@gmail.com>
 <1283053540-27042-11-git-send-email-srabbelier@gmail.com> <20100830013156.GD2305@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 30 03:36:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OptIJ-0006H9-Vh
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 03:36:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754381Ab0H3BgN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 29 Aug 2010 21:36:13 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:40429 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754236Ab0H3BgM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Aug 2010 21:36:12 -0400
Received: by gyd8 with SMTP id 8so1807842gyd.19
        for <git@vger.kernel.org>; Sun, 29 Aug 2010 18:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=x5LDt2O4bLVLFE6wEGP3/vfW4CorXtQ+6np8xVvV974=;
        b=WVv/MW67UmSfztHvQOnTGOGRhZYQqulx0O30j67epr5bYWQUxWhdrnF3jiAPrhLzTr
         Ehz4E7knm94Ci8hp3DQlnFvk82PuqqFGc/HL2IzgUmuKSpIHMVC7I4oEL5ak9WeM+mnw
         9Hq2f/fRhA5KjE4frAT68QijlsGlA36Erl8RY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=cvKk3JOlCpCXhuEyBrKcYPf4QjAeB5OgadDkGM/05K1W6t/98c7VY0VKp2XbjxXZh5
         00qJxV+6o6xZ2g+QuhmfApuQpXpK2GnMVvnMATsi3UIPJ4EJcgs5mUrggwoHOXNV5weU
         deaPnypL8hiSHUjoUpsXlIuZnhH2Qm26aN1iY=
Received: by 10.150.51.4 with SMTP id y4mr4661417yby.340.1283132171248; Sun,
 29 Aug 2010 18:36:11 -0700 (PDT)
Received: by 10.151.49.17 with HTTP; Sun, 29 Aug 2010 18:35:51 -0700 (PDT)
In-Reply-To: <20100830013156.GD2305@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154740>

Heya,

On Sun, Aug 29, 2010 at 20:31, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> This seems fragile to me: shouldn't the remote helper check somehow
> that the line it read was actually a gitdir line?

You're probably right, the simplest way would be to check if repo.gitdi=
r is set.

> No other complaint on my part. =C2=A0Requiring a flush seems entirely
> appropriate to me, and if someone comes up with something nicer than
> the "capabilities" sequence for requesting information, it would not
> be the end of the world to have two ways to discover the .git dir.

Agreed.

--=20
Cheers,

Sverre Rabbelier
