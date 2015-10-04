From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH v1] Add Travis CI support
Date: Sat, 3 Oct 2015 18:27:06 -0700
Message-ID: <CAPc5daXkn=C-D5RQCw2w+JrHn7XZA6X-P4F-PugRe-S4Z2RO0g@mail.gmail.com>
References: <1443131004-39284-1-git-send-email-larsxschneider@gmail.com>
 <xmqqeghnuy8t.fsf@gitster.mtv.corp.google.com> <1443150875.3042.3.camel@kaarsemaker.net>
 <699c08632232180166145f70c7f16645@dscho.org> <CAE5ih7_f8qy9WvmgRUR6-qFwB4WFhZ6Qr5iOpE0YxqJH8AsZyw@mail.gmail.com>
 <vpq7fnc83ki.fsf@grenoble-inp.fr> <vpq4mie1m3n.fsf@grenoble-inp.fr>
 <xmqqlhbqcrf7.fsf@gitster.mtv.corp.google.com> <CAFY1edZSNKepx_+2U=C-raOBiVK3Zh2r_Y_NO2-RtbhH_n-tdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Luke Diamand <luke@diamand.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Dennis Kaarsemaker <dennis@kaarsemaker.net>,
	Lars Schneider <larsxschneider@gmail.com>,
	Git Users <git@vger.kernel.org>
To: Roberto Tyley <roberto.tyley@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 04 03:27:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZiY5l-0005LD-3y
	for gcvg-git-2@plane.gmane.org; Sun, 04 Oct 2015 03:27:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751070AbbJDB11 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Oct 2015 21:27:27 -0400
Received: from mail-ig0-f178.google.com ([209.85.213.178]:35999 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750990AbbJDB10 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Oct 2015 21:27:26 -0400
Received: by igcrk20 with SMTP id rk20so40302496igc.1
        for <git@vger.kernel.org>; Sat, 03 Oct 2015 18:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=5VIYoZOjYZlVSxnP7Lo2iWo8yeOwZXb1DzS/nXapLgg=;
        b=SansvhG1viri3jaLb01CeH1Bcdb3w4z9qrXTkTvD+t4FxacVBP0/gehSAQbDdz9EM3
         8AnL+SDM3lbTM7BqRG/ebsDU4MyNpcmT0EuXYSHAu5AoU/dbMVLv+Iv4tk1PQmDi9yHW
         GmqoNKbX/eraNvKixV/x8Al5krmjeNYatkv1Zwk4m2UFUix/oo7Up5XWKCfZiicrCSdQ
         zJxavlW2tuhu5shc2CWCmtRXQleorspE0r+uBjRgtH1IkXNFse68YjSp1OxRPxWQ5wT6
         xGHa15sKS1G7l714CLUiRZWb8QyNLDl0LAItDAjHVG5ygRzSpIOj19ifcRNh4F+TwrPb
         Nt4A==
X-Received: by 10.50.61.137 with SMTP id p9mr4086769igr.37.1443922046113; Sat,
 03 Oct 2015 18:27:26 -0700 (PDT)
Received: by 10.36.79.84 with HTTP; Sat, 3 Oct 2015 18:27:06 -0700 (PDT)
In-Reply-To: <CAFY1edZSNKepx_+2U=C-raOBiVK3Zh2r_Y_NO2-RtbhH_n-tdg@mail.gmail.com>
X-Google-Sender-Auth: ww9uX63zRTsCs6rsyTjXhPZwN84
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278988>

On Sat, Oct 3, 2015 at 3:23 PM, Roberto Tyley <roberto.tyley@gmail.com> wrote:
>
> Given this, enabling Travis CI for git/git seems pretty low risk,
> are there any strong objections to it happening?

I still don't see a reason why git/git needs to be the one that is
used, when somebody
so interested (and I seem to see very many of them in the thread) can
sacrifice his or
her own fork and enable it him or herself.
