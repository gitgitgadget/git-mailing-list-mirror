From: "Geoff Russell" <geoffrey.russell@gmail.com>
Subject: Re: reflog/show question
Date: Wed, 30 Apr 2008 07:36:23 +0930
Message-ID: <93c3eada0804291506n7432b348p2b726926b5fc8f80@mail.gmail.com>
References: <93c3eada0804271859p1b4d8b52i811bdc5e42672822@mail.gmail.com>
	 <20080428092410.GD16153@sigill.intra.peff.net>
	 <93c3eada0804281847q267611aeke51b482cfbe100d6@mail.gmail.com>
	 <20080429201214.GB20509@sigill.intra.peff.net>
Reply-To: geoffrey.russell@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 30 00:07:19 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jqxyk-0003U6-Ej
	for gcvg-git-2@gmane.org; Wed, 30 Apr 2008 00:07:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754276AbYD2WG1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 18:06:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754272AbYD2WG1
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 18:06:27 -0400
Received: from fk-out-0910.google.com ([209.85.128.184]:32124 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753547AbYD2WG0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 18:06:26 -0400
Received: by fk-out-0910.google.com with SMTP id 18so11667fkq.5
        for <git@vger.kernel.org>; Tue, 29 Apr 2008 15:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=UM3bM/87tZ2Aeb2wyB0n9qQNFFGRmiYt6BSF2YL+F8E=;
        b=Vb6vCxx5WkEJ0HdOmVMfd40d+buV/P+6VNpDqxkd6MDn09q8a+v5tkx5dLWz1ByVGRExZQ4J1lPfjKvFd39rirYARZO8t2dGlu6TmskR73eWEj/uJti2bAkEb11GUJcYDtHvkxvB50sbn9PHUNt3P/narwfh+8ERbbmXAnC97sA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NwvC9wdFczkGNhnJXdleW2vFnNecjm+VoqpyGzPveZ3g8/TDfeIvi5GGKOrWdqV4V4OF02rAhLb3z5fI6kop1Co7s666V2/dXp+wJZo6zUAdfyFF8n5wolmUrX+d6aqmV/DgYC7k+2rNmkQk+bf2hyptBTyRJeZmsorxBSqAd1w=
Received: by 10.82.170.2 with SMTP id s2mr4299043bue.59.1209506783709;
        Tue, 29 Apr 2008 15:06:23 -0700 (PDT)
Received: by 10.82.105.8 with HTTP; Tue, 29 Apr 2008 15:06:23 -0700 (PDT)
In-Reply-To: <20080429201214.GB20509@sigill.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80755>

On 4/30/08, Jeff King <peff@peff.net> wrote:
> On Tue, Apr 29, 2008 at 11:17:09AM +0930, Geoff Russell wrote:
>
>  > >  >      git show HEAD@{"3 minutes ago"}
>  > >  >
>  > >  > works as I expect, but
>  > >  >
>  > >  >      git show HEAD@{"3 minutes ago"}:data/node/node.data
>  > >  >
>  > >  > gives me a message:
>  > >  >
>  > >  >        warning: Log for 'HEAD' only goes back to Mon, 28 Apr 2008
>  > >  >        10:18:37 +0930.
>  > >  >
>  > >
>
> > I think its something to do with the filename and my commit comments.
>  > The command works as expected on other files.  The HEAD file is
>  > attached.
>
>
> Hmm. Are you sure that the commit you got from HEAD@{"3 minutes ago"}
>  actually _has_ the file data/node/node.data? If it doesn't, then you get
>  the error message you saw. And it may be that the reflog warning happens
>  in _both_ cases, only you don't see it in the first because it is masked
>  by the pager. In v1.5.5, that output is now sent to the pager, instead.
>
>  -Peff
>

Later today (touch wood) I'll prepare as small a test case as
possible, then send
a tar.gz of the .git directory. Okay?

Geoff.


-- 
6 Fifth Ave,
St Morris, S.A. 5068
Australia
Ph: 041 8805 184 / 08 8332 5069
