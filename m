From: Phil Hord <phil.hord@gmail.com>
Subject: Re: What's cooking in git.git (Apr 2013, #05; Mon, 15)
Date: Tue, 16 Apr 2013 18:34:59 -0400
Message-ID: <CABURp0q29QkUadbXXa7pQLnTAArRbKh0Y5tdN8stQ7s2BjNAYw@mail.gmail.com>
References: <7vhaj7r116.fsf@alter.siamese.dyndns.org> <CAMP44s2_wiNr4RaBOEnKnZzT4CF0qKK+bp+Lyi=Nfx3Q9ggqOQ@mail.gmail.com>
 <7vip3npet0.fsf@alter.siamese.dyndns.org> <CAMP44s3NE3yrQoa1nZXAgy3KFXGF56Ki8icJ2z2TDigzax0nWg@mail.gmail.com>
 <8761zm4wzg.fsf@linux-k42r.v.cablecom.net> <CAMP44s0a2VsPBMd9Vrrhwdw=SPp2HrvDdXZ9Dmzhr9A6T+Sz7w@mail.gmail.com>
 <7va9oyl1wb.fsf@alter.siamese.dyndns.org> <CAMP44s38M7P0T1Wjhfv=XryoUevuxGwrik4pXwfkUfdpPNrXTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 17 00:35:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USETT-0007qH-Tm
	for gcvg-git-2@plane.gmane.org; Wed, 17 Apr 2013 00:35:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965535Ab3DPWf0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Apr 2013 18:35:26 -0400
Received: from mail-vc0-f172.google.com ([209.85.220.172]:35173 "EHLO
	mail-vc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965496Ab3DPWfZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Apr 2013 18:35:25 -0400
Received: by mail-vc0-f172.google.com with SMTP id gd11so845889vcb.17
        for <git@vger.kernel.org>; Tue, 16 Apr 2013 15:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=g8JGB4PaL1c50zvJj2hoO0j8H0mNg7emvH22vhpGGpM=;
        b=mDyVj5CkjUx+c8HK5OtJAKcQAeATVPx2DuTtOppHxadAfifCHdZG5UvSBSGVLnOjZ/
         PkOVY5s05+z+PIMTQ94qPgmHcPQVNOoFlObAstcjVfWbEhZZcYrWj1ZWUZWR5JOOz9da
         A3mkKSpG2N8g0ziQj4DrRxViFYe11lj3ccufp96gN4eC3QKYBy2SL0GkFvmW856z0Ikd
         Fj44U8lixXns1LldoGppmoB8kZF/+p2KdRaUzzdl7sTcSnAb9rhHi0ftd+Pxt9smZ7Bd
         6vQAiGs6DNMks0t1Uaf99ScAzQINMu63s3fJvAOWz19KrqgqvxnKvjaIsqNOCSTflUJF
         3kcA==
X-Received: by 10.52.158.163 with SMTP id wv3mr2616047vdb.82.1366151724529;
 Tue, 16 Apr 2013 15:35:24 -0700 (PDT)
Received: by 10.58.219.34 with HTTP; Tue, 16 Apr 2013 15:34:59 -0700 (PDT)
In-Reply-To: <CAMP44s38M7P0T1Wjhfv=XryoUevuxGwrik4pXwfkUfdpPNrXTQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221486>

On Tue, Apr 16, 2013 at 3:48 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> Here it goes. The remote helper ref is going to be used to tell
> fast-export which refs to negate (e.g. ^refs/testgit/origin/master),
> so that extra commits are not generated, which the remote helper
> should ignore anyway, because it should already have marks for those.
> So doing two consecutive pushes, would push the commits twice.
>
> It's worth noting this is the first time anybody asks what is the
> negative effect of this not getting fixed.

Yes, but what is noteworthy about it is that you did not include that
in your commit message to begin with.  This is the commit message
request from Documentation/SubmittingPatches:

    The body should provide a meaningful commit message, which:

      . explains the problem the change tries to solve, iow, what is wrong
        with the current code without the change.

      . justifies the way the change solves the problem, iow, why the
        result with the change is better.

      . alternate solutions considered but discarded, if any.
