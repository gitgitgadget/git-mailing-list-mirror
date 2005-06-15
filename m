From: Adam Mercer <ramercer@gmail.com>
Subject: Re: Converting SVN repository to git
Date: Wed, 15 Jun 2005 23:02:15 +0100
Message-ID: <799406d605061515024f8d1fd6@mail.gmail.com>
References: <20050615184720.GF31997@artsapartment.org>
Reply-To: Adam Mercer <ramercer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Wed Jun 15 23:58:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Difty-00019T-Qd
	for gcvg-git@gmane.org; Wed, 15 Jun 2005 23:58:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261636AbVFOWDD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Jun 2005 18:03:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261633AbVFOWDC
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Jun 2005 18:03:02 -0400
Received: from zproxy.gmail.com ([64.233.162.201]:30494 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261668AbVFOWCQ convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jun 2005 18:02:16 -0400
Received: by zproxy.gmail.com with SMTP id 16so69658nzp
        for <git@vger.kernel.org>; Wed, 15 Jun 2005 15:02:16 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=M2odxZgolEe4maofi9WZw1Wnn5gQ6fHSPT1trvinakdWX+gIE2kNJ1DqSpulBJdVMgTdgf09c0/XU6X8z8iAe70p8r3fFjyBDgIDhWIvNZW+uLqw2j8Px3CYE0fW27LUOdAKwXqzprYecjdjcjQram6kuRUn4+pCAFqZe3yu6oY=
Received: by 10.36.89.14 with SMTP id m14mr111999nzb;
        Wed, 15 Jun 2005 15:02:15 -0700 (PDT)
Received: by 10.36.109.1 with HTTP; Wed, 15 Jun 2005 15:02:15 -0700 (PDT)
To: git@vger.kernel.org
In-Reply-To: <20050615184720.GF31997@artsapartment.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On 15/06/05, Art Haas <ahaas@airmail.net> wrote:

> The utilities for converting CVS repositories to git repos have become
> part of the standard git package, and hopefully they'll be used to
> convert many CVS based projects to git. I've not seen anything, though,
> on switching Subversion repositories to git. Has there been any public
> activity in writing a tool/script to do this? Perhaps some offline
> discussion about doing this?

You could use something like svn2cvs (http://svn2cvs.tigris.org) and
then use the cvs2git tools.

Cheers

Adam
