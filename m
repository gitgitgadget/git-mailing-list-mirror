From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH/RFC v2 1/4] Add "core.eolStyle" variable to control
 end-of-line conversion
Date: Mon, 10 May 2010 17:46:55 +0400
Message-ID: <20100510134655.GE14069@dpotapov.dyndns.org>
References: <cover.1273352819.git.eyvind.bernhardsen@gmail.com>
 <c8ef28b72709013f17e093954a0f4e2ad1fb9652.1273352819.git.eyvind.bernhardsen@gmail.com>
 <alpine.LFD.2.00.1005081455450.3711@i5.linux-foundation.org>
 <E2A9C4D2-010F-44B2-BF6A-627DE8B72FB5@gmail.com>
 <BFFD3CAC-E7D9-49D8-9B67-C3F5157646F3@gmail.com>
 <20100509070043.GB14069@dpotapov.dyndns.org>
 <CD080D38-811C-4BBF-A5CB-6B613555FE72@gmail.com>
 <20100509200935.GA22563@pvv.org>
 <20100510081358.GD14069@dpotapov.dyndns.org>
 <20100510111438.GA15206@pvv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	"git@vger.kernel.org List" <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	mat <matthieu.stigler@gmail.com>,
	hasen j <hasan.aljudy@gmail.com>,
	Erik Faye-Lund <kusmabite@googlemail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Robert Buck <buck.robert.j@gmail.com>
To: Finn Arne Gangstad <finnag@pvv.org>
X-From: git-owner@vger.kernel.org Mon May 10 15:47:12 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBTK8-0004yV-Qc
	for gcvg-git-2@lo.gmane.org; Mon, 10 May 2010 15:47:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754255Ab0EJNrB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 May 2010 09:47:01 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:7003 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751744Ab0EJNrA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 May 2010 09:47:00 -0400
Received: by fg-out-1718.google.com with SMTP id 19so766079fgg.1
        for <git@vger.kernel.org>; Mon, 10 May 2010 06:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=en6Fcaj3qOGzV8IThSlAk8mBWhvWEbIJIgwufkboNsY=;
        b=iTZJlNxmbXwqNqXFGgg+jwedBn1OXoBTpay5fKPwxPqkD8GyqfwuCBMayRjpPUfw7F
         LKvSEzwMYcMZKq5xMu+vN6B6RuxvSh9TCdc03NGVhM61egSUMbwk5XCXp99YPb7ow/MQ
         yb4HrB+U3fdKRhzuzNTyrCTU7aQ/th8KMzwoI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=GeUtp2CNcXyFbpKtyWGV0v/xQTtF3CQhWZo7+Gqh0qlLxCisblzKu510+fWfl6ioNA
         stmF7aHCF8T7XXDLBihhuusTJgMmjN9xF/DwzZoTZVA2loOcx5TWCOJqz6DRH6aiGI4z
         8IlO4LEPhYGExKc+lsPsMPrPspfBV1n6ow8IY=
Received: by 10.87.22.35 with SMTP id z35mr9607610fgi.46.1273499218380;
        Mon, 10 May 2010 06:46:58 -0700 (PDT)
Received: from localhost (ppp91-76-18-177.pppoe.mtu-net.ru [91.76.18.177])
        by mx.google.com with ESMTPS id 12sm9640343fks.50.2010.05.10.06.46.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 10 May 2010 06:46:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100510111438.GA15206@pvv.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146814>

On Mon, May 10, 2010 at 01:14:39PM +0200, Finn Arne Gangstad wrote:
> On Mon, May 10, 2010 at 12:13:58PM +0400, Dmitry Potapov wrote:
> > 
> > First of autocrlf is safe as it is implemented now.
> 
> No, it isn't. autocrlf as it is implemented now is destructive for any
> file that contains CRLF in the repo (it also gives dirty files after
> checkout and so on).

It may give dirty files in your working tree, but you do not lose any
information silently (as it happened with CVS), so it is safe in this
respect.

> 
> > I believe that the right solution is to be able to enable autocrlf but
> > only for those repositories that are marked as autocrlf compatible by
> > upstream.
> 
> Yes absolutely. But how do you tell autocrlf that the repository is
> compatible with it?  This is what is causing all the problems.

I suppose the original design assumption of autocrlf was that nearly all
repo should be compatible, because autocrlf is very good on detecting
text files. The problem with that is that many people want to store text
files with different endings, but they cannot be bothered to add a few
lines to .gitattributes. And while it is possible now to disable autocrlf
in any repo just by adding one line to .gitattributes:
* -crlf
but it is impossible to say the opposite.

So, I believe we should add "crlf=auto" as Eyvind proposed, as well as
to do eol conversion for files marked as "crlf" even if autocrlf is not
set as Linus suggested earlier. (Certainly, "eolconv" would be a better
name than "crlf", but maybe it is not the right time to replace it right
now).

> 
> Now, I propose to change autocrlf in such a way that it will work as
> before for all repositories that are "compatible with it", but _also_
> so that it works reasonably with those that aren't.

No, you proposed something different. You said that conversion for new
files would become optional. I don't know what exactly you mean by
optional, but it sounds incompatible with what we have now. In fact,
what I really like about autocrlf is that I do not need to think about
when I add a new file.

Moreover, you said "Convert LF-only text files to CRLF on checkout",
which raises two questions:

1. Where should information about what file was and what was not
converted be stored? (Storying it in the index can make the index
incompatible with old versions of Git).

2. How does it solve the problem with new files? (Just saying that
this conversation will be optional, does not it mean that it will be
right for this particular repo.)



Dmitry
