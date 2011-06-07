From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 8/8] git_remote_helpers: push all refs during a non-local export
Date: Tue, 7 Jun 2011 19:44:36 +0200
Message-ID: <BANLkTi=D7TGpRtgZn85R5OdHdqrLhaFNHw@mail.gmail.com>
References: <20110607171838.GA21685@sigill.intra.peff.net> <20110607172129.GG22111@sigill.intra.peff.net>
 <BANLkTimQ9ORrhLm7SAETYa+f8ov81wzUaw@mail.gmail.com> <20110607174203.GD23224@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Dmitry Ivankov <divanorama@gmail.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 07 19:45:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QU0LD-0003lX-Mz
	for gcvg-git-2@lo.gmane.org; Tue, 07 Jun 2011 19:45:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756529Ab1FGRpS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2011 13:45:18 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:50735 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755051Ab1FGRpR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2011 13:45:17 -0400
Received: by qyg14 with SMTP id 14so2638661qyg.19
        for <git@vger.kernel.org>; Tue, 07 Jun 2011 10:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=f50bDZ8p8CdRFpB93Ss5iiH4iXm/XyoKBw97AsUyDI4=;
        b=KvAuhFr05G+jYSPhH4OVwjstZcHXdEEOJ2ZvtMB8OSt7YsgM68C0JOc7C/WD+FknTR
         HgBLi1h0DMMKzDbFGnB8/Q15tVnAW2PMFeBVqBQmYmTXReP36YUsshzlG7uxno9yLEXm
         dx7AHAVgoYjZSR3gSX8qt6PtgHL+xtJYBg0cw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=nKvNUQUh3yyNqn1ufr8ENL2Q/MnuViUK7unWZkCEy+5tdT4PVXUeC9GloQXzsQHrr9
         6krS7ZO/JGtsyRurMYlBFFUWlspCqA7naGhGFM4R+31GtJcVjyHN34Dj8V9M4LPdzkMe
         KqXLk3qLemAwPCLhs8QSAjenxuTX+7b9trusQ=
Received: by 10.229.100.20 with SMTP id w20mr4769916qcn.129.1307468716178;
 Tue, 07 Jun 2011 10:45:16 -0700 (PDT)
Received: by 10.229.83.203 with HTTP; Tue, 7 Jun 2011 10:44:36 -0700 (PDT)
In-Reply-To: <20110607174203.GD23224@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175237>

Heya,

On Tue, Jun 7, 2011 at 19:42, Jeff King <peff@peff.net> wrote:
> No, because our fast-export from git will not include branch-a, and this
> is about pushing from the exported staging area.
>
> If the remote rewound their branch-a, we would actually fast-forward it
> back again. This is no different than the current behavior, though,
> which uses matching[1]. It would also update branch-a because it exists
> upstream.

Ah, you are right :).

-- 
Cheers,

Sverre Rabbelier
