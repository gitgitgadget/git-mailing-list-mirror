From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] use "git init-db" in tests
Date: Fri, 9 Dec 2005 08:36:33 +0100
Message-ID: <81b0412b0512082336i674932bapd631d559e80cad79@mail.gmail.com>
References: <20051208202555.GA3046@steel.home>
	 <7vu0dje2oi.fsf@assigned-by-dhcp.cox.net>
	 <20051208210251.GB19423@steel.home>
	 <7v7jafcmev.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 09 08:37:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ekco9-0007gI-4o
	for gcvg-git@gmane.org; Fri, 09 Dec 2005 08:36:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750977AbVLIHgf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Dec 2005 02:36:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750718AbVLIHgf
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Dec 2005 02:36:35 -0500
Received: from nproxy.gmail.com ([64.233.182.192]:6289 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932408AbVLIHge convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 9 Dec 2005 02:36:34 -0500
Received: by nproxy.gmail.com with SMTP id y25so311374nfb
        for <git@vger.kernel.org>; Thu, 08 Dec 2005 23:36:33 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=R+iS7ijjgq9Fwc0QzZ7vmJ1TxpUN+BZxkJdvDUsRY8kiA5+E7KZGYQ2gOr0Vk2N1NI3aHGmRVR69wiAaujmf9a6BgCCsMsH4OuA53CFj2n5HSd9y9KAESefEruHVsPw5N3MTZuA9bwRLFmbBcUZHYmlyDrNwiXpPCQ8qzK91cUk=
Received: by 10.49.5.7 with SMTP id h7mr391163nfi;
        Thu, 08 Dec 2005 23:36:33 -0800 (PST)
Received: by 10.48.248.18 with HTTP; Thu, 8 Dec 2005 23:36:33 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v7jafcmev.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13417>

On 12/8/05, Junio C Hamano <junkio@cox.net> wrote:
> > You do miss something. glibc will happily continue lookup if
> > git-init-db in the top of the build directory is not executable, and
> > it will take the next one it finds (and people _will_ have git-init-db
> > in PATH).
>
> And the reason git-init-db we just built is not executable
> is...?

An accident? Like a filesystem not supporting executable permission?
What is the reason to report success from the test run in that conditions?
