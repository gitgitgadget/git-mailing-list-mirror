From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] Remove Git's support for smoke testing
Date: Sun, 12 Feb 2012 01:09:50 +0100
Message-ID: <CACBZZX7pDYFqSUjqDjjEFZBaTsoN9oa9vy5Cq4CckP2nZSSRyw@mail.gmail.com>
References: <1324660098-26666-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 12 01:10:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RwN1H-0008Qe-PT
	for gcvg-git-2@plane.gmane.org; Sun, 12 Feb 2012 01:10:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755320Ab2BLAKN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 11 Feb 2012 19:10:13 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:62900 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755124Ab2BLAKM convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Feb 2012 19:10:12 -0500
Received: by lagu2 with SMTP id u2so3198568lag.19
        for <git@vger.kernel.org>; Sat, 11 Feb 2012 16:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=swDbzka7QvZD084nX0hLyQpjJoUPTzPzw+X5RYAdu10=;
        b=SUqf5TSX6Ww5X2HYDDxA/kwaWWT4CPW1bPTRobDfS7u/GmGqLqCL1UdtmNgSpwNcHE
         JGfywz3UZn9lfzkUyoD8jF9qLqdR/w0YFovhkcRmnpd4HN2Ff4op4sbbZzhgKF4qkiD5
         iBSyOOKnPdd2ywd44Iw1/VFvLIR/LQU2zhinw=
Received: by 10.112.84.1 with SMTP id u1mr3931992lby.35.1329005410472; Sat, 11
 Feb 2012 16:10:10 -0800 (PST)
Received: by 10.112.1.230 with HTTP; Sat, 11 Feb 2012 16:09:50 -0800 (PST)
In-Reply-To: <1324660098-26666-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190549>

On Fri, Dec 23, 2011 at 18:08, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <=
avarab@gmail.com> wrote:
> I'm no longer running the Git smoke testing service at
> smoke.git.nix.is due to Smolder being a fragile piece of software not
> having time to follow through on making it easy for third parties to
> run and submit their own smoke tests.

Junio, could you please apply this? The current release's t/README
file is pointing to a service I'm not running anymore.
