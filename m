From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: PUSH_HEAD, was Re: FETCH_HEAD question
Date: Tue, 17 Feb 2009 23:58:13 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902172357450.10279@pacific.mpi-cbg.de>
References: <76718490902162043k78e615b5g7ba4b7ac95e73b18@mail.gmail.com>  <7veixxaale.fsf@gitster.siamese.dyndns.org>  <76718490902162221i31e02052j48c9f620a2d47985@mail.gmail.com>  <7vr61x8ra4.fsf@gitster.siamese.dyndns.org>  <76718490902162341y2f122427i470c77d3915ff554@mail.gmail.com>
  <7vy6w5795h.fsf@gitster.siamese.dyndns.org>  <76718490902170914p6258b77ak81318f13757f0dfd@mail.gmail.com>  <alpine.DEB.1.00.0902171821190.6185@intel-tinevez-2-302> <76718490902170934u5e2c17ffl7599ddeb5ee59812@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 17 23:59:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZYtz-0003Hu-5K
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 23:58:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753760AbZBQW5Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 17:57:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753770AbZBQW5Q
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 17:57:16 -0500
Received: from mail.gmx.net ([213.165.64.20]:57895 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752949AbZBQW5P (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 17:57:15 -0500
Received: (qmail invoked by alias); 17 Feb 2009 22:57:13 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp012) with SMTP; 17 Feb 2009 23:57:13 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+B0+oU/JGB174CNSw1OmivM8S2f16LXHCcdK4L6h
	ah6SlpQAZljrEk
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <76718490902170934u5e2c17ffl7599ddeb5ee59812@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110466>

Hi,

On Tue, 17 Feb 2009, Jay Soffian wrote:

> On Tue, Feb 17, 2009 at 12:22 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >> Unless dwim_ref() is updated to handle FETCH_HEAD specially, and
> >> return not the first SHA1, but the one not marked "not-for-merge".
> >> Then the UI would at least be consistent, but this would not be
> >> backward compatible.
> >
> > You cannot fix parsing FETCH_HEAD as a ref (and neither will you be able
> > to do with PUSH_HEAD), as it can contain _more_ than one SHA-1s.  This
> > still holds true when ignoring the not-for-merge lines, as an octopus is
> > a quite real possibility.
> 
> An even better argument against than it not being backward compatible. :-)
> 
> And there is no PUSH_HEAD.

Heh, that's why I used the future tense :-)

Ciao,
Dscho
