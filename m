From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [RFD] Ignore rules
Date: Sun, 15 May 2005 11:11:08 +1000
Message-ID: <2cfc4032050514181127c02e43@mail.gmail.com>
References: <4283CAF8.3050304@dgreaves.com>
	 <20050513231229.GI32232@pasky.ji.cz> <4285B6A8.4080309@dgreaves.com>
	 <7vy8ai2nb6.fsf@assigned-by-dhcp.cox.net>
	 <20050514142421.GG3905@pasky.ji.cz> <42861584.6020601@dgreaves.com>
	 <20050514153027.GN3905@pasky.ji.cz>
	 <7vsm0py8vz.fsf@assigned-by-dhcp.cox.net>
Reply-To: jon@blackcubes.dyndns.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Petr Baudis <pasky@ucw.cz>, David Greaves <david@dgreaves.com>,
	torvalds@osdl.org, GIT Mailing Lists <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 15 03:11:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DX7f0-0004UY-H5
	for gcvg-git@gmane.org; Sun, 15 May 2005 03:11:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261525AbVEOBLN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 May 2005 21:11:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261526AbVEOBLN
	(ORCPT <rfc822;git-outgoing>); Sat, 14 May 2005 21:11:13 -0400
Received: from rproxy.gmail.com ([64.233.170.198]:52629 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261525AbVEOBLI convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 May 2005 21:11:08 -0400
Received: by rproxy.gmail.com with SMTP id i8so363098rne
        for <git@vger.kernel.org>; Sat, 14 May 2005 18:11:08 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=j0BF1DJyiApIH4eZc5h7AIWqfjMg7tQxkQeN57tHavHc2gi/J3XxGcQwMQ4zaf51+s1u/i0IpyXrxE9MmHEEXb1KCtu0Fb2gwfM9kECsIIFOZ6WWxpijo9Z4oVsd8T5TS0Hq+SJoy62J+fi5Yhctm1+yBj8O9mgJUfo/YjaTHkU=
Received: by 10.38.104.76 with SMTP id b76mr1580901rnc;
        Sat, 14 May 2005 18:11:08 -0700 (PDT)
Received: by 10.38.104.42 with HTTP; Sat, 14 May 2005 18:11:08 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vsm0py8vz.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Is there value in:

a. pushing the ignore logic into the core git tools such as git-ls-files

b. including the current ignore .* rule as a default ignore rule that
can be overridden by a .gitignore file


jon.
-- 
homepage: http://www.zeta.org.au/~jon/
blog: http://orwelliantremors.blogspot.com/
