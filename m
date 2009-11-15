From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: What's cooking in git.git (Nov 2009, #03; Sun, 15)
Date: Mon, 16 Nov 2009 00:32:47 +0100
Message-ID: <fabb9a1e0911151532w1ad81a0bi8b13ca59d13cdd79@mail.gmail.com>
References: <7vtywwm6i4.fsf@alter.siamese.dyndns.org> <alpine.LNX.2.00.0911151711170.14365@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Nov 16 00:33:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9oaq-0005vP-5o
	for gcvg-git-2@lo.gmane.org; Mon, 16 Nov 2009 00:33:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751447AbZKOXdE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Nov 2009 18:33:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751175AbZKOXdD
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Nov 2009 18:33:03 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:46761 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751156AbZKOXdC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Nov 2009 18:33:02 -0500
Received: by bwz27 with SMTP id 27so5146666bwz.21
        for <git@vger.kernel.org>; Sun, 15 Nov 2009 15:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=+YCOfibX4lOcxbP1mda0QnCCUmk47Vz8TrP9OcD1jxM=;
        b=mDfoq86378Ip/sFSmVjoRQVISwKB9GhbIs0Sh0nqXchP/XN65RZiTjU+Pci+tz9SEw
         GJQR6m7Ws+ljqHlHUEB3gxYxI043B1Oob6/cq+gEgH2urb9ggeLtIwT1mtsle1/WYLPN
         DU2CQrBLqHr5ATbKAIjsPRBmtpAKuYGsnBPmA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=nZPXbIDEPMIk0+TbTQAsBox4LUmNw/3QTJZPVxD0y6vCcX9MSxeBBW2CuJpAnapp76
         j2UBTvnhZBDmP9ow9J75zg7wiucWCO/m2OydERlfVCbbFg4Im+BEq6WuZo1L/fYablti
         lrdM3g1h+TJkhQ3GIzaZ4WpqJGdY9Sk40gznQ=
Received: by 10.216.88.144 with SMTP id a16mr942279wef.208.1258327987116; Sun, 
	15 Nov 2009 15:33:07 -0800 (PST)
In-Reply-To: <alpine.LNX.2.00.0911151711170.14365@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132971>

Heya,

On Sun, Nov 15, 2009 at 23:26, Daniel Barkalow <barkalow@iabervon.org> wrote:
> My initial cleanup for "Allow helper to map private ref names into normal
> names" was wrong (and the original was supposed to be RFC, and isn't
> signed-off); I identified the bug he reported in it, but haven't gotten
> positive test results from him yet, and the series obviously needs a
> proper version rolled in before it goes into next.

Sorry, I tested, got primary positive results, then wanted to test
something else and instead of:
~/code$ rm -rf test

I did:
~/code$ rm -rf git

I hate it when my fingers don't listen. Anyway, I ^C-ed and managed to
save my worktree, but most of my git/.git was gone already. I'll get
back to you tomorrow with more results since the time I was going to
spend on running it through valgrind was wasted trying to recover my
git repo :P.

-- 
Cheers,

Sverre Rabbelier
