From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC/PATCHv2] git submodule split
Date: Sun, 15 Feb 2009 00:01:28 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902150000140.10279@pacific.mpi-cbg.de>
References: <431341160902121350x45076c8cj26afab0b7a51cac5@mail.gmail.com>  <1234578258-48870-1-git-send-email-git@randomhacks.net>  <7v3aeh3a84.fsf@gitster.siamese.dyndns.org>  <alpine.DEB.1.00.0902141245080.10279@pacific.mpi-cbg.de>
 <431341160902140611x69a915e6lc3ee482f1ca66dc8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Mark Levedahl <mlevedahl@gmail.com>,
	Ping Yin <pkufranky@gmail.com>, Lars Hjemli <hjemli@gmail.com>
To: Eric Kidd <git@randomhacks.net>
X-From: git-owner@vger.kernel.org Sun Feb 15 00:02:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYTWO-0007hI-Mb
	for gcvg-git-2@gmane.org; Sun, 15 Feb 2009 00:02:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752365AbZBNXAg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2009 18:00:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752300AbZBNXAg
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 18:00:36 -0500
Received: from mail.gmx.net ([213.165.64.20]:60575 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752219AbZBNXAg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 18:00:36 -0500
Received: (qmail invoked by alias); 14 Feb 2009 23:00:33 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp006) with SMTP; 15 Feb 2009 00:00:33 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/jINgw5CDj7BiN9j04Cmf7ZlLhqj0bys6g35Wwko
	t8sKT21Itp2R1p
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <431341160902140611x69a915e6lc3ee482f1ca66dc8@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109950>

Hi,

On Sat, 14 Feb 2009, Eric Kidd wrote:

> On Sat, Feb 14, 2009 at 6:46 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > As I said to Eric already, I would like this to be part of git-submodule
> > proper, as I expect a lot of people needing it.
> 
> I'm happy to do whatever people want. :-) Even if this goes into
> contrib/, I want to include everything a regular git command would
> have: unit tests, a man page, portable sh code, etc.

That is the problem.  IIRC we do not have a testing framework in contrib/.  
Indeed, we would not catch breakages in contrib/ at all.

Ciao,
Dscho
