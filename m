From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Wishlist for a bundle-only transport mode
Date: Wed, 21 Nov 2007 18:52:03 +0100
Message-ID: <200711211852.03887.jnareb@gmail.com>
References: <8aa486160711210654p357ccd87i4809e0cda9471303@mail.gmail.com> <200711211811.34391.jnareb@gmail.com> <Pine.LNX.4.64.0711211719330.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Santi =?iso-8859-1?q?B=E9jar?= <sbejar@gmail.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Nov 21 18:56:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iuto5-0004mp-Qq
	for gcvg-git-2@gmane.org; Wed, 21 Nov 2007 18:56:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751958AbXKURwL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2007 12:52:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751892AbXKURwK
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 12:52:10 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:39932 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750702AbXKURwI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2007 12:52:08 -0500
Received: by nf-out-0910.google.com with SMTP id g13so2193181nfb
        for <git@vger.kernel.org>; Wed, 21 Nov 2007 09:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=PD4tKnhK+JS6xQ5uq8JNWCnDsYuDOcvg45FKDhIP4gc=;
        b=MiS5z8dr/w01SQlBmSDcU/5vZk1wcOrwAb7Rnd9uJiyZVnRcxdnIwIPO1nuTiabr3sZ/8j8FFR79c0hYS9BgtSL/2o5619tqHnZsWwY3ovpmxNetAoHNXc/t4iWwGUva0f0+boG9VJvFoPE+ScC/f823pEf1O3pQiEDaWVPnx+o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=lf7Y6ukohtG0nw33YcZFbXsIuxzKJd/Pb4vuCc5wufB36b+lA+lGUJhEKEAp7SaAQhU9PYSSmvKbIAUD7+BfekkE5ttgcSGaxTTLtKrfO0mv8YqDAtTwbOTidWgkCDSYwj0rBhUhYjwQTNiIlNWeN+j4W7qXTLZtvFbwpwgF8wI=
Received: by 10.86.90.2 with SMTP id n2mr7528769fgb.1195667527379;
        Wed, 21 Nov 2007 09:52:07 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.255.19])
        by mx.google.com with ESMTPS id e20sm10141854fga.2007.11.21.09.52.04
        (version=SSLv3 cipher=OTHER);
        Wed, 21 Nov 2007 09:52:05 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <Pine.LNX.4.64.0711211719330.27959@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65688>

On Wed, 21 Nov 2007, Johannes Schindelin wrote:
> On Wed, 21 Nov 2007, Jakub Narebski wrote:
>> Johannes Schindelin wrote:
>>> On Wed, 21 Nov 2007, Jakub Narebski wrote:
>>>
>>>> That has the disadvantage of pushing to bundle when you make an error 
>>>> in the lastpart of path to existing repository.
>>> 
>>> As I wrote in another reply, I would not allow overwriting an existing 
>>> file.
>> 
>>> Specifying a non-existing file should be good enough.
>> 
>> What I meant here that if you do "git push /some/path/to/rpeo.git", with 
>> mistake in the last part of path to repository, you would end up with a 
>> bundle, and you would have to really watch what happened to catch the 
>> error.
> 
> I use tab completion all the time, so this would not happen to me.  IMHO 
> that is a lesser issue than to introduce a "protocol".

When I copy'n'paste pathname I sometimes catch return / linefeed in
the middle, ending with incorect pathname (which would create bundle).
Tab completon is not always solution (tab completion can be slow,
or nonexistent).

[cut]

But I agree that because "git create bundle" needs refspecs _and revlist_,
while "git push" gets only refspecs because it calculates revlist it would
be better to have to use "git bundle create" to create bundle.

Contrary to "git clone <bundle>" which should just work IMHO.

-- 
Jakub Narebski
Poland
