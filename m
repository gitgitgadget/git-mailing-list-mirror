From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: native-git-svn: A Summer of Code 2010 proposal
Date: Sat, 20 Mar 2010 16:04:07 -0500
Message-ID: <20100320210406.GA29899@progeny.tock>
References: <f3271551003191018j67aa133es2fee4e3dda519ce0@mail.gmail.com>
 <32541b131003191132y119037f8rae598d0037786703@mail.gmail.com>
 <fabb9a1e1003191139v6ea37df3uba441f2cba9bc992@mail.gmail.com>
 <32541b131003191430ld0eaa9cw1d2aac08cff15682@mail.gmail.com>
 <alpine.DEB.1.00.1003201148230.7596@pacific.mpi-cbg.de>
 <f3271551003201334o4919cd47s44d06288b0d6068b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Avery Pennarun <apenwarr@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 20 22:03:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nt5pE-0004Kv-Ve
	for gcvg-git-2@lo.gmane.org; Sat, 20 Mar 2010 22:03:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751819Ab0CTVDM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Mar 2010 17:03:12 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:49845 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751273Ab0CTVDL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Mar 2010 17:03:11 -0400
Received: by gwaa18 with SMTP id a18so349010gwa.19
        for <git@vger.kernel.org>; Sat, 20 Mar 2010 14:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=4IORmMddq63wOvbQrVpay575+GxwB4jQhW0haNiQ2iA=;
        b=DmJJDKdjFGApVTp2ueiyhWdkM507xKvGdTVbDL2EkxjJCo3W1g00mKLh+kA74DM4h5
         GWMyu69BBQ40dlaiLn8U9K/e0l/TuVJhEErZxWza3AA4eSkKcr6ZktVL0hmqyVBg0gpj
         1MZVldOg/ya/+w0MVtVe/Qz083B3EaTF945qM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=SmD0hsUuWTExJo2/qhrSHua8FZ33Xg/Csi2D42sKpq3iZ9OfvRmVsNHOxNJctW8I+w
         sbCXQS31awy69Bed0FIqUgQe8yx4Iuqd2Tu/T//oO8Qwd/P23Qr0y4wR/RwEXtZe9LhE
         FWuOE0iD4D8r9RW2rcKQRIkfVlJp7X9hp2dRk=
Received: by 10.100.50.12 with SMTP id x12mr11532183anx.217.1269118990640;
        Sat, 20 Mar 2010 14:03:10 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 22sm1124874iwn.8.2010.03.20.14.03.09
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 20 Mar 2010 14:03:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <f3271551003201334o4919cd47s44d06288b0d6068b@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142754>

Hi,

Ramkumar Ramachandra wrote:

> I just prepared another revision of my proposal- I've tried to be
> clearer about the objective, and included a timeline this time.

Very nice.  Thanks!

> == Timeline ==

The one thing I worry about is that you are proposing to wait a while
before submitting your changes upstream.  I would suggest pushing
whatever pieces work to contrib/ early on to get more feedback from
reviewers and testers.  (I am saying this selfishly, as a potential
tester.)

> July 10 - July 16: Scrub code and write documentation for mid-term
> evaluations. Commit changes to the remote helper to upstream. Try to
> get the other changes into `next`.

In particular, this seems like very little time to get the code into
shape for git.git.

Hope that helps.

Cheers,
Jonathan
