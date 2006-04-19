From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: [RFC] get_sha1() shorthands for blob/tree objects
Date: Wed, 19 Apr 2006 12:14:27 +1200
Message-ID: <46a038f90604181714j6fce1867wc17952d898f8e7ae@mail.gmail.com>
References: <Pine.LNX.4.64.0604181627101.3701@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 19 02:14:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FW0L1-00011O-Rg
	for gcvg-git@gmane.org; Wed, 19 Apr 2006 02:14:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750780AbWDSAO2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 18 Apr 2006 20:14:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750804AbWDSAO2
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Apr 2006 20:14:28 -0400
Received: from wproxy.gmail.com ([64.233.184.234]:16097 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750780AbWDSAO2 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Apr 2006 20:14:28 -0400
Received: by wproxy.gmail.com with SMTP id i11so55760wra
        for <git@vger.kernel.org>; Tue, 18 Apr 2006 17:14:27 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RuDQrLAjgF6ND6dccvcuxmVLvH+35jsjnQ++aLTh4ZlrnijKxVy5L8S8o6sigeSrBfB4L8wG+QlzbubsqlFof2hWYdiejEO7wWN8GzI63JxtDBMeSTpTpzeF/WlVD6+pYWW05jO4eU6wFuACZdhXYg1o42WOapnRJktdhsLqxdU=
Received: by 10.54.120.8 with SMTP id s8mr3099515wrc;
        Tue, 18 Apr 2006 17:14:27 -0700 (PDT)
Received: by 10.54.127.4 with HTTP; Tue, 18 Apr 2006 17:14:27 -0700 (PDT)
To: "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0604181627101.3701@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18888>

On 4/19/06, Linus Torvalds <torvalds@osdl.org> wrote:

>   What do people think? Have you ever wanted to
>   access individual files in some random revision? Do you think this is
>   useful?

Definitely, I've several times had to go through contortions to do
this easily, and I've ended up turning to gitweb often to quickly see
the state of a file at a given revision.

> With this, you can do something like
>
>         git cat-file blob v1.2.4:Makefile
>
> to get the contents of "Makefile" at revision v1.2.4.
>
> Now, this isn't necessarily something you really need all that often, but
> the concept itself is actually pretty powerful. We could, for example,
> allow things like
>
>         git diff v0.99.6:git-commit-script..v1.3.0:git-commit.sh

These two examples are more than enough -- I buy ;-)


martin
