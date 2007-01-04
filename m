From: "Chris Lee" <chris133@gmail.com>
Subject: Re: git-svnimport failed and now git-repack hates me
Date: Wed, 3 Jan 2007 18:53:57 -0800
Message-ID: <204011cb0701031853xd226683g85f376c206aacf3e@mail.gmail.com>
References: <204011cb0701031552j8292d23v950f828279702d3@mail.gmail.com>
	 <Pine.LNX.4.64.0701031737300.4989@woody.osdl.org>
	 <20070104020652.GB18206@spearce.org>
	 <20070104023510.GC18206@spearce.org>
	 <204011cb0701031836w7d33ca8dh5de08984eec9730d@mail.gmail.com>
	 <20070104024523.GD18206@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@osdl.org>,
	"Junio C Hamano" <junkio@cox.net>,
	"Sasha Khapyorsky" <sashak@voltaire.com>,
	"Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 04 03:54:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2Ijx-0006IA-Dd
	for gcvg-git@gmane.org; Thu, 04 Jan 2007 03:54:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932231AbXADCx7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 Jan 2007 21:53:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932243AbXADCx7
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jan 2007 21:53:59 -0500
Received: from wr-out-0506.google.com ([64.233.184.239]:54045 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932231AbXADCx6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jan 2007 21:53:58 -0500
Received: by wr-out-0506.google.com with SMTP id 68so782779wri
        for <git@vger.kernel.org>; Wed, 03 Jan 2007 18:53:57 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CFbA9W6CiBVFwQK/wVpbSjZbhND0pHTGDgKwpiy6yN0ZKGr8pE8P9wFUPb/NReShYj2nqFxf0DCDW7p/H+4dlxu8BodbYL0Nsr685UaaMo45wakfo/KmCqdhzkAIRMfS/dxtKAe4QUO2psfOm9Nhy/YzHMEmLBy6rv7NdufA7AQ=
Received: by 10.90.52.18 with SMTP id z18mr6332575agz.1167879237622;
        Wed, 03 Jan 2007 18:53:57 -0800 (PST)
Received: by 10.90.80.11 with HTTP; Wed, 3 Jan 2007 18:53:57 -0800 (PST)
To: "Shawn O. Pearce" <spearce@spearce.org>
In-Reply-To: <20070104024523.GD18206@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35909>

On 1/3/07, Shawn O. Pearce <spearce@spearce.org> wrote:
> Chris Lee <chris133@gmail.com> wrote:
> > On 1/3/07, Shawn O. Pearce <spearce@spearce.org> wrote:
> > >I should also point out that my git-fastimport hack that we used
> > >on the huge Mozilla import may be helpful here.  Its _very_ fast
> > >as it goes right to a pack file, but there's no SVN frontend for
> > >it at this time.
> >
> > I would be *really* interested in playing with that. Where do I get it?
>
> Its a fork of git.git on repo.or.cz; the gitweb can be seen here:
>
>   http://repo.or.cz/w/git/fastimport.git
>
> the clone url is:
>
>   git://repo.or.cz/git/fastimport.git
>   http://repo.or.cz/r/git/fastimport.git
>
> The entire code is in fast-import.c.  The input stream it consumes
> comes in on STDIN and is documented in a large comment at the top
> of the file.

Neat. How do I do that?
