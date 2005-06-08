From: Jon Seymour <jon.seymour@gmail.com>
Subject: [WITHDRAW PATCH] Add support for --wrt-author, --author and --exclude-author switches to git-rev-list
Date: Thu, 9 Jun 2005 02:36:06 +1000
Message-ID: <2cfc4032050608093648eceeff@mail.gmail.com>
References: <20050607091523.14051.qmail@blackcubes.dyndns.org>
	 <20050607094947.GC2676@pasky.ji.cz>
	 <2cfc403205060702594da21fb1@mail.gmail.com>
	 <20050608085834.GC7916@pasky.ji.cz>
	 <2cfc403205060802315ba2433a@mail.gmail.com>
	 <2cfc40320506080414303d6d7b@mail.gmail.com>
Reply-To: jon@blackcubes.dyndns.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Wed Jun 08 18:47:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dg3gB-0006yv-9V
	for gcvg-git@gmane.org; Wed, 08 Jun 2005 18:45:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261387AbVFHQsb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Jun 2005 12:48:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261361AbVFHQk1
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Jun 2005 12:40:27 -0400
Received: from rproxy.gmail.com ([64.233.170.193]:49372 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261406AbVFHQgJ convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 8 Jun 2005 12:36:09 -0400
Received: by rproxy.gmail.com with SMTP id i8so323804rne
        for <git@vger.kernel.org>; Wed, 08 Jun 2005 09:36:07 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=l/q6phrXCKKUMcOUphEqPsxAZAaoX06/ACkMJJ1oQL5/mQ33TcIVLEciDtLKzcNPvfZ9xrQB9eGONZykLaNZ1VG+KV/8uo9tuiVXNcmC6rX9N/ghlAI7jjKNHxVbC39CjRQETqv5SpOUD5psLDDZWPzmrjXStb7BHhH1nqLSPpw=
Received: by 10.38.75.73 with SMTP id x73mr337764rna;
        Wed, 08 Jun 2005 09:36:06 -0700 (PDT)
Received: by 10.38.104.42 with HTTP; Wed, 8 Jun 2005 09:36:06 -0700 (PDT)
To: git@vger.kernel.org
In-Reply-To: <2cfc40320506080414303d6d7b@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

G'day Linus,

I'd like to  withdraw this patch until the --merge-order bug fix of my
earlier post is applied. The patch as it stands won't operate
correctly once that fix is applied, so I'll have to modify it. Also, I
want to rename the --exclude-author switch to --prune-at-author.

Regards,

jon.
