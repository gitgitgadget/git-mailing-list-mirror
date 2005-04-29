From: Kris Shannon <kris.shannon.kernel@gmail.com>
Subject: Re: RT[3/3]: Reverse lookup of SHA1 references
Date: Fri, 29 Apr 2005 10:11:23 +1000
Message-ID: <5d4799ae0504281711669ef900@mail.gmail.com>
References: <5d4799ae0504280559109cd00e@mail.gmail.com>
	 <5d4799ae05042806544683b4c9@mail.gmail.com>
	 <42717714.50601@dwheeler.com>
Reply-To: Kris Shannon <kris.shannon.kernel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: GIT Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 29 02:06:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRJ10-0002zK-O7
	for gcvg-git@gmane.org; Fri, 29 Apr 2005 02:05:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262348AbVD2AL3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 20:11:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262349AbVD2AL3
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 20:11:29 -0400
Received: from zproxy.gmail.com ([64.233.162.192]:49260 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262348AbVD2AL1 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2005 20:11:27 -0400
Received: by zproxy.gmail.com with SMTP id 13so612669nzp
        for <git@vger.kernel.org>; Thu, 28 Apr 2005 17:11:23 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rWXSWZutv204hs/9JB3RjLxXnsNNV+eWvSAv8sGnUnC/DxCuQDLQVBjZSYG+d7Z7qv8qN/9cGToME3ejzQ/mhuS+dpgZojx4tNdIz2uxdjjUo8Q8+zQW0OSXnE/E7UgEGtAJbVOUflLPViS2ds6W1+e4JHwv9eI6LsoCFU+WxVo=
Received: by 10.36.9.18 with SMTP id 18mr132544nzi;
        Thu, 28 Apr 2005 17:11:23 -0700 (PDT)
Received: by 10.36.4.16 with HTTP; Thu, 28 Apr 2005 17:11:23 -0700 (PDT)
To: dwheeler@dwheeler.com
In-Reply-To: <42717714.50601@dwheeler.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On 4/29/05, David A. Wheeler <dwheeler@dwheeler.com> wrote:
> Kris Shannon wrote:
> > There are a number of places where you want to find all the objects
> > which reference this particular object. AIUI this is not currently an easy
> > task. Some thought should be put into how to make these reverse
> > lookups fast.
> I have.  Please look at my old postings.  It turns out to be easy;
> just create a directory parallel to .git/objects, say:
>    .git/reverse
>       00/
>         89123408312904819048390/
>            189412890892308290
>            238923849038329089
> 
> Anyway you get the idea.

Seems reasonable.

> Linus does NOT want renames noted; see the old emails on that.
> It's not clear this is such a good idea, but he's adamant.
> He thinks this can be handled by merge.
> If not, it can be added later.

I realize that this is not a priority for linus,  I was suggesting that
it be added as a separate object type.  I think that many of the
extra metadata could be usefully added as other object types.
These can be optional and/or added after the fact.

> --- David A. Wheeler
> 

-- 
Kris Shannon <kris.shannon.kernel@gmail.com>
