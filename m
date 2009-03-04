From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-clone.txt: document that pushing from a shallow
 clone may work
Date: Wed, 4 Mar 2009 12:11:22 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903041209070.8549@intel-tinevez-2-302>
References: <237967ef0902160200r2320687ai71e62047c3ead9ad@mail.gmail.com> <1236080017-13987-1-git-send-email-dato@net.com.org.es> <49AD1B22.6050201@viscovery.net> <20090303120856.GB15003@chistera.yi.org> <76718490903031127v7fcec124je7292c4c465208b8@mail.gmail.com>
 <20090304101939.GA7142@chistera.yi.org> <7vvdqp5zx9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: =?ISO-8859-15?Q?Adeodato_Sim=F3?= <dato@net.com.org.es>,
	Jay Soffian <jaysoffian@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	Mikael Magnusson <mikachu@gmail.com>,
	Joey Hess <joey@kitenet.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 04 12:12:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lep21-0001rX-FE
	for gcvg-git-2@gmane.org; Wed, 04 Mar 2009 12:12:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756270AbZCDLL2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2009 06:11:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756257AbZCDLL2
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Mar 2009 06:11:28 -0500
Received: from mail.gmx.net ([213.165.64.20]:45177 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756236AbZCDLL1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2009 06:11:27 -0500
Received: (qmail invoked by alias); 04 Mar 2009 11:11:23 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp027) with SMTP; 04 Mar 2009 12:11:23 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18bVyc3tisbFwACSYZriptej4tJ9re4pHnGs2NohJ
	pbk+5C7kfoHjpE
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <7vvdqp5zx9.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112205>

Hi,

On Wed, 4 Mar 2009, Junio C Hamano wrote:

> Isn't the rule more or less like:
> 
>     If your shallow repository's history does not extend long enough and
>     the other repository forked before your truncated history, wyou cannot
>     compute the common ancestor and you cannot push out.

Exactly.

Back when I wrote the shallow code, I meant to investigate how to detect 
that condition, and fail gracefully (i.e. with a meaningful error 
message).

IMHO that is more needed than documentation changes, as it affects more 
users ;-)

But in the meantime, I had no use for shallow clones, and kind of hoped 
that it would become somebody else's itch.

Ciao,
Dscho
