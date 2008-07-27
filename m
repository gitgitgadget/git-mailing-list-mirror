From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Cleaning up log messages
Date: Sun, 27 Jul 2008 15:31:26 -0400
Message-ID: <9e4733910807271231s7ff6acf8rf5848cc1a31f3afc@mail.gmail.com>
References: <9e4733910807271050y7fb5f77coec05bd68421baaab@mail.gmail.com>
	 <alpine.DEB.1.00.0807272000270.5526@eeepc-johanness>
	 <9e4733910807271116q29323664l8d44fdded1de8c8e@mail.gmail.com>
	 <20080727183309.GD32184@machine.or.cz>
	 <9e4733910807271207o2e18cef1h869c659bd0ae31ba@mail.gmail.com>
	 <alpine.DEB.1.00.0807272116030.5526@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Petr Baudis" <pasky@suse.cz>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jul 27 21:32:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNByp-00074f-7T
	for gcvg-git-2@gmane.org; Sun, 27 Jul 2008 21:32:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758239AbYG0Tbb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jul 2008 15:31:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758170AbYG0Tba
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jul 2008 15:31:30 -0400
Received: from wr-out-0506.google.com ([64.233.184.233]:27339 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757580AbYG0Tba (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jul 2008 15:31:30 -0400
Received: by wr-out-0506.google.com with SMTP id 69so3405638wri.5
        for <git@vger.kernel.org>; Sun, 27 Jul 2008 12:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=Jif4O0GGyNAK163VzaHwlzzJNA/KQ3m5repYq7g/4n4=;
        b=mWwgMg4zz+i7EX8Y4K7af/7tPhS5hkgUdcdkxg2abTqJVNF7HHecVITwryYePCQHmY
         Kgp0jqG84/uXRK6ugP3QvcNFcwMsoA4pQNqc1ltmXLf+rWB7u6Yvi/8rCr2f9fDD0now
         aGWy8EB0wH+wRReEORNiStuP8hIkVe8u8/j8s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=ga4qUCLDcDkK6mGjz4cBpoT/1uAlN3zlygvWXMQJFc651uTf6lDLKBVeiv/sr8RE3S
         /QGKKoFNAsd2y4L7xvwePYfaN2o7ELfSy5UsLc6lm+iiRUY6RdVDnPiz1fmrfwNfGtBf
         AFlBTbRFfpb4I2aiDmgePiIwreAqo7CnBzYwU=
Received: by 10.90.29.13 with SMTP id c13mr6224293agc.92.1217187086338;
        Sun, 27 Jul 2008 12:31:26 -0700 (PDT)
Received: by 10.150.205.1 with HTTP; Sun, 27 Jul 2008 12:31:26 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0807272116030.5526@eeepc-johanness>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90360>

On 7/27/08, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
>
>  On Sun, 27 Jul 2008, Jon Smirl wrote:
>
>  > On 7/27/08, Petr Baudis <pasky@suse.cz> wrote:
>  > > On Sun, Jul 27, 2008 at 02:16:30PM -0400, Jon Smirl wrote:
>  > >  > On 7/27/08, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>  > >
>  > > > > Something like .mailmap?
>  > >  > >
>  > >  > >  And to show the mapped author name instead of the committed one, you would
>  > >  > >  use "--pretty=format:%aN"?  (Needs 1.6.0-rc0 at least, IIRC)
>  > >  >
>  > >  > So we can already do this? Where is a .mailmap for the kernel tree?
>  > >
>  > >         http://repo.or.cz/w/linux-2.6.git?a=blob;f=.mailmap
>  > >
>  > >  ...right there. :-)
>  >
>  > I updated to 1.6.0-rc0 and this is working. mailmap needs some
>  > cleanup. Errors are still in the list, but this is a lot better than
>  > it was. That made about 800 'contributors' disappear.
>  >
>  > Is there a way to do short log and have it map the names?
>
>
> Yes, as of v1.6.0-rc0~58 you can pass --pretty=format: to shortlog.

How do you do it with git log? --pretty overrides the default of medium

--pretty[=<format>]

    Pretty-print the contents of the commit logs in a given format,
where <format> can be one of oneline, short, medium, full, fuller,
email, raw and format:<string>. When omitted, the format defaults to
medium.


>
>
>  > What about replacing the emails with their current email address?
>
>
> Nope, that was never meant to be done.
>
>  Ciao,
>  Dscho
>
>


-- 
Jon Smirl
jonsmirl@gmail.com
