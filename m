From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: [PATCH] Add -k kill keyword expansion option to git-cvsimport
Date: Mon, 15 Aug 2005 23:20:16 +1200
Message-ID: <46a038f9050815042036616b08@mail.gmail.com>
References: <46a038f9050814235140877be7@mail.gmail.com>
	 <7vk6in65dp.fsf@assigned-by-dhcp.cox.net>
	 <46a038f90508150037f128d6@mail.gmail.com>
	 <7vacjj3968.fsf@assigned-by-dhcp.cox.net>
	 <46a038f905081501301bd9a801@mail.gmail.com>
	 <7vr7cv1t89.fsf@assigned-by-dhcp.cox.net>
	 <46a038f9050815020511574e3d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 15 13:21:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E4d0x-0002LQ-0O
	for gcvg-git@gmane.org; Mon, 15 Aug 2005 13:20:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932666AbVHOLUS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Aug 2005 07:20:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932673AbVHOLUS
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Aug 2005 07:20:18 -0400
Received: from rproxy.gmail.com ([64.233.170.195]:64126 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932666AbVHOLUR convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2005 07:20:17 -0400
Received: by rproxy.gmail.com with SMTP id a36so959835rnf
        for <git@vger.kernel.org>; Mon, 15 Aug 2005 04:20:16 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FQ+hdtVkb2sCD5XrjoVJ2yAeXXXkjefxOspR5tiBC+wjYfJ/8MQYmIon3xxwSm33bi3trjFwwoYiZD85zuYDGeXvpZeUBIEKwx2Fa0zpjMqVUIYpu2odOE59UKV3ld7ZT17bHirQe/J2j5g0M8oDy43ruT37d7wUcOBaYVhGrzQ=
Received: by 10.38.75.6 with SMTP id x6mr1924190rna;
        Mon, 15 Aug 2005 04:20:16 -0700 (PDT)
Received: by 10.38.101.8 with HTTP; Mon, 15 Aug 2005 04:20:16 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <46a038f9050815020511574e3d@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On 8/15/05, Martin Langhoff <martin.langhoff@gmail.com> wrote:
> I think the other modes are relevant in different scenarios. -kv is
> only meaningful as file mode over the life of the file in the repo.
> -kk is only meaningful when calling cvs update with -j -j parameters
> or cvs diff, and is effectively a synonim of -ko.
> 
> In the position we are, getting file/revisions out of a repo, there
> are 2 possible files we can get: the one that you'll get with -kkv and
> the one you'll get with -ko/-kb. -kb/-ko should give us exactly the
> same file, modulo bugs.

After a few more trial runs, it ends up being that -kb and -ko drop
the ball in some instances, and the most reliable flag to send is -kk.
Don't ask me how or why.

So this patch is obsolete too. 



martin
