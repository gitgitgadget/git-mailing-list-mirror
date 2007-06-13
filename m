From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: That improved git-gui blame viewer..
Date: Wed, 13 Jun 2007 13:03:52 +0200
Message-ID: <e5bfff550706130403y417b3e2dmd268c57c06b658fb@mail.gmail.com>
References: <alpine.LFD.0.98.0706091117510.20321@woody.linux-foundation.org>
	 <20070611064203.GG6073@spearce.org>
	 <alpine.LFD.0.98.0706110826590.14121@woody.linux-foundation.org>
	 <7vveduqxxr.fsf@assigned-by-dhcp.pobox.com>
	 <e5bfff550706112316j42c7c8e8uf8383de990ca9707@mail.gmail.com>
	 <7vbqflll55.fsf@assigned-by-dhcp.pobox.com>
	 <e5bfff550706120427g7ad9d38bpc34d9ea284ace693@mail.gmail.com>
	 <20070612135303.GT6073@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Jun 13 13:03:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyQdn-0002kh-9A
	for gcvg-git@gmane.org; Wed, 13 Jun 2007 13:03:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756978AbXFMLDy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 07:03:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756858AbXFMLDy
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 07:03:54 -0400
Received: from nz-out-0506.google.com ([64.233.162.228]:40737 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756619AbXFMLDx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 07:03:53 -0400
Received: by nz-out-0506.google.com with SMTP id n1so172762nzf
        for <git@vger.kernel.org>; Wed, 13 Jun 2007 04:03:52 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HxBCIRUuDS6h8OLeTmm8QVfNedg/rIFGcbddQ34AmOJPoRKAsqnCfGH2la2yxq1aSnUTgqT2VQIq0tNJ2l8ria0bHBGEacxntszLfYZyze0/tnVMuIXvl+D/CEW6TyrpCEAr2lBnb6Uegcau0HbWGzRYsHElQNL+rCrN3xwCmn4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=O1VzvyG5L1YJ/Z5xPxvQGrCqNFGGUckqvu7ZpNUNjKBdyxHGZwRdEeWSpPUFXLDE8gUNvMXtessvbUO9nRJSaCOSTpuemOG4L3/Pp9aXbXt1qCxTjZqsulyKGqjuQ9NPVt6btEZIUnuawPkHD+rB0KdGu/ISWkbWpnoRv37mJXY=
Received: by 10.114.137.2 with SMTP id k2mr499603wad.1181732632112;
        Wed, 13 Jun 2007 04:03:52 -0700 (PDT)
Received: by 10.114.56.6 with HTTP; Wed, 13 Jun 2007 04:03:52 -0700 (PDT)
In-Reply-To: <20070612135303.GT6073@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50043>

On 6/12/07, Shawn O. Pearce <spearce@spearce.org> wrote:
>
> It is unclear why you aren't just using `git blame --incremental`.
> git-blame running in two passes (with and without -M -C -C) can yield
> some very interesting results on files, like Git's own revision.c.
> And with the new -w flag that Junio just added, there's even more
> interesting possibilities...
>

I will try to explore with git-blame better, thanks.

Marco
