From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Licensing and the library version of git
Date: Thu, 27 Jul 2006 12:11:00 -0400
Message-ID: <9e4733910607270911p50d25d97w1a898fc7a9119e7d@mail.gmail.com>
References: <9e4733910607261436v4c0802e5v7301e904593f9bab@mail.gmail.com>
	 <20060727114105.GZ13776@pasky.or.cz>
	 <Pine.LNX.4.63.0607271400160.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	 <9e4733910607270554p5622ee20ida8c264cf3122500@mail.gmail.com>
	 <20060727131127.GA13776@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 27 18:11:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G68S8-0007Tw-Eg
	for gcvg-git@gmane.org; Thu, 27 Jul 2006 18:11:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750823AbWG0QLF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Jul 2006 12:11:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751283AbWG0QLF
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Jul 2006 12:11:05 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:49939 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750823AbWG0QLC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Jul 2006 12:11:02 -0400
Received: by ug-out-1314.google.com with SMTP id m3so347282ugc
        for <git@vger.kernel.org>; Thu, 27 Jul 2006 09:11:01 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LOpzWk6IvC8j905/3TkE0cIn6EYAcFWQrhVVEYFSsNpFKnabhwMMH6/ommuty1DkIN6ym1G3C87hNrQats/W1425rLhCjibJ/Z2PcTuSwRyFaRQ9tDCMBiK+n0gk9o+dv3XzbgICa9pI8mSaS+1VGMJNiubmWyVhqc2kHnjsmQ0=
Received: by 10.78.116.19 with SMTP id o19mr1236863huc;
        Thu, 27 Jul 2006 09:11:00 -0700 (PDT)
Received: by 10.78.149.8 with HTTP; Thu, 27 Jul 2006 09:11:00 -0700 (PDT)
To: "Petr Baudis" <pasky@suse.cz>
In-Reply-To: <20060727131127.GA13776@pasky.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24295>

On 7/27/06, Petr Baudis <pasky@suse.cz> wrote:
> > You may like trying to force GPL onto the app but many apps are
> > stuck with the license they have and can't be changed since there is
> > no way to contact the original developers.
>
> At this point, git-shortlog lists exactly 200 people (at least entries
> like Unknown or No name are all linux@horizon.com ;-).

Inability to integrate with Microsoft Visual Studio is going to have a
lot of impact on the cross platform use of git.  Is a conscious
decision being made to stop this integration or is this just unplanned
side effect of the original license? If this is an unplanned side
effect, the quicker we move, the easier it is to fix.

Note that only the code going into the library needs to be LGPL. That
should significantly reduce the number of authors that need to be
contacted.

A first step to fixing this would be to add an immediate requirement
that all new code that is targeted to library functions be licensed
LGPL. That will at least stop the problem from getting any worse.

-- 
Jon Smirl
jonsmirl@gmail.com
