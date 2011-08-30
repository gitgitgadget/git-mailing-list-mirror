From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH] t3903: fix misquoted rev-parse invocation
Date: Tue, 30 Aug 2011 11:52:53 +1000
Message-ID: <CAH3AnrophV=bi+70B8EnfZpBQXVbEAJ9nSo9UbZ2svDNre9W=A@mail.gmail.com>
References: <fa41d38f9297ca14b61e05033c9d1b5f5a778263.1314662636.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Aug 30 03:53:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QyDVb-0002yu-0K
	for gcvg-git-2@lo.gmane.org; Tue, 30 Aug 2011 03:52:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751568Ab1H3Bwy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Aug 2011 21:52:54 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:64671 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750778Ab1H3Bwx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Aug 2011 21:52:53 -0400
Received: by vxi9 with SMTP id 9so4725803vxi.19
        for <git@vger.kernel.org>; Mon, 29 Aug 2011 18:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=o/uFY8dwrGe4nor/Vnvpr2dFlz+z0ONlDRI5nvqREVs=;
        b=fbz8wh5OyzJemMs3Kl62gPI1jT0sRePpF3ZbwArq/K1zUpVpvQhCrIVtqDAC39TPT6
         OR3L4ROJL6IRSHa+qh2nPZfEc2jtEgr6BjSrmTO/BsjBluPv9dOLU2wFKZGs8kb5EBUV
         qcHjVnxbNSmk8mAgH4uauvMEvRWxLb02MyDiM=
Received: by 10.52.67.144 with SMTP id n16mr766217vdt.382.1314669173197; Mon,
 29 Aug 2011 18:52:53 -0700 (PDT)
Received: by 10.52.188.7 with HTTP; Mon, 29 Aug 2011 18:52:53 -0700 (PDT)
In-Reply-To: <fa41d38f9297ca14b61e05033c9d1b5f5a778263.1314662636.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180384>

On Tue, Aug 30, 2011 at 10:06 AM, Thomas Rast <trast@student.ethz.ch> w=
rote:
>
> !"git ..." hopefully always succeeds because "git ..." is not the nam=
e
> of any executable. =C2=A0However, that's not what was intended. =C2=A0=
Unquote
> it, and while we're at it, also replace ! with test_must_fail since i=
t
> is a call to git.
>
> Signed-off-by: Thomas Rast <trast@student.ethz.ch>
> ---

Oops.

Acked-by: Jon Seymour <jon.seymour@gmail.com>

| Apologies for resend, didn't realise my gmail was sending in rich tex=
t.

jon.
