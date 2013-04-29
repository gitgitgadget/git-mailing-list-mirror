From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Itches with the current rev spec
Date: Tue, 30 Apr 2013 00:40:15 +0530
Message-ID: <CALkWK0nH0n2UZeMh_q4TQuUqzwhp8qGk9Oi+2DExozkuyfKzTg@mail.gmail.com>
References: <CALkWK0n97VLtiR96VEy86645NVoDL2rS-g7LBuLb=JpncdH6VA@mail.gmail.com>
 <20130426101946.433f2d12@chalon.bertin.fr> <517A3E47.6010606@viscovery.net>
 <7v7gjpxjw0.fsf@alter.siamese.dyndns.org> <CAMP44s0-C_TRC_eD_ZbN3WFe4NKWVPQVhh+ME-F5yBBwKs2NdA@mail.gmail.com>
 <7v8v45vvuy.fsf@alter.siamese.dyndns.org> <CALkWK0=W_FxDwc3Tby=h90yc5i8UEuT7maERahFRDQU=hQ633g@mail.gmail.com>
 <7vobcxl3ui.fsf@alter.siamese.dyndns.org> <CALkWK0k7w4xuewnJFNJLk730NSiZOA_1UF0_Dqcnw5Or3GYOcA@mail.gmail.com>
 <7vip35jl7z.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Yann Dirson <dirson@bertin.fr>, Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 29 21:11:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWtTc-0005Ix-3a
	for gcvg-git-2@plane.gmane.org; Mon, 29 Apr 2013 21:11:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932904Ab3D2TLA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 15:11:00 -0400
Received: from mail-ie0-f173.google.com ([209.85.223.173]:37816 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932903Ab3D2TK5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 15:10:57 -0400
Received: by mail-ie0-f173.google.com with SMTP id k5so7803877iea.18
        for <git@vger.kernel.org>; Mon, 29 Apr 2013 12:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=J5yi+Q67OQ8N7EijL5KPqMq1W5Pl67mZJypoeSm4cKo=;
        b=yoBLCG0BC7otsu9hjvpgHAr/hFFa/t4dozf6yjFJu69E16FNgf93wXZEIZzrzMRPgR
         gVozSoR6e6hj7X593siLejtNppWT+OQq9Y6yDfxvdnaFHPOcAIQKv9fTLH9j5FAGFpbf
         M8a35VMjVyuDewJkt5pn9t3YRw+MaY2yIDOegEp1VdacLiSDZn8SIlP370aMLhgq5miE
         6d6xY8tdz5xk+D6PxXc8Jkok0OdAkDBmXWSTxSVWzho6baa9jxYIiBWzSK5DAJhuc74p
         ER7JoDICM3QcuzDMuUbnwammRV5gcy/A/NGVgNf9LkDEwhfZ4ROXIAn9AgN+qZviCmpn
         Dc1g==
X-Received: by 10.42.27.146 with SMTP id j18mr18686614icc.54.1367262656429;
 Mon, 29 Apr 2013 12:10:56 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Mon, 29 Apr 2013 12:10:15 -0700 (PDT)
In-Reply-To: <7vip35jl7z.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222848>

Junio C Hamano wrote:
> Compare these (gitk will give you nicer picture):
>
>    $ git log --oneline --graph --left-right A...B
>    $ git log --oneline --graph --left-right B...A

Darn.  I didn't realize that rev-list had a --left-right to mark
commits with <, >, or - before giving it to the command.  So, that's
one more thing to note: there are positive and negative commits, as
well as commits marked with a direction (in the special case of
--left-right).  Have we missed anything?

> It may be nice if the low-level operated on more than one DAG, but
> it is very close to a proposition to throw the baby with the
> bathwater and restart from scratch.  It is a lot more than a little
> "as an aside" task.

I know too little to comment on the issue.  I was merely musing.
