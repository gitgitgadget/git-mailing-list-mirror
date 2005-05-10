From: Morten Welinder <mwelinder@gmail.com>
Subject: Re: "git-checkout-cache -f -a" failure
Date: Mon, 9 May 2005 23:04:46 -0400
Message-ID: <118833cc05050920045204db03@mail.gmail.com>
References: <118833cc05050911255e601fc@mail.gmail.com>
	 <7v64xru83t.fsf@assigned-by-dhcp.cox.net>
Reply-To: Morten Welinder <mwelinder@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: GIT Mailing List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Tue May 10 04:57:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVKw7-0000b3-6f
	for gcvg-git@gmane.org; Tue, 10 May 2005 04:57:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261470AbVEJDEr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 May 2005 23:04:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261539AbVEJDEr
	(ORCPT <rfc822;git-outgoing>); Mon, 9 May 2005 23:04:47 -0400
Received: from rproxy.gmail.com ([64.233.170.196]:65115 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261470AbVEJDEq convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 9 May 2005 23:04:46 -0400
Received: by rproxy.gmail.com with SMTP id a41so892389rng
        for <git@vger.kernel.org>; Mon, 09 May 2005 20:04:46 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NY5Zw+BbpZN0sFm3G/uejF0fK4GFlGDVkPFKBpx85947ee2C/uJVkFrYEpAZZqdLs13NFc5nhyAkfOAGBXgEl5X9tHXLrEB3qeZWEmhtxiQXW9d4w44QuSpug4SyNjiK1EW0Qkx29FyM3rjxlL6VVw0lYaWLCYEUcOC0MGBr2Lw=
Received: by 10.38.76.80 with SMTP id y80mr1816603rna;
        Mon, 09 May 2005 20:04:46 -0700 (PDT)
Received: by 10.38.76.77 with HTTP; Mon, 9 May 2005 20:04:46 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v64xru83t.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

> Changing files vs directories _is_ a big change and happens
> rarely in practice; I think the current behaviour is
> justified---it makes the user take notice and the user _should_
> take notice.

File vs. directory was just the easiest way to demonstrate.  In the presense
of symlinks I am not sure you will always get a warning.  It'll be more of a
silent file-corrupting failure kind of thing.  (Somewhat worse if yyy points
to /your/home/.ssh and zzz is "authorized_keys".)

Morten
