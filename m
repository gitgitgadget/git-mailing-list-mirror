From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Use find instead of perl in t5000 to get file
	modification time
Date: Sat, 1 Nov 2008 00:37:36 +0100
Message-ID: <20081031233736.GB21997@steel.home>
References: <81b0412b0810290338j1beaa25bx9fb373a69f5dfe7@mail.gmail.com> <1225344554.10803.17.camel@maia.lan> <20081031070003.GA4458@blimp.localdomain> <alpine.DEB.1.00.0810312314190.22125@pacific.mpi-cbg.de.mpi-cbg.de>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sam Vilain <sam@vilain.net>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?iso-8859-15?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Nov 01 00:39:00 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kw3a0-0002ht-0Q
	for gcvg-git-2@gmane.org; Sat, 01 Nov 2008 00:39:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751669AbYJaXhr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 19:37:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751451AbYJaXhr
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 19:37:47 -0400
Received: from mo-p05-ob.rzone.de ([81.169.146.180]:58272 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751360AbYJaXhq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 19:37:46 -0400
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :Pm0FVUW6aauhRGJJc5OfA4AU8DM8ZlijdmJYxKn/UQvEQQx8BE81pIKr
Received: from tigra.home (Faf6f.f.strato-dslnet.de [195.4.175.111])
	by post.webmailer.de (fruni mo23) (RZmta 17.14)
	with ESMTP id I00222k9VMdsGR ; Sat, 1 Nov 2008 00:37:40 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id F3F0B277C8;
	Sat,  1 Nov 2008 01:37:39 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 1799156D27; Sat,  1 Nov 2008 00:37:37 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0810312314190.22125@pacific.mpi-cbg.de.mpi-cbg.de>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99680>

Johannes Schindelin, Fri, Oct 31, 2008 23:14:59 +0100:
> Hi,
> 
> On Fri, 31 Oct 2008, Alex Riesen wrote:
> 
> > ActiveState Perl on Windows is portable? To another windows, maybe.
> 
> /me wonders why you could not use the Perl that ships with Git for 
> Windows, at least for the purposes of Git.

Corporate policy and very-very incompetent IT service. Besides being
illegal to install actually usable software, there are some of
internal programs which are quite sensitive to perl (any other perl)
appearing anywhere on disk, not to mention PATH (the build system, for
one). Same for cygwin revisions.

I tried using other perl and more modern cygwin, and it can be made to
work, but it is cumbersome and boring. And one more thing to reinstall
after IT wipes your computer because you've got a new disk or they
decided you need winxp instead of w2k, or something else... So I'm
just trying reduce effort I put into what I'm not supposed to do at
work anyway.
