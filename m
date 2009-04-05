From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 1/4] sha1-lookup: add new "sha1_pos" function to 
	efficiently lookup sha1
Date: Sun, 5 Apr 2009 21:06:56 +0200
Message-ID: <fabb9a1e0904051206l11a629cald95a794815c2d76f@mail.gmail.com>
References: <20090404225926.a9ad50e0.chriscool@tuxfamily.org> 
	<fabb9a1e0904050317o1399118erb15ddf86d0fe6c3c@mail.gmail.com> 
	<7vvdpjrkp0.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 05 21:09:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqXi7-0004Fv-61
	for gcvg-git-2@gmane.org; Sun, 05 Apr 2009 21:08:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753409AbZDETHR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Apr 2009 15:07:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752869AbZDETHQ
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Apr 2009 15:07:16 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:40938 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754414AbZDETHO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2009 15:07:14 -0400
Received: by fxm2 with SMTP id 2so1608701fxm.37
        for <git@vger.kernel.org>; Sun, 05 Apr 2009 12:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=7QMoPm3/DsNkU63L7KA/SgI8nN+K+DN4P9GLg88t/c8=;
        b=DXBT/9pIK8/GdjEGe795Et0JRGWxY+Vmb2J5AqWKjzT3yTRiCIJDbgvlZpr7J9+iTW
         o3bUcAXP6M1mBWsvXWR5fGtV/twPAwXvC9Q4DpIP32XB/cuco8xYFuizIT/7PBWzKPoj
         e8zsqz7cEcgZUcGTohSjNLiXHcHvh2PZKBTV8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Fc1FwE7PL+pvqpXJSoIskGV64N5IVMkTZtxuxhPCKQ+FZFYH4wm4ZR2DHa1jeXKqkY
         8B5eIQ4eOJ3NLwTUG0Vb85HjoM+TyuOzQOSXn5mlE39lZagRlXGPQ+Qg//2qEdZ7GwL8
         zqoWstTX63+4L3POksbMCMKDb6rQqTmp9uqzc=
In-Reply-To: <7vvdpjrkp0.fsf@gitster.siamese.dyndns.org>
Received: by 10.103.179.1 with SMTP id g1mr1584746mup.48.1238958431264; Sun, 
	05 Apr 2009 12:07:11 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115681>

Heya,

On Sun, Apr 5, 2009 at 20:59, Junio C Hamano <gitster@pobox.com> wrote:
> It's not "going to be", but "has been so for the last two years since
> 5d23e13".

Ah, I did not see that earlier, as I read and commented-on this patch
before reading 3/4.

> It is an assert, and I think Peff's die("BUG: ...") would be a good idea.

As long as the <something that makes sense to the user> does indeed
make sense, right :).

-- 
Cheers,

Sverre Rabbelier
