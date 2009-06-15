From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Cast things properly to handle >2G files.
Date: Mon, 15 Jun 2009 10:45:37 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0906151043180.4245@intel-tinevez-2-302>
References: <E1MFvux-0001ix-I7@fencepost.gnu.org> <alpine.DEB.1.00.0906142215560.26154@pacific.mpi-cbg.de> <E1MG32S-0004C6-8A@fencepost.gnu.org> <7vmy8ap2cq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: ams@gnu.org, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 15 10:46:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MG7pp-0000eG-LO
	for gcvg-git-2@gmane.org; Mon, 15 Jun 2009 10:46:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756031AbZFOIpj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jun 2009 04:45:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752366AbZFOIpi
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jun 2009 04:45:38 -0400
Received: from mail.gmx.net ([213.165.64.20]:53868 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752453AbZFOIph (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2009 04:45:37 -0400
Received: (qmail invoked by alias); 15 Jun 2009 08:45:38 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp006) with SMTP; 15 Jun 2009 10:45:38 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18gMZdMORUgyULDYhBOTC2s0Ypq4SDNK2zDf0cZmA
	Zdnu7dln3cv/jw
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <7vmy8ap2cq.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121593>

Hi,

On Sun, 14 Jun 2009, Junio C Hamano wrote:

> "Alfred M. Szmidt" <ams@gnu.org> writes:
> 
> >    Oh, and maybe add a test like t/t5705-clone-2gb.sh?
> >
> > Thank you, that is a very good idea.
> 
> Nah, one blob that is over 2gb, deltified against something else?  
> That's a bit too much for a test script.

Why not?  It's not a difficult thing to come up with such a test.  And 
just like t5705, it can be hidden behind an "EXPENSIVE_TEST=YesPlease" 
environment variable.  Maybe I should have spelt that out loud instead of 
relying on interested parties to know t5705.

And just like t5705 it should help people to verify that the patch solves 
the problems indeed.

Ciao,
Dscho
