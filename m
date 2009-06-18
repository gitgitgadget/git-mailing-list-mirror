From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Re: rebase -i: auto-squash commits
Date: Thu, 18 Jun 2009 10:06:07 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0906181003300.4848@intel-tinevez-2-302>
References: <e1868cfe0906170506o37a75c35m47f9456bf8ae47c1@mail.gmail.com> <43d8ce650906170555m644564b3v3722168f7217c326@mail.gmail.com> <7vvdmurfao.fsf@alter.siamese.dyndns.org> <20090618063348.6117@nanako3.lavabit.com> <alpine.DEB.1.00.0906180007370.26154@pacific.mpi-cbg.de>
 <20090618001111.GB12954@vidovic> <7v8wjq2kqc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	John Tapsell <johnflux@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 18 10:06:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHCdn-0005Ru-47
	for gcvg-git-2@gmane.org; Thu, 18 Jun 2009 10:06:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754505AbZFRIGP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2009 04:06:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754325AbZFRIGM
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jun 2009 04:06:12 -0400
Received: from mail.gmx.net ([213.165.64.20]:32956 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754261AbZFRIGH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2009 04:06:07 -0400
Received: (qmail invoked by alias); 18 Jun 2009 08:06:08 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp002) with SMTP; 18 Jun 2009 10:06:08 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/snVABD/DsiefvWmkngncvHTzESixBcdJuym94EG
	CEzLKTLXJl4u4j
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <7v8wjq2kqc.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121806>

Hi,

On Wed, 17 Jun 2009, Junio C Hamano wrote:

> Now, I initially had the same reaction as Dscho.  What happens if I 
> really want to write a commit message that begins with "squash to "?
> 
> But after thinking about it a bit more, I do not think it is as bad as 
> it sounds anymore.
> 
> The commit not only must begin with "squash to " but also there has to 
> be a matching commit whose message begins with the remainder of the 
> title of the "squash to" commit _in the range you are rebasing 
> INTERACTIVELY_.
> 
> In addition, the resulting rebase insn is presented in the editor, and 
> in a rare case where you do have such a commit, you can rearrange it 
> back.

Well, that really sounds pretty awkward to me.  I regularly call such 
commits "amend".  If there is a risk I confuse myself as to which commit 
needs to be amended, I use "amend.<short-hint>".

I'd really rather stay with "fixup".  And as I use single-letter commands 
quite often, I'd also rather stay away from that magic "!".  And by 
"magic" I really mean that: people will not find that magic intuitive at 
all.

My vote is for "fixup".

Ciao,
Dscho
