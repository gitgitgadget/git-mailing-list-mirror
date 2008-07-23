From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Wait help.autocorrect deciseconds before running
	corrected command
Date: Wed, 23 Jul 2008 20:45:41 +0200
Message-ID: <20080723184540.GE5283@blimp.local>
References: <alpine.DEB.1.00.0807222100150.8986@racer> <20080722203730.GC5113@blimp.local> <20080722210354.GD5113@blimp.local> <alpine.DEB.1.00.0807222207110.8986@racer> <20080722212633.GF5113@blimp.local> <alpine.DEB.1.00.0807222242160.8986@racer> <7vsku1jz4u.fsf@gitster.siamese.dyndns.org> <20080723164109.GA5283@blimp.local> <alpine.DEB.1.00.0807231756380.8986@racer>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 23 20:46:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLjMJ-0000yg-0G
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 20:46:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753587AbYGWSpn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 14:45:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753101AbYGWSpn
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 14:45:43 -0400
Received: from mo-p05-ob.rzone.de ([81.169.146.180]:57020 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753293AbYGWSpm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 14:45:42 -0400
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :YSxENQjhO8RswxTRIGdg201f5EC7
Received: from tigra.home (Faf34.f.strato-dslnet.de [195.4.175.52])
	by post.webmailer.de (mrclete mo17) (RZmta 16.47)
	with ESMTP id w066e7k6NH8uvf ; Wed, 23 Jul 2008 20:45:41 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from blimp (unknown [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id E7F81277BD;
	Wed, 23 Jul 2008 20:45:40 +0200 (CEST)
Received: by blimp (Postfix, from userid 1000)
	id 080BA36D18; Wed, 23 Jul 2008 20:45:41 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0807231756380.8986@racer>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89735>

Johannes Schindelin, Wed, Jul 23, 2008 18:57:05 +0200:
> On Wed, 23 Jul 2008, Alex Riesen wrote:
> 
> > +		if (autocorrect > 0) {
> > +			fprintf(stderr, "in %0.1f seconds automatically...\n",
> > +				(float)autocorrect/10.0);
> > +			poll(NULL, 0, autocorrect * 100);
> > +		}
> 
> What?  No countdown?  No fancy sounds when the time ran up?
> 

Hate them fancies... :)
