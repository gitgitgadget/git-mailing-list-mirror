From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] blame: make sure that the last line ends in an LF
Date: Tue, 20 Oct 2009 21:55:36 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0910202153160.4985@pacific.mpi-cbg.de>
References: <1256007988-13321-1-git-send-email-srabbelier@gmail.com> <7vbpk2sg6m.fsf@alter.siamese.dyndns.org> <fabb9a1e0910200615x5d487cdk6f50e11c96f2cb6c@mail.gmail.com> <7vbpk2ovio.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 20 21:53:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0KlL-0003Uo-LV
	for gcvg-git-2@lo.gmane.org; Tue, 20 Oct 2009 21:52:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752020AbZJTTwp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2009 15:52:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751571AbZJTTwp
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Oct 2009 15:52:45 -0400
Received: from mail.gmx.net ([213.165.64.20]:42397 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751402AbZJTTwo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2009 15:52:44 -0400
Received: (qmail invoked by alias); 20 Oct 2009 19:52:44 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp015) with SMTP; 20 Oct 2009 21:52:44 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19ZzAxkW9lZ9JCZfBQowfhaDwE6S5rM5rfMU9qCVm
	GFbzg/govHjWak
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7vbpk2ovio.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.65
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130831>

Hi,

On Tue, 20 Oct 2009, Junio C Hamano wrote:

> Sverre Rabbelier <srabbelier@gmail.com> writes:
> 
> >> Or am I worrying too much?
> >
> > No, I think your concerns are valid, we should go with (2) and DTRT. 
> > Does the updated patch address your concerns? If so I can send a new 
> > version.
> 
> Assuming the internal blame algorithm correctly works with such an 
> input, I'd be happier with an approach to allow users to tell the 
> difference. The --porcelain output was designed to be extensible, and it 
> might make sense to show the "this line is incomplete" as a separate 
> bit, though.

Sorry, you lost me.  If, say, line 614 is the last line that does not end 
in a new line, if I ask for it to be blamed, I want to know who is 
responsible for the current form of line 614.

Not whether the line ends in a new line or not.

Ciao,
Dscho
