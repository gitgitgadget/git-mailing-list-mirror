From: Ralf Thielow <ralf.thielow@googlemail.com>
Subject: Re: Please review this pull request for maint branch with update of de.po
Date: Tue, 8 May 2012 09:48:08 +0200
Message-ID: <CAN0XMOLeUxTgLw2KEJDJt8x6ebtJE2en-ChY3x=fbQdrH44COg@mail.gmail.com>
References: <CANYiYbFf73hVen2sg1viNrXxt-g+tP=bF_ryBF8JYp0ZAL0b6A@mail.gmail.com>
	<CANYiYbFiwvy8Lw+XQTehbc3k2FukrvhCvR6urfAR_3xVqXxNZA@mail.gmail.com>
	<7vtxzr1kbd.fsf@alter.siamese.dyndns.org>
	<87ipg75drv.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	Jiang Xin <worldhello.net@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	=?UTF-8?Q?Jan_Kr=C3=BCger?= <jk@jk.gs>,
	Christian Stimming <stimming@tuhh.de>,
	Git List <git@vger.kernel.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Tue May 08 09:48:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRf9b-0006fp-Cb
	for gcvg-git-2@plane.gmane.org; Tue, 08 May 2012 09:48:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752299Ab2EHHsK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 May 2012 03:48:10 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:39945 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751071Ab2EHHsJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 May 2012 03:48:09 -0400
Received: by yhmm54 with SMTP id m54so5032563yhm.19
        for <git@vger.kernel.org>; Tue, 08 May 2012 00:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=q9AbOFr/OeU72nFi61hU17bX9Jld8B8xL+TXnEgA2z0=;
        b=c5JT15KxipW8ZEGt/uzcDDwWk8elv4GOgf3XYPCmBab4bguoZrRT1aWT5laZS8hK14
         Kj762OnUk5+ijwIti/xSREHc6NBPTZW/AeIQBOeZHVcmgYuuOjwF+hx4ViKGZbgvgRpb
         4I+6cy9UNJNzlPtZnTnJ4yK9QbVlFgQsTpm5yEhNlNCnCbWpamtkiGWPOSV7CpbCa+h3
         /lQ6uMVwgTglYv22CmCJP9cjGzXld80V4dGXt0DEt1hfdA08y4bC2X9m2FVwiHZDzmaa
         A9uq6pktiUmgUd4YbX7n3zODpIK0KIUQ2jbuXIbhE9sDgSBh7cszDhm1qwsrkrVnks9a
         qhHA==
Received: by 10.236.181.129 with SMTP id l1mr8398753yhm.59.1336463288499; Tue,
 08 May 2012 00:48:08 -0700 (PDT)
Received: by 10.146.218.6 with HTTP; Tue, 8 May 2012 00:48:08 -0700 (PDT)
In-Reply-To: <87ipg75drv.fsf@thomas.inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197346>

> I suspected something like this might happen, but proposed a
> simultaneous change anyway. =C2=A0My bad. =C2=A0Ralf, can you split i=
t or should I
> resend?

Is it ok for you if I remove your change to git-gui completely
from the patch? Perhaps we can sync the translation to
git-gui within a complete new patch (-series). That implies
that Xin and I have to rewrite our history, don't?.
It's pretty much easier to add a new commit which
simply removes the change from git-gui.

Ralf
