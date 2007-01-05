From: "Chris Lee" <chris133@gmail.com>
Subject: Re: git-svnimport failed and now git-repack hates me
Date: Fri, 5 Jan 2007 12:48:01 -0800
Message-ID: <204011cb0701051248xdd9be8ch68db18ea93abd1f6@mail.gmail.com>
References: <204011cb0701031552j8292d23v950f828279702d3@mail.gmail.com>
	 <Pine.LNX.4.64.0701031737300.4989@woody.osdl.org>
	 <7v1wmbnw9x.fsf@assigned-by-dhcp.cox.net>
	 <204011cb0701040958k884b613i8a4639201ae6443b@mail.gmail.com>
	 <7v1wmalez6.fsf@assigned-by-dhcp.cox.net>
	 <204011cb0701050919w2001105asefe2fd99165dfa95@mail.gmail.com>
	 <7vbqldfg56.fsf@assigned-by-dhcp.cox.net>
	 <204011cb0701051133r1ede14a6gd5093a3e7fa88cb5@mail.gmail.com>
	 <20070105193958.GE8753@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 05 21:48:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2vyx-0006EG-PB
	for gcvg-git@gmane.org; Fri, 05 Jan 2007 21:48:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750754AbXAEUsE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 Jan 2007 15:48:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750738AbXAEUsE
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jan 2007 15:48:04 -0500
Received: from wx-out-0506.google.com ([66.249.82.229]:11725 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750754AbXAEUsD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jan 2007 15:48:03 -0500
Received: by wx-out-0506.google.com with SMTP id h27so7193457wxd
        for <git@vger.kernel.org>; Fri, 05 Jan 2007 12:48:01 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VB1+x57yZBH+Rc3XDDwdFX1QJk5pY43fQFfU2KifXnURJHs1A+uNNfqQL/R87XVMtPf0WFfXAbPLBy4VwPomc1ldcE4MHQCLprdWwwhngnhMxcgwi/Maz7ayIuBKqH8n2rAy+axgAaeNm1M8BNQCAMJuLObz9DyYbadMkNtmTuY=
Received: by 10.90.52.2 with SMTP id z2mr1011058agz.1168030081374;
        Fri, 05 Jan 2007 12:48:01 -0800 (PST)
Received: by 10.90.81.19 with HTTP; Fri, 5 Jan 2007 12:48:01 -0800 (PST)
To: "Shawn O. Pearce" <spearce@spearce.org>
In-Reply-To: <20070105193958.GE8753@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36020>

On 1/5/07, Shawn O. Pearce <spearce@spearce.org> wrote:
> git-prune is expensive.  Very expensive on very large projects,
> as it must iterate every object to decide what is needed, before
> it can start to remove objects that aren't needed.
>
> Yes, it doesn't deal with removing pack files.  That's what the -d
> to git-repack is for.

Not nearly as expensive as git-repack, that's for sure. :)

And - I originally thought that adding '-d' to git-repack just told it
to call 'git-prune' afterwards. It does more than that, which is cool.
Happily importing away - up to r320k now.
