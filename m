From: "Thomas Adam" <thomas.adam22@gmail.com>
Subject: Re: [PATCH] instaweb: support for Ruby's WEBrick server
Date: Mon, 17 Sep 2007 13:02:24 +0100
Message-ID: <18071eea0709170502s397331c5j7d77aa9531f73704@mail.gmail.com>
References: <618c07250709161935g333f0536q31b453bd58f2d75d@mail.gmail.com>
	 <20070917115518.GA26815@soma>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Mike Dalessio" <mike@csa.net>, git@vger.kernel.org
To: "Eric Wong" <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Sep 17 14:02:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXFJ8-000441-Fe
	for gcvg-git-2@gmane.org; Mon, 17 Sep 2007 14:02:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752357AbXIQMC0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2007 08:02:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751726AbXIQMC0
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 08:02:26 -0400
Received: from nz-out-0506.google.com ([64.233.162.232]:10241 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751873AbXIQMCZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 08:02:25 -0400
Received: by nz-out-0506.google.com with SMTP id s18so849048nze
        for <git@vger.kernel.org>; Mon, 17 Sep 2007 05:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=u9o7v6y8kSR3ITD2FMIfVu6ozsEo5Q+1aBDhwRsIsF4=;
        b=StoM6aaeY4/Z84pWM/u6QCQgKf90kCUh9afNgZwZWNo0ebBKvF9xF2+H+FBWY90zQD9bcQOHopfRic6VxZ/gkHrwB8s5S+rWsfsTfQ5Tm3EuKJ9JJU7+0YaKTCRyktV/HJQO9owIPCFWlOVJiqBMVNlMaKUEAK3NQWggg5+XZPQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sDDYRodSK+PuFsTnzhEgc3JWptnC+D2H8/cGMdWodjB98vIKEW4WL0hyR8XSiAY4w+PZFXc+7ty8XmKbzIvYyhWu3hLRvaScm9D+hjFKfriVyUD1DNmXsApT/cFceAmLATbQaSyltzM80/95AI/ohjUbsuW9ga0rxGoP/H3CAxU=
Received: by 10.143.9.5 with SMTP id m5mr777058wfi.1190030544690;
        Mon, 17 Sep 2007 05:02:24 -0700 (PDT)
Received: by 10.142.82.18 with HTTP; Mon, 17 Sep 2007 05:02:24 -0700 (PDT)
In-Reply-To: <20070917115518.GA26815@soma>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58428>

On 17/09/2007, Eric Wong <normalperson@yhbt.net> wrote:
> Could we make the shebang dynamic? (capturing the output of `which ruby`
> maybe, or just breaking down and using /usr/bin/env ruby).  The ruby
> binary seems to appear all over the place on the filesystem from my
> experience, especially with its popularity amongst OSX users.

This is what /usr/bin/env is useful for, but it's not that portable.

-- Thomas Adam
