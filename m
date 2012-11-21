From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v5 00/15] fast-export and remote-testgit improvements
Date: Wed, 21 Nov 2012 10:46:54 +0100
Message-ID: <CAMP44s3h5+KS3ixoLkJeiS+n_neBV-Dyj=Cww0ZrU6UKsNxphQ@mail.gmail.com>
References: <1352642392-28387-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Max Horn <max@quendi.de>, Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Brandon Casey <drafnel@gmail.com>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Pete Wyckoff <pw@padd.com>, Ben Walton <bdwalton@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 21 10:47:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tb6tk-0006cZ-GS
	for gcvg-git-2@plane.gmane.org; Wed, 21 Nov 2012 10:47:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753340Ab2KUJq5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2012 04:46:57 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:64886 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752923Ab2KUJqz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2012 04:46:55 -0500
Received: by mail-ob0-f174.google.com with SMTP id wc20so6835561obb.19
        for <git@vger.kernel.org>; Wed, 21 Nov 2012 01:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=a5sJsRlLrm/ZyeQsUKwxslSMg8DNQAILeBPVBcbp5vE=;
        b=oICKAYlDTlK4KbwyC9gThmWoRg5DCJF951clRSytF/zMG1sYv5qqdCVx29OEcmbc+c
         tSEAgG2BKFqZDk6FKYFLg9rxByKhOJM2gWOfrlC0tJHpxvWt9TT7pOf4DGJVlzjEnmfV
         AdcYivQxpryTjN5jlcDjkwaYdcUg482ThYWNV5el2ar6M0q2WknTQzi/awKilSeqmv2F
         gM2RwhaePMmC1VJS59aQZRHbZVTqsPlAMzWEcPFUF3N8DNeCOlleqrtLDRHeFGYgZV3T
         CR1QLtKN2iSqgnjZFpuolvqhGfq7/BY2/VfHSkwK5NwV4eKmk/2maiWGA4euxplDrRAB
         KBlg==
Received: by 10.60.22.161 with SMTP id e1mr15448026oef.93.1353491215000; Wed,
 21 Nov 2012 01:46:55 -0800 (PST)
Received: by 10.60.28.232 with HTTP; Wed, 21 Nov 2012 01:46:54 -0800 (PST)
In-Reply-To: <1352642392-28387-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210147>

On Sun, Nov 11, 2012 at 2:59 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:

Since these are having some problems getting in, let me point out
which I think are important, and which not.

> Felipe Contreras (15):
>   fast-export: avoid importing blob marks

This fixes a bug, but it's probably not hitting many people.

>   remote-testgit: fix direction of marks
>   remote-helpers: fix failure message

I don't care.

>   Rename git-remote-testgit to git-remote-testpy
>   Add new simplified git-remote-testgit

These I think are good.

>   remote-testgit: get rid of non-local functionality
>   remote-testgit: remove irrelevant test
>   remote-testgit: cleanup tests

Just cleanups.

>   remote-testgit: exercise more features

I think it's good to catch more issues, but I don't care much.

>   remote-testgit: report success after an import
>   remote-testgit: make clear the 'done' feature

These are good, but I could drop them.

>   fast-export: trivial cleanup
>   fast-export: fix comparison in tests

Obvious and correct, but I don't care.

>   fast-export: make sure updated refs get updated

This is the important one. It fixes real issues quite visible on remote helpers.

>   fast-export: don't handle uninteresting refs

This is nice, but can be dropped.


I don't see what are the chances of any of them getting merged, but at
least 'fast-export: make sure updated refs get updated' should
definitely go in. Please advice at which level I should drop the
patches, because at this point it doesn't look like any of them are
going in.

Cheers.

-- 
Felipe Contreras
