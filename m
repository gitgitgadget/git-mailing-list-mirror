From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [ANNOUNCE] GIT 1.5.3
Date: Sun, 2 Sep 2007 13:19:37 +0200
Message-ID: <20070902111937.GB11473@steel.home>
References: <7vodglr32i.fsf@gitster.siamese.dyndns.org> <fbdt3q$lcf$1@sea.gmane.org> <Pine.LNX.4.64.0709021157120.28586@racer.site>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Arkadiusz Miskiewicz <arekm@pld-linux.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Sep 02 13:19:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRnUW-0005Xb-Mm
	for gcvg-git@gmane.org; Sun, 02 Sep 2007 13:19:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964794AbXIBLTk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Sep 2007 07:19:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932773AbXIBLTk
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Sep 2007 07:19:40 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:56184 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932753AbXIBLTk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Sep 2007 07:19:40 -0400
Received: from tigra.home (Fc93c.f.strato-dslnet.de [195.4.201.60])
	by post.webmailer.de (klopstock mo49) (RZmta 12.3)
	with ESMTP id Y015c9j82Ah7Dx ; Sun, 2 Sep 2007 13:19:38 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 06C32277BD;
	Sun,  2 Sep 2007 13:19:37 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 63EBABEAC; Sun,  2 Sep 2007 13:19:37 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0709021157120.28586@racer.site>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaFzAPiog==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57317>

Johannes Schindelin, Sun, Sep 02, 2007 12:59:04 +0200:
> Hi,
> 
> On Sun, 2 Sep 2007, Arkadiusz Miskiewicz wrote:
> 
> > Junio C Hamano wrote:
> > 
> > > The latest feature release GIT 1.5.3 is available at the usual
> > > places:
> > 
> > Hm,
> > 
> > [...]
> >
> > *** t0001-init.sh ***
> > * FAIL 1: plain
> > 
> >                 (
> >                         unset GIT_DIR GIT_WORK_TREE &&
> >                         mkdir plain &&
> >                         cd plain &&
> >                         git init
> >                 ) &&
> >                 check_config plain/.git false unset
> 
> Please try the verbose mode: cd t/ && sh t0001-init.sh -i -v.  If that 
> does not show you _what_ the problem is, try "sh -x [...]".

if that is buggy bash-2.05b the problem will just disappear.

I don't remember what it was when I first met this, but it seemed to be
very specific to this particular version of bash.
