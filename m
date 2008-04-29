From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 04/13] Teach rebase interactive the mark command
Date: Tue, 29 Apr 2008 01:39:51 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0804290138170.27457@eeepc-johanness>
References: <7vabkoufzq.fsf@gitster.siamese.dyndns.org> <1208132469-26471-1-git-send-email-joerg@alea.gnuu.de> <1208132469-26471-2-git-send-email-joerg@alea.gnuu.de> <1208132469-26471-3-git-send-email-joerg@alea.gnuu.de> <1208132469-26471-4-git-send-email-joerg@alea.gnuu.de>
 <7vabjm78v2.fsf@gitster.siamese.dyndns.org> <20080422095549.GB3752@alea.gnuu.de> <alpine.DEB.1.00.0804221127360.4460@eeepc-johanness> <7vy775ygjm.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0804221810180.4460@eeepc-johanness>
 <7v3ap5a4ny.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: =?ISO-8859-15?Q?J=F6rg_Sommer?= <joerg@alea.gnuu.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 29 02:40:52 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jqdtn-0006kd-33
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 02:40:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933406AbYD2Ajm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2008 20:39:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933387AbYD2Ajm
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 20:39:42 -0400
Received: from mail.gmx.net ([213.165.64.20]:59420 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933406AbYD2Ajk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2008 20:39:40 -0400
Received: (qmail invoked by alias); 29 Apr 2008 00:39:38 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO eeepc-johanness.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp040) with SMTP; 29 Apr 2008 02:39:38 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18A7jhmMXoA8oFUzlUYcRVIGXGo4Ss+00upe1MuJb
	Q02SE2FlO8jbyH
X-X-Sender: user@eeepc-johanness
In-Reply-To: <7v3ap5a4ny.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80637>

Hi,

On Mon, 28 Apr 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Tue, 22 Apr 2008, Junio C Hamano wrote:
> >
> >> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >> 
> >> > So I really hate the idea of introducing yet other marks when we already 
> >> > have unique identifiers: the (abbreviated) commit names.
> >> 
> >> Didn't I give you an example why commit object names are _not_ unique 
> >> identifiers already?
> >
> > By that reasoning, rebase -i cannot work anyway: it relies on the 
> > abbreviated identifiers, not on anything else, for the "pick" command.
> 
> No, read the message again and think for 5 minutes.

pick abcdefg
pick pqrstuv

Now imagine that pqrstuv is a unique commit name _before_ cherry-picking 
abcdefg, but not _after_ it.  Unlikely?  Yes.  Impossible?  No.

Ciao,
Dscho
