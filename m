From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH 2/5] diff --quiet
Date: Thu, 15 Mar 2007 14:55:01 +0100
Message-ID: <81b0412b0703150655y3d2a71d3t8db6e334ecf23ca1@mail.gmail.com>
References: <7vwt1j8z0e.fsf@assigned-by-dhcp.cox.net>
	 <7vodmv7bza.fsf@assigned-by-dhcp.cox.net>
	 <81b0412b0703141614m70f4a565qc001e06e60b0ffd5@mail.gmail.com>
	 <7v8xdz5qn0.fsf@assigned-by-dhcp.cox.net>
	 <81b0412b0703150119l705eefb6h6af44b9452db83e2@mail.gmail.com>
	 <Pine.LNX.4.63.0703151136470.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Mar 15 14:55:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRqQ9-0001IN-F5
	for gcvg-git@gmane.org; Thu, 15 Mar 2007 14:55:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161347AbXCONzF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Mar 2007 09:55:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161351AbXCONzF
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Mar 2007 09:55:05 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:62462 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161347AbXCONzC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Mar 2007 09:55:02 -0400
Received: by ug-out-1314.google.com with SMTP id 44so332604uga
        for <git@vger.kernel.org>; Thu, 15 Mar 2007 06:55:01 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LgCpWQz388yKZfHNDFaFXeev0yp3a0Zy8WadEOdIAtBP3THsczOytMsaZm2cd+EZahn6D/Zx9bVcA4haZgWivtjnzivfS5GstNSVi2QAEndk3a/KSlr7JDPFJwQmP8hkzKjhbauJ5CTwrjIx5kAAcaFfyElRq4r0NGnHBCg54To=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MneMalAMNzYYpTOue5lps1vc8pDeKRDZxE2FgoqEPcExOGPl5JuU2jQHX24H80DYBeXa+Jp1Ne+clu0fo2nG/4/d/UlM8BV93ICvbIvlQXR8upmosSWjsIvxq/kIV3M3LzEKPuKu/w4GoNQD9emIrtFpEtvg7+yVuNJHWxjiYEM=
Received: by 10.78.124.13 with SMTP id w13mr355223huc.1173966901046;
        Thu, 15 Mar 2007 06:55:01 -0700 (PDT)
Received: by 10.78.138.5 with HTTP; Thu, 15 Mar 2007 06:55:01 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.63.0703151136470.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42279>

On 3/15/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > >         $ git-rev-parse v2.6.16^{tree} v2.6.20^{tree}
> > >
> >
> > Why would I want to benchmark --quiet with rev-parse?
>
> It is not benchmarking, but it is a faster solution: you can see if two
> trees are different by comparing their SHA-1s.

Can the same be done for index? (index-tree comparison)

> (That, however, works only if you do not want something like "git diff
> -w"...)

Why? Can't "git diff -w" quit early?
