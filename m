From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 01/10] refs: add "for_each_bisect_ref" function
Date: Thu, 26 Mar 2009 17:52:21 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903261748280.12753@intel-tinevez-2-302>
References: <20090326055509.1bc16b28.chriscool@tuxfamily.org> <fabb9a1e0903252320j2edf4a8ct39f784c4319c3cb0@mail.gmail.com> <200903260848.42104.chriscool@tuxfamily.org> <49CBA42D.3000404@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1393486470-1238086343=:12753"
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	John Tapsell <johnflux@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Mar 26 17:54:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lmsq5-0003zL-U3
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 17:53:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756637AbZCZQw1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2009 12:52:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754705AbZCZQw1
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Mar 2009 12:52:27 -0400
Received: from mail.gmx.net ([213.165.64.20]:41284 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754584AbZCZQw0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2009 12:52:26 -0400
Received: (qmail invoked by alias); 26 Mar 2009 16:52:23 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp065) with SMTP; 26 Mar 2009 17:52:23 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19+itcRkrJ+NrK4YTH0Wo1MpXXMimDLnOavvDgl6t
	TgOAZ61ncLyknr
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <49CBA42D.3000404@drmicha.warpmail.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.62
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114801>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1393486470-1238086343=:12753
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Thu, 26 Mar 2009, Michael J Gruber wrote:

> Christian Couder venit, vidit, dixit 26.03.2009 08:48:
> 
> > Le jeudi 26 mars 2009, Sverre Rabbelier a écrit :
> >
> >> A 10 patches series with no cover letter?
> > 
> > I am not a big fan of cover letters. Usually I prefer adding comments 
> > in the patches.
> 
> I'm sorry I have to say that, but your individual preferences don't 
> matter. Many of us would do things differently, each in their own way, 
> but people adjust to the list's preferences. It's a matter of attitude. 
> So, please...

Actually, a better way to ask for a cover letter would have been to 
convince Christian.  So I'll try that.

>From the patch series' titles (especially when they are cropped due to the 
text window being too small to fit the indented thread), it is not all 
that obvious what you want to achieve with those 10 patches.

>From recent discussions, I seem to remember that you wanted to have some 
cute way to mark commits as non-testable during a bisect, and I further 
seem to remember that Junio said that very method should be usable outside 
of bisect, too.

Unfortunately, that does not reveal to me, quickly, what is the current 
state of affairs, and what you changed since the last time.

In addition, I am very sorry that I cannot review your patches; day job is 
killing me right now.

Ciao,
Dscho

--8323329-1393486470-1238086343=:12753--
