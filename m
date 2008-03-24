From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] filter-branch.sh: support nearly proper tag name
 filtering
Date: Mon, 24 Mar 2008 16:10:43 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803241609540.4353@racer.site>
References: <1206031893-29599-1-git-send-email-casey@nrlssc.navy.mil> <47E298A5.6050508@nrlssc.navy.mil> <alpine.LSU.1.00.0803201812560.4124@racer.site> <7vr6e01xja.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0803241152050.4353@racer.site>
 <7viqzc18j9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Brandon Casey <casey@nrlssc.navy.mil>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 24 16:11:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdoKZ-0004fG-RA
	for gcvg-git-2@gmane.org; Mon, 24 Mar 2008 16:11:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760490AbYCXPKl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2008 11:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760452AbYCXPKl
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Mar 2008 11:10:41 -0400
Received: from mail.gmx.net ([213.165.64.20]:49224 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760474AbYCXPKk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2008 11:10:40 -0400
Received: (qmail invoked by alias); 24 Mar 2008 15:10:39 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp053) with SMTP; 24 Mar 2008 16:10:39 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19WUCkGWo5WHLAtCDALlj6SsbyXVqTSETNmAeHU1h
	bA0GExtjibheZL
X-X-Sender: gene099@racer.site
In-Reply-To: <7viqzc18j9.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78049>

Hi,

On Mon, 24 Mar 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Sun, 23 Mar 2008, Junio C Hamano wrote:
> >
> >> If you tell filter-branch to filter a branch A and a tag T, as the 
> >> command is advertised to rewrite positive refs that were given from 
> >> the command line, isn't it natural to expect that the command would 
> >> attempt its best effort to rewrite such a tag object?
> >
> > The thing is: signed tags cannot be rewritten.
> 
> I know that, and you know I know that if you read what you responded 
> again ;-)
> 
> And I think stripping of gpg signature part is a reasonable best effort 
> for the command, _when_ the user told a signed tag to be rewritten.

Yes.

BUT.

You can say "--all", and I actually expect quite a few people to do 
exactly that.  And then you cannot really say "the user explicitely asked 
to have that signed tag rewritten".

Ciao,
Dscho
