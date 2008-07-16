From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Rename ".dotest/" to ".git/rebase" and ".dotest-merge"
	to "rebase-merge"
Date: Wed, 16 Jul 2008 23:27:07 +0200
Message-ID: <20080716212707.GQ32184@machine.or.cz>
References: <73fd69b50807151408i6a916da6p7b89fe81e65fc717@mail.gmail.com> <20080715212211.GL6244@leksak.fem-net> <487D1B3D.70500@lsrfire.ath.cx> <alpine.DEB.1.00.0807160245440.2841@eeepc-johanness> <7v4p6qzla3.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0807160315020.2841@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	=?iso-8859-2?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Stephan Beyer <s-beyer@gmx.net>,
	Joe Fiorini <joe@faithfulgeek.org>, git@vger.kernel.org,
	Jari Aalto <jari.aalto@cante.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 16 23:28:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJEXj-0002sH-GR
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 23:28:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753759AbYGPV1M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 17:27:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753849AbYGPV1L
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 17:27:11 -0400
Received: from w241.dkm.cz ([62.24.88.241]:38675 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752919AbYGPV1K (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 17:27:10 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id C12FC2C4C020; Wed, 16 Jul 2008 23:27:07 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0807160315020.2841@eeepc-johanness>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88761>

  Hi,

On Wed, Jul 16, 2008 at 03:15:42AM +0200, Johannes Schindelin wrote:
> On Tue, 15 Jul 2008, Junio C Hamano wrote:
> 
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > 
> > > Since the files generated and used during a rebase are never to be 
> > > tracked, they should live in $GIT_DIR.  While at it, avoid the rather 
> > > meaningless term "dotest" to "rebase", and unhide ".dotest-merge".
> > 
> > I understand moving away from .dotest/ to .git/something, but I do not 
> > follow the logic of making that something to rebase at all.  It is a 
> > scratch area for "am" (and applymbox), isn't it?
> 
> Of course, you can name it as you want.  But I thought that the name 
> "rebase" applies as well: the patches are rebased from somewhere else on 
> top of HEAD :-)

  even not considering the sequencer work, wouldn't "sequence" be a well
descriptive name?

				Petr "Pasky" Baudis
