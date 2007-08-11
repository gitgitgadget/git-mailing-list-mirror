From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: performance on repack
Date: Sat, 11 Aug 2007 19:21:05 -0400
Message-ID: <9e4733910708111621j6a9ba950i114be8b84d7fb1bb@mail.gmail.com>
References: <9e4733910708111412t48c1beaahfbaa2c68a02f64f1@mail.gmail.com>
	 <85ps1tsozb.fsf@lola.goethe.zz>
	 <alpine.LFD.0.999.0708111529310.30176@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "David Kastrup" <dak@gnu.org>, git@vger.kernel.org
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Aug 12 01:21:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IK0Gp-0003iz-8h
	for gcvg-git@gmane.org; Sun, 12 Aug 2007 01:21:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752246AbXHKXVK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Aug 2007 19:21:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751549AbXHKXVJ
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Aug 2007 19:21:09 -0400
Received: from wa-out-1112.google.com ([209.85.146.176]:21787 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751665AbXHKXVG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Aug 2007 19:21:06 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1351688wah
        for <git@vger.kernel.org>; Sat, 11 Aug 2007 16:21:05 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Op+D3Q4eZpYyxho+d0TTqkg67h7+ybsAfRjpZdk8KKtJXiAobWVCtCSU7xmdfQNtU1O3CdPtr1QlZnI6nIRvPqFHjkPaQArTxD/b/Nsj0GwJ0brkhB1NYOUweoU+FI0ogDvr+09OsxiFwOc2YqzTT1VrO9T72tA1BsnTlsF5/kc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YdSiJC6q/QtTvHqQeDxH5S1R3HY3RfMEAK50oXSb+8hm+JZ6UyDIqrOvK6TuJrm8kFm702VibyP1VK+TBoFHe+PF5cRkFkCgIQt4bq/IWjYnXQTjhhcK2fCIymQqJc/g5jGpPqvPcIHrJ4hvV/AsnLQEE2gWmfR27ta51OsHiig=
Received: by 10.114.149.2 with SMTP id w2mr904894wad.1186874465647;
        Sat, 11 Aug 2007 16:21:05 -0700 (PDT)
Received: by 10.114.195.11 with HTTP; Sat, 11 Aug 2007 16:21:05 -0700 (PDT)
In-Reply-To: <alpine.LFD.0.999.0708111529310.30176@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55647>

On 8/11/07, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> On Sun, 12 Aug 2007, David Kastrup wrote:
> > "Jon Smirl" <jonsmirl@gmail.com> writes:
> >
> > > If anyone is bored and looking for something to do, making the delta
> > > code in git repack multithreaded would help.

To put this perspective, monotone takes 40hrs on the same box to
repack a repository of similar size.

-- 
Jon Smirl
jonsmirl@gmail.com
