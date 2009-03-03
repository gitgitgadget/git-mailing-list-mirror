From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] rebase -i: avoid 'git reset' when possible
Date: Tue, 3 Mar 2009 12:21:58 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903031221330.6399@intel-tinevez-2-302>
References: <fabb9a1e0902260655g53fa1e1fg7e4aa76b0f3a80fc@mail.gmail.com> <alpine.DEB.1.00.0902261557300.6258@intel-tinevez-2-302> <fabb9a1e0902260733k26e5c02i75a7866f9a67530b@mail.gmail.com> <alpine.DEB.1.00.0902271146460.6600@intel-tinevez-2-302>
 <alpine.DEB.1.00.0902271354130.6600@intel-tinevez-2-302> <7vvdqt8wob.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0903012242180.10279@pacific.mpi-cbg.de> <7v1vtfl8xi.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0903031008580.6399@intel-tinevez-2-302>
 <alpine.DEB.1.00.0903031024420.6399@intel-tinevez-2-302> <49AD1250.4080708@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Stephen Haberman <stephen@exigencecorp.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Thomas Rast <trast@student.ethz.ch>,
	Git Mailing List <git@vger.kernel.org>,
	Stephan Beyer <s-beyer@gmx.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Mar 03 12:23:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeSik-0000XQ-Nd
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 12:23:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753369AbZCCLWH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2009 06:22:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753528AbZCCLWE
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 06:22:04 -0500
Received: from mail.gmx.net ([213.165.64.20]:59274 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751637AbZCCLWC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2009 06:22:02 -0500
Received: (qmail invoked by alias); 03 Mar 2009 11:21:59 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp049) with SMTP; 03 Mar 2009 12:21:59 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18z84w74l0zi5wW4jxnz+CNNUbwTw8DYlCijG91Cm
	ImIbiUR7Nixt/r
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <49AD1250.4080708@viscovery.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112056>

Hi,

On Tue, 3 Mar 2009, Johannes Sixt wrote:

> Johannes Schindelin schrieb:
> > +# skip picking commits whose parents are unchanged
> > +skip_unnecessary_picks () {
> > +	fd=3
> > +	while read command sha1 rest
> > +	do
> > +		# fd=3 means we skip the command
> > +		case "$fd,$command,$(git rev-parse --verify --quiet $sha1^)" in
> > +		3,pick,"$ONTO"*|t,p,"$ONTO"*)
> 
> s/t,/3,/

Bah!  Of course, I had to insert a typo there!

Thanks!
Dscho
