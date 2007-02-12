From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Efficiency of initial clone from server
Date: Sun, 11 Feb 2007 21:15:35 -0500
Message-ID: <9e4733910702111815g5a42989fr8042e84b291ab576@mail.gmail.com>
References: <9e4733910702111153p1691ad99nda97325b34b7a13f@mail.gmail.com>
	 <20070211225326.GC31488@spearce.org>
	 <9e4733910702111525x176053d3y9fd6d809ac447c0a@mail.gmail.com>
	 <Pine.LNX.4.64.0702112022430.1757@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Feb 12 03:15:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGQjR-0001Av-Ku
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 03:15:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932935AbXBLCPj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Feb 2007 21:15:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932936AbXBLCPj
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Feb 2007 21:15:39 -0500
Received: from wr-out-0506.google.com ([64.233.184.227]:41105 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932935AbXBLCPi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Feb 2007 21:15:38 -0500
Received: by wr-out-0506.google.com with SMTP id i21so1499002wra
        for <git@vger.kernel.org>; Sun, 11 Feb 2007 18:15:37 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=g95TGevPMx6SbLbVFeUS5QmgNUQtZJ4rh0lFfeNgzLHNJYnag/xCro432TYINDh3vsPXvaG+6T3V5IJpwiEpkD1nQrHEK15vnxJR9l8PG85nwAwdRk1k48Rz+kwBIQrnBLS0Ydlj6E4yxABdI+NMoPOFpSvRi8G9Wz7/AmIm+fQ=
Received: by 10.114.93.1 with SMTP id q1mr6597100wab.1171246535918;
        Sun, 11 Feb 2007 18:15:35 -0800 (PST)
Received: by 10.114.195.13 with HTTP; Sun, 11 Feb 2007 18:15:35 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0702112022430.1757@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39350>

On 2/11/07, Nicolas Pitre <nico@cam.org> wrote:
> On Sun, 11 Feb 2007, Jon Smirl wrote:
>
> > On 2/11/07, Shawn O. Pearce <spearce@spearce.org> wrote:
> > > Jon Smirl <jonsmirl@gmail.com> wrote:
> > > > remote: Total 63, written 63 (delta 0), reused 63 (delta 0)
> > > > 100% (63/63) done
> > > > fatal: pack: not a valid SHA1
> > > > New branch: 0953670fbcb75e26fb93340bddae934e85618f2e
> > >
> > > What version of git is this?  That looks like we're assuming the word
> > > pack was an object, but I'm not sure why we would do such a thing...
>
> This "pack" comes from pack-index when providing the name of the pack.
> It is either "pack" or "keep" and specifies the name of the .keep file
> to remove in the later case.
> This is caught by git-fetch.sh with some code identified with a comment
> that reads: "# special line coming from index-pack with the pack name"
>
> > jonsmirl@jonsmirl:/usr/local/bin$ git --version
> > git version 1.5.0.rc2.g53551-dirty
>
> You must have conflicting vintage of GIT installations on your machine
> with missing support for the "pack" and "keep" stuff described above.

I can clone Linus' git tree without getting errors.

Maybe there is something wrong with the wireless-dev tree.
It looks like someone is working on it:

jonsmirl@jonsmirl:/extra$ git clone
git://git.kernel.org/pub/scm/linux/kernel/gt/linville/wireless-dev.git
Initialized empty Git repository in /extra/wireless-dev/.git/
fatal: The remote end hung up unexpectedly
fetch-pack from
'git://git.kernel.org/pub/scm/linux/kernel/gt/linville/wireless-dev.git'
failed.
jonsmirl@jonsmirl:/extra$



-- 
Jon Smirl
jonsmirl@gmail.com
