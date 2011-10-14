From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] daemon: return "access denied" if a service is not
 allowed
Date: Fri, 14 Oct 2011 16:06:46 -0500
Message-ID: <20111014210646.GE16371@elie.hsd1.il.comcast.net>
References: <20111013044544.GA27890@duynguyen-vnpc.dek-tpc.internal>
 <20111013182816.GA17573@sigill.intra.peff.net>
 <7vvcrs181e.fsf@alter.siamese.dyndns.org>
 <20111014131041.GC7808@sigill.intra.peff.net>
 <20111014192326.GA7713@sigill.intra.peff.net>
 <20111014192741.GA13029@sigill.intra.peff.net>
 <7v7h47z5i0.fsf@alter.siamese.dyndns.org>
 <20111014203438.GA15643@sigill.intra.peff.net>
 <7vpqhzxpsc.fsf@alter.siamese.dyndns.org>
 <20111014210506.GA16226@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 14 23:07:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REoy5-0004NN-Pi
	for gcvg-git-2@lo.gmane.org; Fri, 14 Oct 2011 23:07:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754581Ab1JNVG5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Oct 2011 17:06:57 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:37875 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754057Ab1JNVG5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Oct 2011 17:06:57 -0400
Received: by yxp4 with SMTP id 4so1530591yxp.5
        for <git@vger.kernel.org>; Fri, 14 Oct 2011 14:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=kiMdnEIGgS8egLw2e2Zh4pD4pdL8jeW305rnBgeMHI4=;
        b=jafs9a8k+4gvLJTYQIzeKhycd4ztjwtscc5wpMzSr5PJy6EFnAj+Qe64Y8gA49qi4l
         XcjXlMtHR1Vbmn3rvXYqQ6KtuGJaVbmpVe0qkI77aZPjUG0STwKZEv41Qcbn/yaF0n2W
         mHSk0lslILFmkKI4CMn3Man4vzebx4FvMANP0=
Received: by 10.151.43.17 with SMTP id v17mr8095197ybj.79.1318626416619;
        Fri, 14 Oct 2011 14:06:56 -0700 (PDT)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id e19sm12766906anm.6.2011.10.14.14.06.55
        (version=SSLv3 cipher=OTHER);
        Fri, 14 Oct 2011 14:06:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20111014210506.GA16226@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183612>

Jeff King wrote:

> Oh. Then look again at 1/2. It supports both forms; I just didn't bother
> advertising the --no form in the manpage, since it was the default.

Yes, and that was the bug Junio mentioned.  If we are considering 2/2
then admins will need to know about the --no form before we roll out
the change in default. :)
