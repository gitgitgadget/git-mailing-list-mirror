From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 09/21] Remove unneeded code from mktag.c
Date: Sat, 09 Jun 2007 23:42:57 +0200
Message-ID: <200706092342.57273.johan@herland.net>
References: <Pine.LNX.4.64.0706072348110.4046@racer.site>
 <200706090216.18823.johan@herland.net>
 <81b0412b0706091439q7be180celb939f694b80df159@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 09 23:43:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hx8iA-0001A7-AM
	for gcvg-git@gmane.org; Sat, 09 Jun 2007 23:43:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761621AbXFIVnB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Jun 2007 17:43:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761563AbXFIVnA
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jun 2007 17:43:00 -0400
Received: from smtp.getmail.no ([84.208.20.33]:33815 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761500AbXFIVm7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jun 2007 17:42:59 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JJE00D031NMA500@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Sat, 09 Jun 2007 23:42:58 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJE00JQX1NLIH30@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Sat, 09 Jun 2007 23:42:57 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJE000IQ1NLV690@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Sat, 09 Jun 2007 23:42:57 +0200 (CEST)
In-reply-to: <81b0412b0706091439q7be180celb939f694b80df159@mail.gmail.com>
Content-disposition: inline
User-Agent: KMail/1.9.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49627>

On Saturday 09 June 2007, Alex Riesen wrote:
> On 6/9/07, Johan Herland <johan@herland.net> wrote:
> > Signed-off-by: Johan Herland <johan@herland.net>
> > ---
> >  mktag.c |   94 ---------------------------------------------------------------
> >  1 files changed, 0 insertions(+), 94 deletions(-)
> 
> So, you do some useless changes just to remove the
> function completely afterwards?

Yes. Basically so that people can follow my process. If you don't want the
intermediary/useless states, just look at my first patch series that was
replaced by this series because it was too bulky and disruptive to follow.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
