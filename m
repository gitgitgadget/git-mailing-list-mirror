From: "Jonas Fonseca" <jonas.fonseca@gmail.com>
Subject: Re: git-gui console app ?
Date: Sat, 11 Aug 2007 12:22:29 +0200
Message-ID: <2c6b72b30708110322i53bb713fka6fe259b43a95b45@mail.gmail.com>
References: <20070804101058.GA520@Mac2.local>
	 <Pine.LNX.4.64.0708041225520.14781@racer.site>
	 <20070804115331.GA2962@Mac2.local>
	 <20070804120342.GC9716@coredump.intra.peff.net>
	 <20070804123834.GA3036@Mac2.local>
	 <20070805101953.GI12507@coredump.intra.peff.net>
	 <20070810133132.GA3770@diku.dk> <20070810142540.GE363@Mac2.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Erik Colson" <eco@ecocode.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 11 12:22:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJo7E-0001xK-HA
	for gcvg-git@gmane.org; Sat, 11 Aug 2007 12:22:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753362AbXHKKWc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Aug 2007 06:22:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752787AbXHKKWb
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Aug 2007 06:22:31 -0400
Received: from wa-out-1112.google.com ([209.85.146.182]:51966 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752120AbXHKKWb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Aug 2007 06:22:31 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1176631wah
        for <git@vger.kernel.org>; Sat, 11 Aug 2007 03:22:29 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IIlz70STZEEGvt9dph8JFaK+uhfGTq/AtJIZ7uSwnoBzS6wvDrte8B/VRjX5Atcztl6yy523rNV3pjY6kI3iRs5J7IawefMn65ocrGVKOyE1QNRoRBGneMuidKUUtbR8HkjZnbmcWAGXt96nLAiljkm3sMoCpVTojm0gqNDB5JI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HPLsMJKAnzAh2/r5eyceaxZ9kWP9CeIJBDzeI7SQ1tlvWqKmAIsTSGQ4wftS0S/tlZlVSFrrAy+tIMuncAoYlHo32V2Whk3GefNdP5AkFvuZ5sDOCgON7kq07ufQdUs3/X9sZ+MTBibHCNsr+5VMEMQJoUdeWxDVko5RUK+Op5M=
Received: by 10.114.95.1 with SMTP id s1mr3428716wab.1186827749091;
        Sat, 11 Aug 2007 03:22:29 -0700 (PDT)
Received: by 10.114.127.17 with HTTP; Sat, 11 Aug 2007 03:22:29 -0700 (PDT)
In-Reply-To: <20070810142540.GE363@Mac2.local>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55601>

On 8/10/07, Erik Colson <eco@ecocode.net> wrote:
> On Fri, Aug 10, 2007 at 03:31:32PM +0200, Jonas Fonseca wrote:
> > Not quite a one-liner, but I've implemented something that will show
> > diffs of staged/unstaged changes as well as the content of untracked
> > files when pressing Enter on a file in the status view. To update the
> > status of a file (unstaged->staged, untracked->staged, etc) you now
> > have to press 'u'.
> >
> > Hope this helps.
>
> Works like a charm ! Thanks for the implementation.

Good to hear.

Now, I have to figure out how to clone git-gui's ability to stage
individual diff (c)hunks ... :)

> Btw, I'm using
> git (and tig) on MacosX and got it compiled by using the same remarks
> you mention for FreeBSD, so may be you could add this to the INSTALL
> document...

Yes, it might be a good idea to add it, but I would like to add
a configure script to figure this sort of thing out automatically.

-- 
Jonas Fonseca
