From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Git tree for old kernels from before the current tree
Date: Sun, 22 Jul 2007 20:17:56 -0400
Message-ID: <9e4733910707221717u2ce828ccsc7cc5812d129dfc9@mail.gmail.com>
References: <9e4733910707221349s462aa11bj714956f7cdc72aac@mail.gmail.com>
	 <Pine.LNX.4.64.0707222257540.32367@fbirervta.pbzchgretzou.qr>
	 <20070722211314.GA13850@linux-sh.org>
	 <Pine.LNX.4.64.0707222344540.32367@fbirervta.pbzchgretzou.qr>
	 <Pine.LNX.4.64.0707230000170.32367@fbirervta.pbzchgretzou.qr>
	 <46A3D5EA.2050600@zytor.com> <46A3E7BA.6030609@partiallystapled.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	"Git Mailing List" <git@vger.kernel.org>,
	lkml <linux-kernel@vger.kernel.org>
To: "Michael Tharp" <gxti@partiallystapled.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 02:18:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IClci-0006nS-Bs
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 02:18:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762866AbXGWASA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 20:18:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762882AbXGWASA
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 20:18:00 -0400
Received: from wa-out-1112.google.com ([209.85.146.183]:11006 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757672AbXGWAR5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2007 20:17:57 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1797167wah
        for <git@vger.kernel.org>; Sun, 22 Jul 2007 17:17:56 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bpLoHYkEr/jKNIeqbbm1QQ+e2vyrdgNt0eityp7zqMd+g2rQAr462x3XKbaF+1UT42Dawuos+3F3lglXR8WiGbtWltlvxSRaOGLPmX5zNvY/D1GzmIPgNQeTwNwOkf7+5x47GwVwpYAPaoxsifr2WitElUjXQZAxeVrnqeeJn+Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=REi1uq/atOvBqH1EzEbIDkkm1khQ9rkVxg+kNaXP0sKVn4IBM8eEgvxWxjSnOUElzqjdIeTnl0jzRe8dr2E0MzP9BOnAu5TWfHivxYSDE7ZlA6rUWWyKl8KDszbDg06jQD3TlEQk3/Ft2gwmWMSqjEy+dClqtwGXVsf+6fT1RJI=
Received: by 10.114.77.1 with SMTP id z1mr2468377waa.1185149876656;
        Sun, 22 Jul 2007 17:17:56 -0700 (PDT)
Received: by 10.114.195.5 with HTTP; Sun, 22 Jul 2007 17:17:56 -0700 (PDT)
In-Reply-To: <46A3E7BA.6030609@partiallystapled.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53375>

On 7/22/07, Michael Tharp <gxti@partiallystapled.com> wrote:
> H. Peter Anvin wrote:
> > Wouldn't be hard to make a git tree with all the patches all the way
> > back to 0.01 even...
>
> It'd be delightful from a completeness standpoint (and I do love
> completeness), but considering it already takes a good 20 minutes to
> clone the 2.6 tree over a respectable cable connection, I'd have to
> object on the grounds of size. Now, if it was kept off in its own tree
> for people who don't mind ravaging kernel.org resources to satisfy their
> own curiosity, that's fine too.

git has an extremely effective diffing mechanism. You may surprised at
how little it adds.
For example, git compressed the 2.6GB mozilla cvs tree down to 400MB.

I used to clone trees all the time, but now I'm much better at using
git and I haven't cloned a complete tree from kernel.org in a year.
git remote is a cool feature.

-- 
Jon Smirl
jonsmirl@gmail.com
