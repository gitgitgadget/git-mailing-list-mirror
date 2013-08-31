From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] remote-hg: skip ill-formed references
Date: Sat, 31 Aug 2013 12:57:34 -0500
Message-ID: <CAMP44s2VOq_KEDkytF8Knbm4g12tf=K5ZVden8t=udi=KP+yPQ@mail.gmail.com>
References: <20130831011542.GA10486@wheezy.local>
	<CAMP44s2f7S4STbCOuh35sgdrgAdw-2Tw1LDkjhO37hXLxX3mRQ@mail.gmail.com>
	<loom.20130831T155657-714@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Max Kirillov <max@max630.net>
X-From: git-owner@vger.kernel.org Sat Aug 31 19:57:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFpQa-00066O-6j
	for gcvg-git-2@plane.gmane.org; Sat, 31 Aug 2013 19:57:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754327Ab3HaR5g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Aug 2013 13:57:36 -0400
Received: from mail-la0-f45.google.com ([209.85.215.45]:56200 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753501Ab3HaR5f (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Aug 2013 13:57:35 -0400
Received: by mail-la0-f45.google.com with SMTP id eh20so2444178lab.18
        for <git@vger.kernel.org>; Sat, 31 Aug 2013 10:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=qobR4bmFGLxNOG7IvjwKDSG1rXTLho4eDTIyOr0tITs=;
        b=YdaaIH+vVklkfporTsMIkWTgAJ7RBLCwlZlffQb8XuDDE+wg5lZYoSMc+fwT5Q3vqU
         0xMhRyL2Z+yxJcY2l7un6wnERP7+29LQDTQqc6ieaLUZvWuvFr5b/n3GGdonuynDvlg0
         I0BYQi/4q0QXb4Mbvl1hoM2X97y8TOr6eRoNNWrpMVy9mOHBBXQyox2Df6BwsFwTXcPs
         jwFchxNbQz76hQ7DpSa+Gt9j6YZng6wLWonDDKQ+jjJ/WiO8E6V9546vZCKo5qRKYY0g
         NpkXQMBCBNR4mPU/CY6KLlr7Ypwj9S5OeN3guG4Zdg7r5TAxZvTJklwl5kn8PciiyUO0
         9Awg==
X-Received: by 10.152.115.176 with SMTP id jp16mr13247549lab.17.1377971854446;
 Sat, 31 Aug 2013 10:57:34 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Sat, 31 Aug 2013 10:57:34 -0700 (PDT)
In-Reply-To: <loom.20130831T155657-714@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233527>

On Sat, Aug 31, 2013 at 8:58 AM, Max Kirillov <max@max630.net> wrote:
> Felipe Contreras <felipe.contreras <at>
> gmail.com> writes:
>> Which repository triggered this?
>
> Tha was some of the vim repositories, upstream
> https://code.google.com/p/vim/ or debian
> anonscm.debian.org/hg/pkg-vim/vim, or both.
> They contain tags with ~ symbol.

I can clone both fine. This is what I get with the debian one:

error: * Ignoring funny ref 'refs/tags/debian-7.2.436+hg~e12b9d992389-1' locally
error: * Ignoring funny ref
'refs/tags/debian-7.2.436+hg~e12b9d992389-1+' locally
error: * Ignoring funny ref 'refs/tags/debian-7.2.438+hg~d44112feb815-1' locally
error: * Ignoring funny ref 'refs/tags/debian-7.2.438+hg~d44112feb815-2' locally
error: * Ignoring funny ref 'refs/tags/debian-7.2.438+hg~d44112feb815-3' locally
error: * Ignoring funny ref 'refs/tags/debian-7.2.438+hg~d44112feb815-4' locally
error: * Ignoring funny ref 'refs/tags/debian-7.2.438+hg~d44112feb815-5' locally
error: * Ignoring funny ref 'refs/tags/debian-7.2.445+hg~cb94c42c0e1a-1' locally
error: * Ignoring funny ref
'refs/tags/debian-7.3b.20100720+hg~7b7508ee56f1-1' locally
error: * Ignoring funny ref
'refs/tags/debian-7.3f.20100812+hg~20e83abf88b1-1' locally
error: * Ignoring funny ref 'refs/tags/debian-7.3.000+hg~ee53a39d5896-1' locally
error: * Ignoring funny ref 'refs/tags/debian-7.3.035+hg~8fdc12103333-1' locally
error: * Ignoring funny ref 'refs/tags/debian-7.3.154+hg~74503f6ee649-1' locally
error: * Ignoring funny ref 'refs/tags/debian-7.3.154+hg~74503f6ee649-2' locally
error: * Ignoring funny ref 'refs/tags/debian-7.3.547-6~bpo60+1' locally
error: * Ignoring funny ref 'refs/tags/debian-7.3.547-7~bpo60+1' locally

Maybe you need a newer version of Git. I'm using v1.8.4.

-- 
Felipe Contreras
