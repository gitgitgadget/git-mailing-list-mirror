From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Licensing and the library version of git
Date: Thu, 27 Jul 2006 08:54:54 -0400
Message-ID: <9e4733910607270554p5622ee20ida8c264cf3122500@mail.gmail.com>
References: <9e4733910607261436v4c0802e5v7301e904593f9bab@mail.gmail.com>
	 <20060727114105.GZ13776@pasky.or.cz>
	 <Pine.LNX.4.63.0607271400160.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Petr Baudis" <pasky@suse.cz>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 27 14:56:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G65Oz-000736-AA
	for gcvg-git@gmane.org; Thu, 27 Jul 2006 14:55:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751181AbWG0MzI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Jul 2006 08:55:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751192AbWG0MzE
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Jul 2006 08:55:04 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:48830 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751181AbWG0MzB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Jul 2006 08:55:01 -0400
Received: by ug-out-1314.google.com with SMTP id m3so241242ugc
        for <git@vger.kernel.org>; Thu, 27 Jul 2006 05:55:00 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GZkCaVnyErbikUps1+8OYQ13jz8n5IstIuI3FdWoyIANopX0rt7HoyeFLOwwerC3MhEsYUt1dwXDe8QKh64f+nLBwgPRaUAeQliE0BNNbWBLfj2Q21repplCUlH6PwIYvUalYwwwImq/sVBSHQwegBr4iDYHpJtWSflZNMJg+dU=
Received: by 10.78.170.17 with SMTP id s17mr3861754hue;
        Thu, 27 Jul 2006 05:54:59 -0700 (PDT)
Received: by 10.78.149.8 with HTTP; Thu, 27 Jul 2006 05:54:54 -0700 (PDT)
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0607271400160.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24284>

On 7/27/06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Thu, 27 Jul 2006, Petr Baudis wrote:
>
> > And I didn't even get to discussing whether LGPL is actually desirable
> > for Git.
>
> ... or whether it is neccessary for an Eclipse-plugin to something else
> than GPL.

Eclipse is not licensed GPL. To use the git library with Eclipse it
would need a JNI wrapper which would link it into the code. The work
around would be to make the user compile and link the JNI wrapper. But
I see that someone is already writing a pure Java version which will
work around the GPL problem assuming the Java version is released
under a compatible license.

In general libraries should be licensed LGPL to avoid the license
incompatibility problem. A GPL library forces the main app to be GPL
too. You may like trying to force GPL onto the app but many apps are
stuck with the license they have and can't be changed since there is
no way to contact the original developers. A GPL git library means
that these apps simply won't use git.

This also means that there will never be integrated git support in
Microsoft Visual Studio. This has impacts on switching cross platform
apps like Mozilla to git.

-- 
Jon Smirl
jonsmirl@gmail.com
