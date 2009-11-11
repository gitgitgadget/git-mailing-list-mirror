From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: [PATCH] Re: Clarify documentation on the "ours" merge strategy.
Date: Wed, 11 Nov 2009 22:30:49 +0100
Message-ID: <20091111213049.GJ27518@vidovic>
References: <alpine.DEB.1.00.0911031047510.4985@pacific.mpi-cbg.de> <200911111411.nABEBfox031023@ds9.cixit.se> <2faad3050911110713y4e33c7d2h21ad42efe4fd70b3@mail.gmail.com> <200911112135.25839.trast@student.ethz.ch> <7vskckn5b4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, Baz <brian.ewins@gmail.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 11 22:31:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8KmJ-00084L-SS
	for gcvg-git-2@lo.gmane.org; Wed, 11 Nov 2009 22:31:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758912AbZKKVat (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2009 16:30:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758865AbZKKVat
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Nov 2009 16:30:49 -0500
Received: from fg-out-1718.google.com ([72.14.220.154]:47579 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758847AbZKKVas (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2009 16:30:48 -0500
Received: by fg-out-1718.google.com with SMTP id e12so622139fga.1
        for <git@vger.kernel.org>; Wed, 11 Nov 2009 13:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=8/Fr9fonc8T9HOWGcAfdV/z1S+cUl1kC9wFWxcxfCEw=;
        b=OFJGt45Nckvixnt7Diz6mszN8zWDZZiTg0CDnNxEGBVmPIxBUSLKGicv9HkekNPdpN
         GzRz55iOxsWk9vwRBlOQG2b9twL4tjStCSUXwFuED90z+RE42cT80SCgFmt2EZULSQn/
         SfMKI/6xVErr/bZ8EO7ddNt3oEvpQrEcuInNs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=gs78+rP58Vjx5q42gKE2PmKzj1PnKOl8RbIyo3ZaaY4p8P2DfGfrPtajfr0OjCrNRd
         DuF1rVm1bQFpMkNPvT1sCOpTbuNGIwhgnd+Ueqwsz7+5KzD7wVdLBj+V2qJo2l4VTOWZ
         rR7ry8V865EVU/8TaFDi3jI2ENfQJHByu+xNc=
Received: by 10.86.11.26 with SMTP id 26mr1460667fgk.72.1257975053334;
        Wed, 11 Nov 2009 13:30:53 -0800 (PST)
Received: from @ (88-121-116-229.rev.libertysurf.net [88.121.116.229])
        by mx.google.com with ESMTPS id e11sm11637812fga.22.2009.11.11.13.30.51
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 11 Nov 2009 13:30:52 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vskckn5b4.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132706>

The 11/11/09, Junio C Hamano wrote:
> Thomas Rast <trast@student.ethz.ch> writes:
> 
> > ++
> > +Because the sides in a rebase are swapped, using this strategy with
> > +git-rebase is never a good idea.
> 
> Looking very good.

If this strategy is _never_ a good idea in this case, I tend to think
that git should forbid this option, or at least, warn and refer to the
documentation.

-- 
Nicolas Sebrecht
