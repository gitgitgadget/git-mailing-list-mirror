From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: "git clone --depth <depth>" producing history with <depth + 1>
 commits?
Date: Thu, 2 Apr 2009 13:00:57 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0904021248080.7464@intel-tinevez-2-302>
References: <49CBB490.8040908@hartwork.org> <49D3C300.1040303@hartwork.org> <alpine.DEB.1.00.0904020303320.10279@pacific.mpi-cbg.de> <7veiwbokd7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sebastian Pipping <webmaster@hartwork.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 02 13:02:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LpKgs-00075q-Oa
	for gcvg-git-2@gmane.org; Thu, 02 Apr 2009 13:02:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757680AbZDBLBF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2009 07:01:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754853AbZDBLBC
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Apr 2009 07:01:02 -0400
Received: from mail.gmx.net ([213.165.64.20]:38975 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751002AbZDBLBA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Apr 2009 07:01:00 -0400
Received: (qmail invoked by alias); 02 Apr 2009 11:00:57 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp051) with SMTP; 02 Apr 2009 13:00:57 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/dx/p+nMrdH5XxCocv6bv1bihix2pjxhZa2Grjdw
	23xMFFO3j5w51l
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <7veiwbokd7.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115456>

Hi,

On Wed, 1 Apr 2009, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Wed, 1 Apr 2009, Sebastian Pipping wrote:
> >
> >> Sebastian Pipping wrote:
> >> > Is "git clone --depth 1 <ropository>" expected to give a history 
> >> > with 2 commits?  "--depth 2" gives 3 commits, "--depth 0" all.
> >> > 
> >> > Is that by design or a bug?
> >> 
> >> Anyone?  Is "git clone --depth 1 <ropository>" really supposed to 
> >> produce a history holding _two_ commits?  Why so?
> >
> > Because storing _no_ commit (according to you, that should happen with 
> > --depth=0) would make no sense?
> 
> But then you can error out upon such a request.

Right.  Or disable the shallow cloning, as is the case now.

> > After all, if you want to clone, you want to clone at least 
> > _something_.
> 
> I am a bit puzzled by your logic.  If one is requested, shouldn't you 
> give only one and not two?

Reading the OP again, I have to apologize: I missed the fact that there is 
no way to have _just_ one commit.

And that is very obviously a bug.

If nobody beats me to it, I will take care of it this weekend.

Ciao,
Dscho
