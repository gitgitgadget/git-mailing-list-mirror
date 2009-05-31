From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH] http*: cleanup slot->local after fclose
Date: Sun, 31 May 2009 16:48:58 +0800
Message-ID: <be6fef0d0905310148g7ee7a642jf6a9661d6e62b40b@mail.gmail.com>
References: <49F1EA6D.8080406@gmail.com> <20090530091755.GA13578@localhost>
	 <be6fef0d0905300231k5167f3efle9a450419bdfa1cb@mail.gmail.com>
	 <20090530093717.GA22129@localhost>
	 <be6fef0d0905300352o33694420m9c988daa554420a3@mail.gmail.com>
	 <20090530230153.527532b0.rctay89@gmail.com>
	 <20090531000955.953725d9.rctay89@gmail.com>
	 <7vy6sdssnk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Clemens Buchacher <drizzd@aon.at>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 31 10:49:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MAgj5-0004u3-9V
	for gcvg-git-2@gmane.org; Sun, 31 May 2009 10:49:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757313AbZEaIs6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 May 2009 04:48:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757240AbZEaIs5
	(ORCPT <rfc822;git-outgoing>); Sun, 31 May 2009 04:48:57 -0400
Received: from mail-px0-f191.google.com ([209.85.216.191]:33196 "EHLO
	mail-px0-f191.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751626AbZEaIs4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 May 2009 04:48:56 -0400
Received: by pxi29 with SMTP id 29so2237703pxi.33
        for <git@vger.kernel.org>; Sun, 31 May 2009 01:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=qQlqXXGQ++V42JiI+VypowYEQ+MGtIqOjbYK4uv/hyI=;
        b=oe7sX3DxeYmWM13fClkKP6CV0+RbbSFrvThe75r0pQy6IQotX742yQCNG6xqkLOCfK
         pj18dSVNKp0ic1I/JWgfwHa/WOgUbwzD6XCTyLtyUwnsEzBanzFthQBuKnCFEZjOjohD
         Ss11p0yuPyk2oybcunkMREUdhCEJCxz6PMik0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=MZ67L0zumLMN1gGfPt17FON/xuik4oEHjhL2HFymUbYDWf46e8fjdBQ6LOOywgcinD
         0JqJTvNYIkTaVltBsIF0livI+jOnu3gtiNquzBLL4ILmMWl7325xyEMF5SMRyiAFtzFG
         j5plJRL/AkNWhVR75RRFoIurQzCoWrnwYNoFI=
Received: by 10.141.29.14 with SMTP id g14mr4316946rvj.232.1243759738293; Sun, 
	31 May 2009 01:48:58 -0700 (PDT)
In-Reply-To: <7vy6sdssnk.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120392>

Hi,

On Sun, May 31, 2009 at 2:17 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Shouldn't a fix instead be queued for 'maint', without "refactoring"?

one on the way.

> Is there a reproducible repipe you can add to the test script?

what do you mean by "repipe"? To my mind, reproducing Clemens' issue
would require some code manipulation and compiling.

> Hmm, what's the point of setting NULL to request->slot if you are already
> freeing "request" that contains the field?

you do have a point. :)

-- 
Cheers,
Ray Chuan
