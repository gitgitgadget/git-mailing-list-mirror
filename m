From: "David Tweed" <david.tweed@gmail.com>
Subject: Re: Git User's Survey 2007 unfinished summary (long)
Date: Fri, 5 Oct 2007 02:48:51 +0100
Message-ID: <e1dab3980710041848i3aba0072lf166233f8d967e30@mail.gmail.com>
References: <8fe92b430710040212u332bb4e5yfa6c10b8236c6301@mail.gmail.com>
	 <Pine.LNX.4.64.0710041712120.4174@racer.site>
	 <20071005012726.GR2137@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Oct 05 03:49:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdcJK-0008EX-65
	for gcvg-git-2@gmane.org; Fri, 05 Oct 2007 03:49:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759403AbXJEBsy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2007 21:48:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758453AbXJEBsx
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Oct 2007 21:48:53 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:25829 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757844AbXJEBsx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2007 21:48:53 -0400
Received: by py-out-1112.google.com with SMTP id u77so697156pyb
        for <git@vger.kernel.org>; Thu, 04 Oct 2007 18:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=3nzPQ9APV2Rla4BjQvu/iwLv8aJuyuyGJbqJLx/jhNo=;
        b=Eb2SsbSGghGEfo50F9MgmsruugH09f7bVEMPjI7W1kfjDSfRGa9KodoGGV7Fh67zNFeoUuA3nDQOndugCRSYmiAvEvA2Jm5MMtkk5TNaT7s4b7Y0/xeBNAwtHGqNzZ3tQ/hS3Z7os8v2wWqg68IvTkgw32CEbGNvcAVmNFwH5MA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sTd1kD7TWY7ErI01Q+DzvnV6th+mRA/bMB9s7KplIpA5QnDwzDUEBljirGi1TfHaNSaAmInntpyanrGv9RW/bgW5WW7Z2r7nJc34XjxKAR0BCF4hqZ7S7PeCiPonvNvJxUwBDzWzAveeulicxV8hWTk8Bmg9Si9cUb9ZKFqzBmg=
Received: by 10.65.232.19 with SMTP id j19mr6307075qbr.1191548931775;
        Thu, 04 Oct 2007 18:48:51 -0700 (PDT)
Received: by 10.64.181.10 with HTTP; Thu, 4 Oct 2007 18:48:51 -0700 (PDT)
In-Reply-To: <20071005012726.GR2137@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60030>

On 10/5/07, Shawn O. Pearce <spearce@spearce.org> wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > On Thu, 4 Oct 2007, Jakub Narebski wrote:
> > > 26. Which porcelains do you use?
> > >
> > > Multiple answers (one can use more than one porcelain).
> > >
> > >   Answer (multiple choice)       | Count
> ...
> > >   other                          | 14

FWIW, I answered other there because I use my chronoversion
hacky-scripts (in addition to doing some other fine-level work with at
the low level git command line). Obviously it's not a general purpose
porcelain and it's "deliberately not using" normal development
practice because I do lots of loosely related speculative research
rather than working on a well-defined "product". I was initially
confused by what the index does (particularly since in those days it
was often referred to as a cache) and so wrote the whole routines
using low-level commands; if I was to do it again I'd have my script
just call "git add" and then using the vanilla "git commit".

-- 
cheers, dave tweed__________________________
david.tweed@gmail.com
Rm 124, School of Systems Engineering, University of Reading.
"we had no idea that when we added templates we were adding a Turing-
complete compile-time language." -- C++ standardisation committee
