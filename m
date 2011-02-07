From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [1.8.0] git checkout refs/heads/foo checks out branch foo
Date: Mon, 7 Feb 2011 22:36:36 +0100
Message-ID: <AANLkTinmqTi4cYbR6PtSxt6itCvFQDuT_sE1tjx45a3h@mail.gmail.com>
References: <alpine.DEB.1.10.1102062234010.3788@debian> <20110207205934.GD13461@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 07 22:37:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmYlx-00045A-3k
	for gcvg-git-2@lo.gmane.org; Mon, 07 Feb 2011 22:37:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754940Ab1BGVhS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Feb 2011 16:37:18 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:37288 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754917Ab1BGVhR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Feb 2011 16:37:17 -0500
Received: by ywo7 with SMTP id 7so1657880ywo.19
        for <git@vger.kernel.org>; Mon, 07 Feb 2011 13:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=PoxY48sV2gy+uTMGEy3nEMaXsLhsJdo5xr4BVqT8DY4=;
        b=c0oJk+t3o2rWQm1tOyXzKfyEygBFi+HK5Hy/ugndeleLZPprgU4wLizHQvcP4z0UIl
         nWGL2swnXwYaR3yrUTcE9jCEFegN1/eZkvl49zvE4cYRidAJMJwnJvpxoXuIJBiCSUCH
         fR2pC8n+r9MBEW0wNKLh2eBoUf2+BcwzkxBYc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=dOBDTyRS1rPo6cQbRDucXGeexQtfQ/QPozz+UmEVIXb60dLdrMpebgIsHjp0nzcKty
         LN9SFjq+zjX4zcmTlWPX7bsAVvZEPKAQ+zl7bagQZigqzAvOQpKky1M+DvegRnkgA0Ud
         /mpF7uhLEm7BiSN0MVcmiCVhC6ndRfgfsTkS8=
Received: by 10.150.54.20 with SMTP id c20mr358154yba.55.1297114636291; Mon,
 07 Feb 2011 13:37:16 -0800 (PST)
Received: by 10.150.51.6 with HTTP; Mon, 7 Feb 2011 13:36:36 -0800 (PST)
In-Reply-To: <20110207205934.GD13461@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166300>

Heya,

On Mon, Feb 7, 2011 at 21:59, Jeff King <peff@peff.net> wrote:
> As cool and clever as the foo^0 behavior is once you understand it, I
> think it is a horribly confusing thing for non-experts. As part of this
> proposal, should we perhaps offer "git checkout --detach" as the
> easy-on-the-eyes way of intentionally detaching?

Now _that_ is an excellent usability improvement, assuming we want to
encourage detaching HEAD... do we?

-- 
Cheers,

Sverre Rabbelier
