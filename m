From: Pavel Roskin <proski@gnu.org>
Subject: Re: Problem upgrading to 1.4.0
Date: Mon, 12 Jun 2006 23:56:25 -0400
Message-ID: <1150170985.4297.104.camel@dv>
References: <93c3eada0606101707t5eb35a4du3ebd0fd17737943f@mail.gmail.com>
	 <7v1wtwh246.fsf@assigned-by-dhcp.cox.net> <1150165982.4297.88.camel@dv>
	 <20060612224818.383b13ee.seanlkml@sympatico.ca>
	 <1150167759.4297.95.camel@dv>
	 <Pine.LNX.4.64.0606122024400.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Sean <seanlkml@sympatico.ca>, git@vger.kernel.org,
	geoffrey.russell@gmail.com
X-From: git-owner@vger.kernel.org Tue Jun 13 05:56:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fq017-0008Bq-6w
	for gcvg-git@gmane.org; Tue, 13 Jun 2006 05:56:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932850AbWFMD4e (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Jun 2006 23:56:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932853AbWFMD4e
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jun 2006 23:56:34 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:64908 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S932850AbWFMD4d
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jun 2006 23:56:33 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1Fq013-0002TP-3r
	for git@vger.kernel.org; Mon, 12 Jun 2006 23:56:33 -0400
Received: from proski by dv.roinet.com with local (Exim 4.62)
	(envelope-from <proski@dv.roinet.com>)
	id 1Fq00v-00043E-DM; Mon, 12 Jun 2006 23:56:25 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606122024400.5498@g5.osdl.org>
X-Mailer: Evolution 2.7.2.1 (2.7.2.1-4) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21761>

On Mon, 2006-06-12 at 20:28 -0700, Linus Torvalds wrote:
> 
> On Mon, 12 Jun 2006, Pavel Roskin wrote:
> >
> > > You can get a list of the remote branches whenever you want:
> > > 
> > > $ git ls-remote -h <remote>
> > 
> > I heard of that command.  But git-clone only uses it for local and rsync
> > protocols.
> 
> The native format doesn't _need_ to use "git ls-remote", because the 
> native format does it on its own.

OK.  I actually suspected that git-ls-remote was limited to some
protocols.  I'm glad to be wrong about it.

-- 
Regards,
Pavel Roskin
