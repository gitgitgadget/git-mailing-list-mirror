From: Greg KH <greg@kroah.com>
Subject: Re: [ANNOUNCE] pg - A patch porcelain for GIT
Date: Fri, 10 Feb 2006 15:20:39 -0800
Message-ID: <20060210232039.GC21468@kroah.com>
References: <20060210195914.GA1350@spearce.org> <20060210204143.GA18784@kroah.com> <20060210210401.GA1604@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Feb 11 00:20:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F7hZH-0004De-BF
	for gcvg-git@gmane.org; Sat, 11 Feb 2006 00:20:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750785AbWBJXUn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Feb 2006 18:20:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750791AbWBJXUn
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Feb 2006 18:20:43 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:29110
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1750785AbWBJXUn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Feb 2006 18:20:43 -0500
Received: from press.kroah.org ([192.168.0.25] helo=localhost)
	by aria.kroah.org with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.54)
	id 1F7hZC-0005mQ-2r
	for git@vger.kernel.org; Fri, 10 Feb 2006 15:20:42 -0800
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060210210401.GA1604@spearce.org>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15896>

On Fri, Feb 10, 2006 at 04:04:01PM -0500, Shawn Pearce wrote:
> Greg KH <greg@kroah.com> wrote:
> > On Fri, Feb 10, 2006 at 02:59:14PM -0500, Shawn Pearce wrote:
> > > I just posted the first public version of pg, a GIT porcelain for
> > > managing patches.  Think StGIT, but better in some ways:
> > > 
> > > Feature Summary:
> > 
> > Hm, is there any way to import an existing patch into pg?
> 
> Doh!  I haven't needed to do that yet.  I'll code up a pg-import
> later tonight.  But since git and pg play nice together you can
> do this:
> 
> 	pg-new Patch-Name
> 	git-apply the-patch-file.patch
> 	pg-ci -m"Importing the-patch-file.patch..."
> 
> or even:
> 
> 	pg-new Patch-Name
> 	git-am mbox

well, as my quilt tree is around 200 patches right now, that would be
annoying to have to do by hand :)

thanks,

greg k-h
