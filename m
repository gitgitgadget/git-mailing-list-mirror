From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: wit 0.0.3 - a web interface for git available
Date: Fri, 22 Apr 2005 08:33:13 +1000
Message-ID: <2cfc403205042115335b67f425@mail.gmail.com>
References: <1113956951.3309.22.camel@localhost>
	 <20050420041828.GA15391@kroah.com>
	 <20050420094253.GB29910@infradead.org>
	 <20050421012827.GA13795@vrfy.org>
Reply-To: jon@zeta.org.au
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Christoph Hellwig <hch@infradead.org>, Greg KH <greg@kroah.com>,
	Christian Meder <chris@absolutegiganten.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 22 00:31:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOkCg-0008Dr-AZ
	for gcvg-git@gmane.org; Fri, 22 Apr 2005 00:31:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261583AbVDUWfX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 18:35:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261618AbVDUWdx
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 18:33:53 -0400
Received: from rproxy.gmail.com ([64.233.170.203]:2251 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261573AbVDUWdR convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2005 18:33:17 -0400
Received: by rproxy.gmail.com with SMTP id i8so518390rne
        for <git@vger.kernel.org>; Thu, 21 Apr 2005 15:33:13 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rCU0GgDkRlY0dvX2Qhn++zsyFWHf6SNi+rAXW5q70DPqechcpwTuMf1BOkF0Fx9zwUGtBXAShgTknyyQoVxsjUaWbvFvgospU+iZAJ2nxZS2rxuPQ8l0FcRky3MIau4bvdT/Ame7luusqup8j1Q11LfjMzVWl6gzx7ucg5LWAI4=
Received: by 10.38.11.1 with SMTP id 1mr2752609rnk;
        Thu, 21 Apr 2005 15:33:13 -0700 (PDT)
Received: by 10.38.104.32 with HTTP; Thu, 21 Apr 2005 15:33:13 -0700 (PDT)
To: Kay Sievers <kay.sievers@vrfy.org>
In-Reply-To: <20050421012827.GA13795@vrfy.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On 4/21/05, Kay Sievers <kay.sievers@vrfy.org> wrote:
> On Wed, Apr 20, 2005 at 10:42:53AM +0100, Christoph Hellwig wrote:
> 
> It's working now:
>   http://ehlo.org/~kay/gitweb.pl
> 

Kay + Christian + Ken,

That looks really great!.

One suggestion: when drilling down through the tree it would be nice
if the context of the parents could be dragged along too. So, for
example, when displaying the BLOB, you could display its name because
you have kept enough context around to allow that.

This would also allow you to extend the functionality so that when you
are at the BLOB level you could navigate to a history of changes to
just that BLOB, at least from the point of  view of the commit that
got you there.

Also, have you considered generating pure XML from the database and
relying on XSLT (either at the server, or preferably at the client -
they all do it well these days!) to do the HTML rendering?

jon.
