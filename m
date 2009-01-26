From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/3] Make has_commit non-static
Date: Mon, 26 Jan 2009 21:38:03 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901262137290.25749@intel-tinevez-2-302>
References: <1232979205-17161-1-git-send-email-goulding@vivisimo.com> <1232979205-17161-2-git-send-email-goulding@vivisimo.com> <alpine.DEB.1.00.0901261637300.25749@intel-tinevez-2-302> <7v63k16dd0.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jake Goulding <goulding@vivisimo.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 26 21:39:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRYFP-00042E-J9
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 21:39:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752942AbZAZUia (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 15:38:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751302AbZAZUi3
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 15:38:29 -0500
Received: from mail.gmx.net ([213.165.64.20]:46455 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751834AbZAZUi3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2009 15:38:29 -0500
Received: (qmail invoked by alias); 26 Jan 2009 20:38:23 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp011) with SMTP; 26 Jan 2009 21:38:23 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/lAS0faoPl/UJrjV9P7Zm1LUkj1vqEBonpPPF+Q1
	0x/ozXi6p2OxQm
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <7v63k16dd0.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107270>

Hi,

On Mon, 26 Jan 2009, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Mon, 26 Jan 2009, Jake Goulding wrote:
> >
> >> Moving has_commit from branch to a common location in preparation for 
> >> using it in tag. Renaming it to commit_has_any_in_commit_list to be 
> >> more unique.
> >
> > I feel like bike-shedding for a change, and I'd also like to prove 
> > that not all Germans like long names:
> >
> > 	is_ancestor_of_any()
> >
> > Hmm?
> 
> Is it ancestor or descendant?  The latter makes the name longer, though 
> ;-)

I did not read the patch and missed that it means the opposite, sorry...

Ciao,
Dscho
