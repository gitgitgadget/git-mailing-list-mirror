From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH] gitweb: "raw" links to blobs at HEAD
Date: Tue, 26 Sep 2006 13:20:13 -0700 (PDT)
Message-ID: <20060926202013.10579.qmail@web31811.mail.mud.yahoo.com>
References: <efaq3h$e65$2@sea.gmane.org>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Tue Sep 26 22:21:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSJPv-0007LZ-1w
	for gcvg-git@gmane.org; Tue, 26 Sep 2006 22:20:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932296AbWIZUUU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Sep 2006 16:20:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932288AbWIZUUU
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Sep 2006 16:20:20 -0400
Received: from web31811.mail.mud.yahoo.com ([68.142.207.74]:64341 "HELO
	web31811.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932285AbWIZUUS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Sep 2006 16:20:18 -0400
Received: (qmail 10581 invoked by uid 60001); 26 Sep 2006 20:20:14 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=s66FIBy6Z9AkjXj+gDhayJrOC289YGnA43IT1B5aAZgNwVVXl8ijt+J0H9lhb1uC+gdFb+fqJYdJSHmg6kWuxlhwE64ojAAbqF1JSyhqkxyQPaKl6pSvVrCZjnGf/Snt20ZiOu/oHzYquRDfTnD5dqGwO4uG9iqIz0dJGs1ofDU=  ;
Received: from [64.215.88.90] by web31811.mail.mud.yahoo.com via HTTP; Tue, 26 Sep 2006 13:20:13 PDT
To: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
In-Reply-To: <efaq3h$e65$2@sea.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27816>

--- Jakub Narebski <jnareb@gmail.com> wrote:
> Luben Tuikov wrote:
> 
> > Currently there is no HTML interface which references (or
> > can be externally referenced) to yield a _binary_ blob at
> > HEAD.  There is one for non-binary blobs, but none for
> > binary ones.
> 
> You can in the same number of steps. First go to _tree_
> at head, then click on "raw" link.

Jakub,

For binary only files, there is no HTML interface to refer
to, such that, hb=HEAD for _binary_ only files.  Unless of course
one types that on the URL line manually.

That is, I'd like to externally reference binary only blobs
at "HEAD", s.t. no matter _when_ the reference is used, it would
refer to the latest "version" of that file.

E.g. a PDF spec file.

My recent patches on the subject enable this capability.

    Luben

> It's true that decision that binary files are automatically
> redirected to "plain" ("raw") format, so they don't have "html"
> output caused that there is no link for binary blob at head.
> But I don't think that changing "raw" link to link to HEAD
> version, while all other links are to current version is
> a good idea...
> -- 
> Jakub Narebski
> Warsaw, Poland
> ShadeHawk on #git
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
