From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/2] Move sequencer to builtin
Date: Sun, 9 Jun 2013 15:02:00 -0500
Message-ID: <CAMP44s3Ps9MaiYnNbMOZwU8H4zZ1zoHwscJGHsxjbXomXT-2fA@mail.gmail.com>
References: <CAMP44s29GiGJq3wyXAzJNo0FJY+Vbgd18bpBJMYQ47h-3M6sWA@mail.gmail.com>
	<CACsJy8A-qc0tHcsp5=syxv_7FjixahU7fGcZuUV=cGn_-qyWwg@mail.gmail.com>
	<20130608164902.GA3109@elie.Belkin>
	<CAMP44s06DaV2G0rbhzJRMujEJnqeGYYv2G-a90pLL6AOS0gp+w@mail.gmail.com>
	<20130608173447.GA4381@elie.Belkin>
	<CAMP44s0n0qEk+1HhpAm-fMn+BWFwOeZCp7pgq9==09COVoNNEw@mail.gmail.com>
	<20130609014049.GA10375@google.com>
	<CAMP44s3CGHVLnkUxo=PR_b+_dTuaz5rwems_pd9GE1_vcEaYRA@mail.gmail.com>
	<20130609052624.GB561@sigill.intra.peff.net>
	<CALkWK0mu2_9M5aTczcEkv37eLaAg5_mGDZ_W9nqQFoesB4wc3g@mail.gmail.com>
	<20130609180437.GB810@sigill.intra.peff.net>
	<CALkWK0kkhDOSSdF=E4PvO24hg++_FpP3YFaGRD3yq80XG0TRJA@mail.gmail.com>
	<87zjuz84tp.fsf@hexa.v.cablecom.net>
	<CALkWK0kX1E9A9q1ptfx-QA1LiBf4UEeHF92xR21am=vv_zKZZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@inf.ethz.ch>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <drafnel@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 09 22:02:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlloW-0003nM-0Y
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 22:02:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750871Ab3FIUCD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jun 2013 16:02:03 -0400
Received: from mail-la0-f41.google.com ([209.85.215.41]:41540 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750695Ab3FIUCB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Jun 2013 16:02:01 -0400
Received: by mail-la0-f41.google.com with SMTP id fn20so5136466lab.14
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 13:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=eCi+2Zab0/AondROq6SjMYmaLeTXP1+GV3O2KkELhHw=;
        b=GGoqba2g2DoxvFH3LaG+wyChwJttHYYNOnewVYhHqpmUPmZMio4UqNmg+m5nH0whrr
         14E1NcnIbmv1IAO/TJzmelJ/5qCnBbJ63bpnSrwvw7/ezC6aFGdFveyhtB1R1zEuwL7x
         6JcMPtOUfxrkTfKZAGMajexQdXTp0NcjMFwUXZoHZreQ3f98/A2EKiA1JJ4Dp/X2iJkZ
         tR7edQVnjOfFnPSRaoVcf5WmIIS7GO190S4djeON5KnJ0hyuHFBxuchdZXYjcccAYFvh
         /TWkXSoawWOXsruLIfPIL8QLQOKj0h8kf698AyXcmnccZNfOeBrzQFW6oWvhLd6pZBJ1
         WzxQ==
X-Received: by 10.112.157.226 with SMTP id wp2mr5063194lbb.65.1370808120295;
 Sun, 09 Jun 2013 13:02:00 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Sun, 9 Jun 2013 13:02:00 -0700 (PDT)
In-Reply-To: <CALkWK0kX1E9A9q1ptfx-QA1LiBf4UEeHF92xR21am=vv_zKZZA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227159>

On Sun, Jun 9, 2013 at 2:54 PM, Ramkumar Ramachandra <artagnon@gmail.co=
m> wrote:

>>   http://article.gmane.org/gmane.comp.version-control.git/225969

This is a good example of an evolving discussion. Ren=C3=A9 Scharfe has
accepted that the API indeed needs work. How exactly it's going to be
fixed is not entirely clear, but at least there's a patch that
essentially tackles what I tried to tackle.

So it's good for the users.

>>   http://article.gmane.org/gmane.comp.version-control.git/226125

This also evolved rather nicely, since there is discussion about
exactly how the signals should be presented to Windows users, because
it's clear currently most of the codes only work in Linux.

Again, users benefit from this.

>>   http://article.gmane.org/gmane.comp.version-control.git/223279

Unfortunately nobody took the charge on this ones, so we will remain
forever in a non-ideal situation.

It's not my fault though. I sent the patch that fixes the problem, and
there's only so much I can do.

Not that it matters much, because the important patches were applied.

But what does this have to do with anything? How are you helping the
Git project by bringing this up? How does this help our users?

--=20
=46elipe Contreras
