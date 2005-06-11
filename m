From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: do people use the 'git' command?
Date: Sat, 11 Jun 2005 17:20:46 +1000
Message-ID: <2cfc403205061100204cd43334@mail.gmail.com>
References: <E1DgodI-0003ov-Fl@highlab.com>
	 <7vy89h4m9r.fsf@assigned-by-dhcp.cox.net>
	 <E1DgyW0-0004PE-Ct@highlab.com>
	 <2cfc403205061023346c03a25b@mail.gmail.com>
	 <7vpsutz88z.fsf@assigned-by-dhcp.cox.net>
Reply-To: jon@blackcubes.dyndns.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Sebastian Kuzminsky <seb@highlab.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 11 09:16:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dh0EP-0006wO-35
	for gcvg-git@gmane.org; Sat, 11 Jun 2005 09:16:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261631AbVFKHU4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Jun 2005 03:20:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261634AbVFKHU4
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Jun 2005 03:20:56 -0400
Received: from rproxy.gmail.com ([64.233.170.195]:28472 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261631AbVFKHUs convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Jun 2005 03:20:48 -0400
Received: by rproxy.gmail.com with SMTP id i8so399748rne
        for <git@vger.kernel.org>; Sat, 11 Jun 2005 00:20:46 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PWNzr7mEYTwIybFh/ilrK1bQuyPs4XSDzCBVNhmItl71Zo+2wGW7GGgYMI0+RemVj6pwI+HmRZ/NdvGIUyS3fKZsI+pW+dadW2ozegthteW/PLH5I1vo6QgXoUycm8zMiAteogtmOmFOlGvh3WL0RtHEIPEvzHHlC5RukS0tcI4=
Received: by 10.39.3.44 with SMTP id f44mr43583rni;
        Sat, 11 Jun 2005 00:20:46 -0700 (PDT)
Received: by 10.38.104.42 with HTTP; Sat, 11 Jun 2005 00:20:46 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vpsutz88z.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On 6/11/05, Junio C Hamano <junkio@cox.net> wrote:
> >>>>> "JS" == Jon Seymour <jon.seymour@gmail.com> writes:
> 
> JS> Sebastian,
> JS> What is the justification for removing it?
> 
> JS> As it stands, git serves a useful function in that it provides a
> JS> single point through which access to all git-*-scripts is channeled,
> JS> yet still allows each script to be maintained as a separate entity,
> JS> coherent entity.
> 
> If I understand him correctly, Sebastian's point was that it
> channels only to git-*-scripts without channelling to any of the
> git-* binaries.
> 

What about generalizing it a little, so that:

     git word

calls:

    git-word-script if it exists and is executable in the path

or, if not,

    git-word if it exists and is executable in the path.

Then:

    git update-cache 

would work as expected.

jon.
