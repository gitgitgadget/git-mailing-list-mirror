From: Mike Hommey <mh@glandium.org>
Subject: Re: What I miss from Cogito...
Date: Sun, 23 Mar 2008 20:07:40 +0100
Organization: glandium.org
Message-ID: <20080323190740.GA17958@glandium.org>
References: <47E69044.3000207@zytor.com> <20080323173841.GA24943@mit.edu> <20080323182102.GA22551@bit.office.eurotux.com> <20080323190017.GB16893@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Theodore Tso <tytso@MIT.EDU>, "H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>
To: Luciano Rocha <luciano@eurotux.com>
X-From: git-owner@vger.kernel.org Sun Mar 23 20:09:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdVYw-0004N8-3v
	for gcvg-git-2@gmane.org; Sun, 23 Mar 2008 20:08:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756083AbYCWTIQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Mar 2008 15:08:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755997AbYCWTIP
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Mar 2008 15:08:15 -0400
Received: from vuizook.err.no ([194.24.252.247]:38646 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755254AbYCWTIP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Mar 2008 15:08:15 -0400
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1JdVXk-0002Q1-Lv; Sun, 23 Mar 2008 20:07:51 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1JdVXg-0004gU-JS; Sun, 23 Mar 2008 20:07:40 +0100
Content-Disposition: inline
In-Reply-To: <20080323190017.GB16893@glandium.org>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77946>

On Sun, Mar 23, 2008 at 08:00:17PM +0100, Mike Hommey wrote:
> On Sun, Mar 23, 2008 at 06:21:02PM +0000, Luciano Rocha wrote:
> > On Sun, Mar 23, 2008 at 01:38:41PM -0400, Theodore Tso wrote:
> > > On Sun, Mar 23, 2008 at 10:15:48AM -0700, H. Peter Anvin wrote:
> > > > 2. cg-restore
> > > >
> > > >    Cogito separated "reset" and "restore".  This is a syntactic sugar
> > > >    issue, but having to type "git reset --hard -- path" makes me
> > > >    nervous, especially since hitting Enter at the wrong time could have
> > > >    serious and irrevocable consequences.
> > > >
> > > >    I also note that this particular use of "git reset" is actually
> > > >    undocumented, but it seems to work.
> > > 
> > > I didn't think "git reset --hard -- <pathame>" was valid, since it's
> > > not documented in the man page.
> > > 
> > > I have the following in my path as "git-revert-file" (which is easier
> > > to type and less dangerous than typing "git reset --hard -- <path>"):
> > > 
> > > #!/bin/sh
> > > #
> > > prefix=$(git rev-parse --show-prefix)
> > > 
> > > for i in $*
> > > do
> > >         git show HEAD:$prefix$i > $i
> > > done
> > 
> > I use git checkout path ...
> > 
> > Isn't that the same thing?
> 
> Yes, it does the same. Note there is unfortunately no shorthand for
> git show $arbitrary_commit:$path > $path

Actually, git checkout $arbitrary_commit -- $path works (and puts the
contents in the index). Somehow, I thought it didn't work...

Mike
