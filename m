From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 2/2] bash: not all 'git bisect' subcommands make sense
 when not bisecting
Date: Mon, 11 Oct 2010 00:05:52 +0200
Message-ID: <AANLkTi==oCKgw86fy6sPiPuKuownsbob3xXiY=hHhYrQ@mail.gmail.com>
References: <1286746774-7877-1-git-send-email-szeder@ira.uka.de> <1286746774-7877-2-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Mon Oct 11 00:06:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P542A-0005eK-M3
	for gcvg-git-2@lo.gmane.org; Mon, 11 Oct 2010 00:06:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752070Ab0JJWGP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Oct 2010 18:06:15 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:41696 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752014Ab0JJWGO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Oct 2010 18:06:14 -0400
Received: by gyg13 with SMTP id 13so564559gyg.19
        for <git@vger.kernel.org>; Sun, 10 Oct 2010 15:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=Ev5Lms89QriabEq30kZ/QQ7Tm+m2spLZVveCOQlH/Uw=;
        b=hPhm7zWztd9moddJYomAQ40+oyuAOKVijVLg9JXEwpvmJ/E0hpGrKVL8vmzKVZjPnT
         R1eVgtKrzJEcWHf7A4C5zNv8VkEJ6Mk13r5MMyrjuAQBf0K9T3KtBOmZl6KlxIHQa374
         mUvk/kaD/onUIOXM4nx/jkLCK0MFPT+6g+DlA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=uUOFub09sK3jBK9hQUmvDQLiteBsiyydMEgpbZ3iTDR70pR2oQmUaMKhnUg2NIG3jz
         d2JcHRdJKu9IvLnLZ1s2GQ6/CS9MSWwbKC2ERyx//agg1BYY88Y4GH/DP8ixTfgVkqdE
         SEFfOlqAUv8v5qVQQBZyAu1Jo1NDhDwF6Wpig=
Received: by 10.151.41.21 with SMTP id t21mr795416ybj.158.1286748372996; Sun,
 10 Oct 2010 15:06:12 -0700 (PDT)
Received: by 10.151.15.8 with HTTP; Sun, 10 Oct 2010 15:05:52 -0700 (PDT)
In-Reply-To: <1286746774-7877-2-git-send-email-szeder@ira.uka.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158722>

Heya,

On Sun, Oct 10, 2010 at 23:39, SZEDER G=C3=A1bor <szeder@ira.uka.de> wr=
ote:
> ... but only 'start' and 'replay'. =C2=A0The other commands will eith=
er
> error out or offer to start bisecting for the user.

I'm not sure, following the same concept "git rebase" should not offer
"--continue" if you're not rebasing. It might just be frustrating for
the user since they might not realize they're not bisecting yet.

--=20
Cheers,

Sverre Rabbelier
