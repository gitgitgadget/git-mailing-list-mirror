From: Andreas Krey <a.krey@gmx.de>
Subject: Re: [PATCH] git push --track
Date: Thu, 14 Jan 2010 16:27:27 +0100
Message-ID: <20100114152727.GA26059@inner.home.ulmdo.de>
References: <op.u6g8jnixg402ra@nb-04> <871vht7cs2.fsf@catnip.gol.com> <46a038f91001140544u64dd7eefn94625cdc40881cd6@mail.gmail.com> <alpine.DEB.1.00.1001141509230.3029@intel-tinevez-2-302> <vpqiqb4lq4q.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Miles Bader <miles@gnu.org>,
	Rudolf Polzer <divVerent@alientrap.org>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Jan 14 16:27:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVRc0-0002fN-CP
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 16:27:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757084Ab0ANP1s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2010 10:27:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757056Ab0ANP1s
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jan 2010 10:27:48 -0500
Received: from continuum.iocl.org ([213.146.114.200]:62784 "EHLO
	continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753509Ab0ANP1r (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2010 10:27:47 -0500
Received: (from krey@localhost)
	by continuum.iocl.org (8.11.3/8.9.3) id o0EFRRf31497;
	Thu, 14 Jan 2010 16:27:27 +0100
Content-Disposition: inline
In-Reply-To: <vpqiqb4lq4q.fsf@bauges.imag.fr>
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137002>

On Thu, 14 Jan 2010 15:25:57 +0000, Matthieu Moy wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> Of course it'd only work if you have full ssh access, unless the git 
> >> server learns a new command to mkdir (in sane and approved locations).
> >
> > You mean a new "init" command a la "git --git-dir=bla.git init", which 
> > _does_ mkdir the directory.
> 
> I think he meant
> 
>   git --git-dir=git+ssh://foo.bar/var/git/mynewthing.git init
> 
> which doesn't.

But 'ssh foo.bar git --git-dir=/var/git/mynewthing.git init' likely would.

Probably missing a --bare somewhere; and I think that repo creation
potentially needs too many things (like custom hook or access rights
setup) to be done via git push. Especially since you really only need
to create an empty repo, and only if you didn't clone from the push
target in the first place.

Andreas
