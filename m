From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH v2 1/4] Add date formatting and parsing functions relative 
	to a given time
Date: Mon, 31 Aug 2009 08:08:37 +0200
Message-ID: <81b0412b0908302308s3d02bb89o786a4b452d67c43@mail.gmail.com>
References: <20090831022228.GA4833@coredump.intra.peff.net>
	 <20090831022605.GA5507@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Aug 31 08:08:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mi04M-00024V-39
	for gcvg-git-2@lo.gmane.org; Mon, 31 Aug 2009 08:08:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754448AbZHaGIg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2009 02:08:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754442AbZHaGIg
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Aug 2009 02:08:36 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:64534 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754337AbZHaGIf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2009 02:08:35 -0400
Received: by bwz19 with SMTP id 19so2585382bwz.37
        for <git@vger.kernel.org>; Sun, 30 Aug 2009 23:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=vG0/C3Tx6GAxHg4h26Dpfs8sYE6ShKwMsLNdDfN9dSw=;
        b=Y69nLidx9RDvb+98ho8Iu3IoMOFz17lLX+KGvQHh8NFBD3xdpiNIBwMGvvTlwShg8g
         K9fR2+NfarUkiS+NbbGjtO6/wbyw9NnXBGI15mZu5o6biyfAaxqCHAaiLb9dACHIKN1V
         w+PJ+udk7V3AOHcjBukNoZl4KBgCwAP5Q6HKc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=hvVCGscsBc+v2PAxMdknfAJ/68XIvH2pMs8EYEgnnQ1K5fU5vqF/Y7dWV2MjqoZDyr
         h360G9w70gXCfjJj8g2LAZc/TEVQ3k5pqN4swSWy8RQ7QjkS6I0JzKkMWgm/Iru6THkO
         931uUPkQq8XWFyq4V+nmVIySDwY1zTy3dV9DE=
Received: by 10.204.156.24 with SMTP id u24mr3950160bkw.172.1251698917099; 
	Sun, 30 Aug 2009 23:08:37 -0700 (PDT)
In-Reply-To: <20090831022605.GA5507@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127462>

On Mon, Aug 31, 2009 at 04:26, Jeff King<peff@peff.net> wrote:
> From: Alex Riesen <raa.lkml@gmail.com>
>
> The main purpose is to allow predictable testing of the code.
>
> Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> Same as previous 1/3, but rebased onto lt/approxidate topic. The merge
> ended up as quite a mess because of textual differences, so I had to
> fix up a fair bit by hand; Alex, please confirm that I didn't screw
> anything up too badly right before putting your name at the top. ;)

Looks good.
