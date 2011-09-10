From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH v3 0/4] Signed push
Date: Sat, 10 Sep 2011 17:17:14 +0200
Message-ID: <CAGdFq_hWVPCEeJKKccp4Wc-j+XMSFXqRf6VYd7ngLER8RhODRQ@mail.gmail.com>
References: <1315512102-19022-1-git-send-email-gitster@pobox.com>
 <1315600904-17032-1-git-send-email-gitster@pobox.com> <7vipp1otyp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 10 17:19:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R2PKs-0007YI-Dt
	for gcvg-git-2@lo.gmane.org; Sat, 10 Sep 2011 17:19:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933311Ab1IJPRz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Sep 2011 11:17:55 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:40512 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753319Ab1IJPRy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Sep 2011 11:17:54 -0400
Received: by pzk37 with SMTP id 37so4093329pzk.1
        for <git@vger.kernel.org>; Sat, 10 Sep 2011 08:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=qqqKXi1Rh0rzEJ95npOf/ctp5SSdXe7r1Z656eTbMtA=;
        b=pY3zeatQMf5xvwz81iTdA9LA8AIr8jH3CEkdS8RXSCZOseNrtZkgwxG/OfILfvAUDY
         KXIaffqLrw0qj4eqpCjVY8W3ekqY+5wK3kSwO1oZbHCJZho3jn6M4lIvGgFypPod/1YK
         +9B27A4GlpELVvEVnTU7vRQ/csfqLBLDp7L0w=
Received: by 10.68.6.1 with SMTP id w1mr3185447pbw.366.1315667874255; Sat, 10
 Sep 2011 08:17:54 -0700 (PDT)
Received: by 10.68.59.39 with HTTP; Sat, 10 Sep 2011 08:17:14 -0700 (PDT)
In-Reply-To: <7vipp1otyp.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181156>

Heya,

On Sat, Sep 10, 2011 at 07:19, Junio C Hamano <gitster@pobox.com> wrote:
> Even under v2 design, if somebody who has access to both k.org (public)
> and github (proprietary in the hypothetical universe) would want to
> combine the signed-push notes to see a unified picture (perhaps I push to
> these two sites with different frequencies), he can fetch signed-push
> notes from both sites and merge them himself. But v3 design also allows
> anybody who has access to k.org (which is public so by definition that
> truly is anybody) to peek into signed-push notes at k.org to learn more
> than he should be able to.

I think this is also some further motivation to have a
refs/remotes/github/notes/signed-push and a
refs/remotes/korg/notes/signed-push, rather than have everything
automatically go into refs/notes/signed-push when fetching from a
remote.

(If I misremembered and it's already that way, please ignore this message :P)

-- 
Cheers,

Sverre Rabbelier
