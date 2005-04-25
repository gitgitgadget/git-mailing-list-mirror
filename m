From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH GIT 0.6] make use of register variables & size_t
Date: Mon, 25 Apr 2005 12:38:20 -0500
Message-ID: <d120d500050425103822c3c9a1@mail.gmail.com>
References: <426CD1F1.2010101@tiscali.de>
	 <Pine.LNX.4.58.0504250751330.18901@ppc970.osdl.org>
	 <426D21FE.3040401@tiscali.de>
Reply-To: dtor_core@ameritech.net
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 25 19:39:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQ7X7-000199-By
	for gcvg-git@gmane.org; Mon, 25 Apr 2005 19:38:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262697AbVDYRmd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Apr 2005 13:42:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262675AbVDYRij
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Apr 2005 13:38:39 -0400
Received: from rproxy.gmail.com ([64.233.170.194]:27286 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262695AbVDYRiW convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2005 13:38:22 -0400
Received: by rproxy.gmail.com with SMTP id a41so960307rng
        for <git@vger.kernel.org>; Mon, 25 Apr 2005 10:38:22 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=elLfoe3oCwxDUgDl8M1TsaPKcaKAiisQFeFgUWHN/Y37KI/sqhNGkRzeHgQPZeleCqs7Z35pmZVPis0SA9V+lc4cDkwMRz2c4r935o/k1hxjqwpXI/mrWg9Y1gAIkUIbetpR4FjWDtpKJMK1ug8TmSGXgX9Sw6+ngulM8dyt4o4=
Received: by 10.38.98.13 with SMTP id v13mr1240573rnb;
        Mon, 25 Apr 2005 10:38:21 -0700 (PDT)
Received: by 10.38.24.62 with HTTP; Mon, 25 Apr 2005 10:38:20 -0700 (PDT)
To: Matthias-Christian Ott <matthias.christian@tiscali.de>
In-Reply-To: <426D21FE.3040401@tiscali.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On 4/25/05, Matthias-Christian Ott <matthias.christian@tiscali.de> wrote:
> "register" and "auto" variables aren't relicts of the 60's,  they're a
> part of the ISO-C 99 standard, I'm following, "man".
...
> [2] Erik de Castro Lopo, Peter Aitken, Bradley L. Jones: Teach Yourself
> C for Linux Programming in 21 Days; SAMS Publishing; 1999

It must be "Teach yourself C for Gentoo Linux Programming..." "...
Gentoo rocks! I changed all my variables to 'register' and now my
kernel runs 3x times faster than RehHat one" :)

Sorry, couldn't resist...

-- 
Dmitry
