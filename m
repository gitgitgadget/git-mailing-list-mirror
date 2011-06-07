From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 4/8] t5800: document some non-functional parts of remote helpers
Date: Tue, 7 Jun 2011 19:34:04 +0200
Message-ID: <BANLkTimAngV2BxODJ6gCn4zGh7+p+MnhZQ@mail.gmail.com>
References: <20110607171838.GA21685@sigill.intra.peff.net> <20110607172030.GC22111@sigill.intra.peff.net>
 <BANLkTinx0F7nfpmqx7AWChab3g-4MNnswQ@mail.gmail.com> <20110607172832.GA23224@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Dmitry Ivankov <divanorama@gmail.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 07 19:34:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QU0Az-0007sh-Ts
	for gcvg-git-2@lo.gmane.org; Tue, 07 Jun 2011 19:34:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757403Ab1FGRep (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2011 13:34:45 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:62469 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754456Ab1FGRep (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2011 13:34:45 -0400
Received: by qyg14 with SMTP id 14so2633383qyg.19
        for <git@vger.kernel.org>; Tue, 07 Jun 2011 10:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=f8rhMGDjwR55BDYsdQPtEQyIM+uTY/gXypeS/slotfU=;
        b=hRxFdW3ffENzbo25UVuGT3AKdOdFF/uucKu6sOqpWTYPhLWYKBreUSc42vweEv8C5M
         DN2SE9gR+g7El7lNe9KrGCfZcR4U/jNi3nGJuURjSwu+AcNApEtMzhDZ8uPRSy5rcTyS
         A+wmGTUAzXdxTeQyNa+JZu+FhGZfaw+DuU0OM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=BoqydOpsYUKSTsf3ktJLoY/90LqTeWiVsWIlUOtRYbIBShawWgWUQaMVjBU7rbSDJk
         Bd2cD0q0lPoxDQpMqlFq3CjGBWNqAqTXbiPu9LiGMq7/gtftyjZjHv6mJos6Z0UE37Br
         bbY8hzq+BReNjWBOhuZy1tZqo7jL/KI3Lm7s4=
Received: by 10.229.127.99 with SMTP id f35mr4753956qcs.91.1307468084080; Tue,
 07 Jun 2011 10:34:44 -0700 (PDT)
Received: by 10.229.83.203 with HTTP; Tue, 7 Jun 2011 10:34:04 -0700 (PDT)
In-Reply-To: <20110607172832.GA23224@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175234>

Heya,

On Tue, Jun 7, 2011 at 19:28, Jeff King <peff@peff.net> wrote:
> Isn't that the case already with import? The helper writes into a
> staging area (like refs/testgit), and then we let git pick the results
> out of there.

The staging area solution is sub-optimal, see [0] for the thread I was
referring to.

[0] http://thread.gmane.org/gmane.comp.version-control.git/174693/focus=174787

-- 
Cheers,

Sverre Rabbelier
