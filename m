From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 04/13] Teach rebase interactive the mark command
Date: Tue, 22 Apr 2008 18:12:00 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0804221810180.4460@eeepc-johanness>
References: <7vabkoufzq.fsf@gitster.siamese.dyndns.org> <1208132469-26471-1-git-send-email-joerg@alea.gnuu.de> <1208132469-26471-2-git-send-email-joerg@alea.gnuu.de> <1208132469-26471-3-git-send-email-joerg@alea.gnuu.de> <1208132469-26471-4-git-send-email-joerg@alea.gnuu.de>
 <7vabjm78v2.fsf@gitster.siamese.dyndns.org> <20080422095549.GB3752@alea.gnuu.de> <alpine.DEB.1.00.0804221127360.4460@eeepc-johanness> <7vy775ygjm.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: =?ISO-8859-15?Q?J=F6rg_Sommer?= <joerg@alea.gnuu.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 22 19:12:35 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoM2b-0004Sb-JW
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 19:12:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755588AbYDVRLj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2008 13:11:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753763AbYDVRLj
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 13:11:39 -0400
Received: from mail.gmx.net ([213.165.64.20]:40027 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753167AbYDVRLi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2008 13:11:38 -0400
Received: (qmail invoked by alias); 22 Apr 2008 17:11:36 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO eeepc-johanness.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp029) with SMTP; 22 Apr 2008 19:11:36 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/r5AAlxwbrxG87F7G911t+iXRgEMoPcj6sFF6kQG
	zgDCXoIXQy/B+Z
X-X-Sender: user@eeepc-johanness
In-Reply-To: <7vy775ygjm.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80142>

Hi,

On Tue, 22 Apr 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > So I really hate the idea of introducing yet other marks when we already 
> > have unique identifiers: the (abbreviated) commit names.
> 
> Didn't I give you an example why commit object names are _not_ unique
> identifiers already?

By that reasoning, rebase -i cannot work anyway: it relies on the 
abbreviated identifiers, not on anything else, for the "pick" command.

> I also do not understand why you think 'mark' is ugly.

Is that not obvious?  You _already_ have identifiers.  And there you add 
other ones.  Only because the original idea of the -p implementation was 
ignored.

Ciao,
Dscho
