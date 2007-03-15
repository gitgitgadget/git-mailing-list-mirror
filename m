From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH 2/5] diff --quiet
Date: Thu, 15 Mar 2007 22:08:18 +0100
Message-ID: <81b0412b0703151408v5e6245f4l95fb7cc801e1b568@mail.gmail.com>
References: <7vwt1j8z0e.fsf@assigned-by-dhcp.cox.net>
	 <7vodmv7bza.fsf@assigned-by-dhcp.cox.net>
	 <81b0412b0703141614m70f4a565qc001e06e60b0ffd5@mail.gmail.com>
	 <7v8xdz5qn0.fsf@assigned-by-dhcp.cox.net>
	 <81b0412b0703150119l705eefb6h6af44b9452db83e2@mail.gmail.com>
	 <Pine.LNX.4.63.0703151136470.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <81b0412b0703150655y3d2a71d3t8db6e334ecf23ca1@mail.gmail.com>
	 <Pine.LNX.4.63.0703151841180.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Mar 15 22:08:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRxBZ-0007jU-4R
	for gcvg-git@gmane.org; Thu, 15 Mar 2007 22:08:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751325AbXCOVIV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Mar 2007 17:08:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751390AbXCOVIV
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Mar 2007 17:08:21 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:5810 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751325AbXCOVIU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Mar 2007 17:08:20 -0400
Received: by ug-out-1314.google.com with SMTP id 44so497665uga
        for <git@vger.kernel.org>; Thu, 15 Mar 2007 14:08:19 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GCsmfIUOhVbJABYPsczbDRA4D/1XNqkCzClfdCQLnAy2+hg7WkcAZrBBNtDrzfnWUOvTdojmD33n65B3lhVfUL39Qvt98mn3xFsGLz52mYW26y8xOIZW5jQJZERMK1rOiWZoQCDiDTpsds1RnBYHFhcAZ34h0DQ0a2SR++ciYqk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=a2er3DZtSBmCkJtd1uyyd1hGu5o028FxTaxjEP0PmMLwCWzbaAqznA8yo8Vx4AMB7jgyaDYoy5amFEGXJWxmdg1gLOssh5zSPkN/Fd0te2L5SjRhO8F+xwxQ9w879F8FxCFFIsME1a5GtCC1MkniQdPEKG3+4N6FxP8MhEOL6k0=
Received: by 10.78.181.13 with SMTP id d13mr631847huf.1173992899038;
        Thu, 15 Mar 2007 14:08:19 -0700 (PDT)
Received: by 10.78.138.5 with HTTP; Thu, 15 Mar 2007 14:08:18 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.63.0703151841180.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42299>

On 3/15/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > > (That, however, works only if you do not want something like "git diff
> > > -w"...)
> >
> > Why? Can't "git diff -w" quit early?
>
> No, but "-w" means "ignore white space", which means that blobs can be
> deemed equal, even if they differ at the byte-per-byte level.
>

So it can leave early as soon as it found a difference on byte level
and the difference is not white space, can't it?
