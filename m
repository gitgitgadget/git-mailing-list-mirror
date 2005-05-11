From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: GIT compile error on Sun Sparc SB2000
Date: Wed, 11 May 2005 13:34:25 +0100
Message-ID: <20050511123425.GA28547@projectcolo.org.uk>
References: <200505111141.27725.snake@penza-gsm.ru> <1115809273.16187.493.camel@hades.cambridge.redhat.com> <1115812736.16187.494.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alexey Nezhdanov <snake@penza-gsm.ru>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 11 14:28:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVqJ2-00073n-BF
	for gcvg-git@gmane.org; Wed, 11 May 2005 14:27:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261181AbVEKMek (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 May 2005 08:34:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261195AbVEKMek
	(ORCPT <rfc822;git-outgoing>); Wed, 11 May 2005 08:34:40 -0400
Received: from kerouac.projectcolo.org.uk ([80.71.3.114]:56736 "EHLO
	kerouac.projectcolo.org.uk") by vger.kernel.org with ESMTP
	id S261181AbVEKMeg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2005 08:34:36 -0400
Received: from localhost (localhost [127.0.0.1])
	by kerouac.projectcolo.org.uk (Postfix) with ESMTP id 8DFCF79DF5;
	Wed, 11 May 2005 13:34:25 +0100 (BST)
Received: from kerouac.projectcolo.org.uk ([127.0.0.1])
	by localhost (kerouac [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 28356-06; Wed, 11 May 2005 13:34:25 +0100 (BST)
Received: by kerouac.projectcolo.org.uk (Postfix, from userid 10003)
	id 664B379D9D; Wed, 11 May 2005 13:34:25 +0100 (BST)
To: David Woodhouse <dwmw2@infradead.org>
Content-Disposition: inline
In-Reply-To: <1115812736.16187.494.camel@hades.cambridge.redhat.com>
User-Agent: Mutt/1.3.28i
X-Cookie: Killing turkeys causes winter.
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at projectcolo.org.uk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, May 11, 2005 at 12:58:56PM +0100, David Woodhouse wrote:
> On Wed, 2005-05-11 at 12:01 +0100, David Woodhouse wrote:
> > Libraries which are in /usr/lib as opposed to /usr/lib64 are presumably
> > 64-bit.

> Der.... I mean 32-bit, obviously; otherwise the rest wouldn't make
> sense:

Yes, that is the case for Debian.

> >  Since the linker is claiming that they're incompatible, I assume
> > your compiler is defaulting to 64-bit output. Try adding '-m32' to
> > CFLAGS, or installing 64-bit libz.

...provided in the lib64z1-dev package.  I'm not sure if there is a 64
bit libssl package, though.

-- 
"You grabbed my hand and we fell into it, like a daydream - or a fever."
