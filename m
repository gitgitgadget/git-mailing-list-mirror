From: Mike Hommey <mh@glandium.org>
Subject: Re: git fetch workflow improvements
Date: Sat, 9 Feb 2008 15:06:01 +0100
Organization: glandium.org
Message-ID: <20080209140601.GA16239@glandium.org>
References: <3f4fd2640802090257m9ab8e24l2a836abfd2ef6bf@mail.gmail.com> <alpine.LSU.1.00.0802091318080.11591@racer.site> <20080209132745.GA13997@glandium.org> <alpine.LSU.1.00.0802091357480.11591@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Reece Dunn <msclrhd@googlemail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Feb 09 15:05:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNqL5-0007DY-Cv
	for gcvg-git-2@gmane.org; Sat, 09 Feb 2008 15:05:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752375AbYBIOFV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2008 09:05:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752187AbYBIOFU
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Feb 2008 09:05:20 -0500
Received: from vuizook.err.no ([85.19.215.103]:34458 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752047AbYBIOFT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2008 09:05:19 -0500
Received: from aputeaux-153-1-42-109.w82-124.abo.wanadoo.fr ([82.124.6.109] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1JNqLN-0007Kf-Ah; Sat, 09 Feb 2008 15:06:19 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1JNqLB-0004GI-Qy; Sat, 09 Feb 2008 15:06:01 +0100
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0802091357480.11591@racer.site>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Spam-Status: (score 2.2): No, score=2.2 required=5.0 tests=RCVD_IN_PBL,RCVD_IN_SORBS_DUL,RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73230>

On Sat, Feb 09, 2008 at 02:00:12PM +0000, Johannes Schindelin wrote:
> Hi,
> 
> On Sat, 9 Feb 2008, Mike Hommey wrote:
> 
> > On Sat, Feb 09, 2008 at 01:20:29PM +0000, Johannes Schindelin wrote:
> > 
> > > $ git remote update
> > 
> > BTW, is the following normal?
> > 
> > $ git remote update origin
> > Remote group origin does not exists.
> > 
> > (there *is* an origin remote)
> 
> Straight from the man page:
> 
> -- snip --
> 'update'::
> 
> Fetch updates for a named set of remotes in the repository as defined by
> remotes.<group>.  If a named group is not specified on the command line,
> the configuration parameter remotes.default will get used; if
> remotes.default is not defined, all remotes which do not have the
> configuration parameter remote.<name>.skipDefaultUpdate set to true will
> be updated.  (See linkgit:git-config[1]).
> -- snap --

I did read the manpage and I don't know why, but my eyes didn't want to
see the s in remote*s*. /me hides under a rock.

Mike
