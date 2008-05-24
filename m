From: "Adam Mercer" <ramercer@gmail.com>
Subject: Re: git cvsimport error
Date: Sat, 24 May 2008 00:23:31 -0500
Message-ID: <799406d60805232223q3e2e0cf3k9abfe97ca94d3eff@mail.gmail.com>
References: <799406d60805211214r6315268ard77678eb2ec5d732@mail.gmail.com>
	 <799406d60805211239n42c39ea6iaa41a9ab379cafaa@mail.gmail.com>
	 <63BEA5E623E09F4D92233FB12A9F794301FC8B2D@emailmn.mqsoftware.com>
	 <799406d60805231301l1ff158b7k73bb193c472a8211@mail.gmail.com>
	 <63BEA5E623E09F4D92233FB12A9F794301FC8BCA@emailmn.mqsoftware.com>
	 <799406d60805231324o209692d2o59a700024e52100c@mail.gmail.com>
	 <20080523203025.GU29038@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Craig L. Ching" <cching@mqsoftware.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat May 24 07:24:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzmF2-0004Bx-7k
	for gcvg-git-2@gmane.org; Sat, 24 May 2008 07:24:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752429AbYEXFXh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 May 2008 01:23:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752457AbYEXFXh
	(ORCPT <rfc822;git-outgoing>); Sat, 24 May 2008 01:23:37 -0400
Received: from rv-out-0506.google.com ([209.85.198.234]:19929 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752324AbYEXFXg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 May 2008 01:23:36 -0400
Received: by rv-out-0506.google.com with SMTP id l9so1209753rvb.1
        for <git@vger.kernel.org>; Fri, 23 May 2008 22:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=gr04OVURNc63HGdCsyR9JIhAYt2gmFH0M0MNS+NN0YI=;
        b=RKkbDKuFbiLKArPIL+Bye3xqlZQX6o49dM1U7hbzlrCsUOI/v1PxRlhC9Z3u8Rt0PuhRXsnLUTvGj2iRPNOpe8+1Wit7mxejW2rfBV6pxlS4/yceSleqyoQFhOjUST84Fg2SuEHFek4tgq95IO7P6yDhxj/ip9nc8QNlNkWkuwo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jAVN1PB4PPdImS9+cIASIXAhI/U7c51YjN9s+mDXpYtBc8xyKWtZZyq5cKBfoTceten1rkSQz0l6N57/p2VuIKt+63bWM82ge3ZLxfHMwP4rH1Sbfl/L50IAIja0z4p1R77QUqDnFzkZDPGixfSPXwvqSnljvPZBcCw2bVZ3mxY=
Received: by 10.141.170.10 with SMTP id x10mr1042771rvo.92.1211606611947;
        Fri, 23 May 2008 22:23:31 -0700 (PDT)
Received: by 10.141.203.9 with HTTP; Fri, 23 May 2008 22:23:31 -0700 (PDT)
In-Reply-To: <20080523203025.GU29038@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82797>

On Fri, May 23, 2008 at 3:30 PM, Shawn O. Pearce <spearce@spearce.org> wrote:

> You can run fast-import in incremental behavior.  You just have to
> restart each branch with a "from refs/heads/master^0" or whatever.
> There's some discussion of this in the (rather large) fast-import
> man page.

Thanks I'll take a look at that as I've found that I can pass the -d
option to cvsps which _should_ tell it to ignore revisions before a
certain date, but even doing this cvsimport tries to import the broken
revision prior date!

Cheers

Adam
