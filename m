From: Aneesh Kumar <aneesh.kumar@gmail.com>
Subject: Re: The merge from hell...
Date: Thu, 2 Feb 2006 13:37:41 +0530
Message-ID: <cc723f590602020007s43f89d10i4529d118ade7c764@mail.gmail.com>
References: <Pine.LNX.4.64.0602012212200.21884@g5.osdl.org>
	 <e5bfff550602012325s7d0a799ct5bfabbce2c579449@mail.gmail.com>
	 <Pine.LNX.4.64.0602012356131.21884@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Marco Costalba <mcostalba@gmail.com>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>,
	Paul Mackerras <paulus@samba.org>,
	Marco Costalba <mcostalba@yahoo.it>
X-From: git-owner@vger.kernel.org Thu Feb 02 09:08:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4ZVK-0003qs-NH
	for gcvg-git@gmane.org; Thu, 02 Feb 2006 09:07:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423359AbWBBIHo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Feb 2006 03:07:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423370AbWBBIHo
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Feb 2006 03:07:44 -0500
Received: from uproxy.gmail.com ([66.249.92.202]:35530 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1423359AbWBBIHn convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 2 Feb 2006 03:07:43 -0500
Received: by uproxy.gmail.com with SMTP id s2so105987uge
        for <git@vger.kernel.org>; Thu, 02 Feb 2006 00:07:42 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ENZIFsFQ601K2tpnB0u8TWOWt83d0+WWL7EyDCZesAIHqWt+c812D9ZIZT8PPVEbAsyqGfdTMIK2cB8RkKGGrf+QmTchP/oSEpbtTETQRJ7crWmJx3jJ7xJ/bsZpBLmaOjtbu1LX2xmWUWzm6omw41IlFSZlYlQC/iKNqNg32OM=
Received: by 10.66.225.15 with SMTP id x15mr174198ugg;
        Thu, 02 Feb 2006 00:07:41 -0800 (PST)
Received: by 10.66.254.16 with HTTP; Thu, 2 Feb 2006 00:07:41 -0800 (PST)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602012356131.21884@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15494>

On 2/2/06, Linus Torvalds <torvalds@osdl.org> wrote:
>
>
> On Thu, 2 Feb 2006, Marco Costalba wrote:
> >
> > Currently the public git repo version of qgit uses "git-diff-tree -c"
> > for merges, It's not a problem to change qgit to use --cc option
> > instead. But I would like to use just one kind of option to filter
> > merges files.
>
> I think using "-c" rather than "--cc" is fine, and if it makes parsing
> easier..
>
> The "--cc" option should show less "noise", an dI'm actually arguing that
> it should show even less than it does now (for when the branches agreed
> with each other, and there was no actual conflict, which is what I think
> is more useful), but I don't think "-c" is _wrong_ either.
>
> Using "-c" is a strange kind of "show all differences in a file that had
> file-level merges" while at least to me "--cc" is meant to be more of a
> "show all actual file-level CONFLICTS where the merge actually did
> something different"


Ok i tried using --cc. But then as per the man page if the
optimization makes the all the hunks disapper then commit log is not
show unless -m is used. Is there a way to get the commit log printed.
BTW using -m didn't show any difference even though man page said
about some difference

-aneesh
