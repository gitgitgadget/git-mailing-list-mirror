From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Transparently encrypt repository contents with GPG
Date: Fri, 13 Mar 2009 12:17:37 +0100
Message-ID: <fabb9a1e0903130417x36121bd5ya8b323e0a80bbd8f@mail.gmail.com>
References: <978bdee00903121419o61cd7a87rb55809796bd257d7@mail.gmail.com>
	 <fabb9a1e0903121434u4a3d71bdi6277071f54557a7e@mail.gmail.com>
	 <49BA39A1.9090203@drmicha.warpmail.net>
	 <200903131215.49336.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Matthias Nothhaft <matthias.nothhaft@googlemail.com>,
	git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Mar 13 12:19:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Li5QE-0000Lh-F0
	for gcvg-git-2@gmane.org; Fri, 13 Mar 2009 12:19:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754959AbZCMLRm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Mar 2009 07:17:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754312AbZCMLRl
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Mar 2009 07:17:41 -0400
Received: from mail-bw0-f175.google.com ([209.85.218.175]:54761 "EHLO
	mail-bw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754413AbZCMLRl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Mar 2009 07:17:41 -0400
Received: by bwz23 with SMTP id 23so76488bwz.37
        for <git@vger.kernel.org>; Fri, 13 Mar 2009 04:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=DsXI9gmqaTonzmjAinTceluORsyI0uNJcuiRC27atF8=;
        b=vH9mPnBaCMgsWkQ/ZA1ZO00PXrnMq0wCZAjmQP7mw8DxFLKIVb7S8KTqwCtyagLmFT
         3cOoAIQzgfyGkmAy9874uLRua6NKL8ioX/BLqaN5pR6Qz2NBBGBskNwFNo4Up4jDtCb2
         LFPvIP6uleuQyhF2SNVY4I01xfzGrUSGYhYh4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=UrjCJXot1w6EPPpoPVpxM+SP/fLc8k8RDrJIfg4Hbw/bMrukeowSWdtH51aSyzCsLh
         cO1zr4G8kqmk2BNZ7vvbvWKAR5L0uMCUS+mBX2ov6/1UtSJJnK9KkuVqQc8JwNwNP9c6
         K9xeZRafus3phP9UV1x+QKUY6iwDbFJkzpWzQ=
Received: by 10.103.240.5 with SMTP id s5mr584450mur.133.1236943057895; Fri, 
	13 Mar 2009 04:17:37 -0700 (PDT)
In-Reply-To: <200903131215.49336.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113173>

Heya,

On Fri, Mar 13, 2009 at 12:15, Thomas Rast <trast@student.ethz.ch> wrote:
> Not to mention that this makes most source-oriented features such as
> diff, blame, merge, etc., rather useless.

I would assume that smudge takes care of this somehow, it'd seem like
a rather useless feature otherwise :).

-- 
Cheers,

Sverre Rabbelier
