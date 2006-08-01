From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: A few more fixups to gitweb
Date: Tue, 1 Aug 2006 13:10:00 -0700 (PDT)
Message-ID: <20060801201000.96106.qmail@web31809.mail.mud.yahoo.com>
References: <7vzmep2icr.fsf_-_@assigned-by-dhcp.cox.net>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Martin Langhoff <martin.langhoff@gmail.com>,
	Matthias Lederhofer <matled@gmx.net>
X-From: git-owner@vger.kernel.org Tue Aug 01 22:10:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G80Z8-0005y8-EA
	for gcvg-git@gmane.org; Tue, 01 Aug 2006 22:10:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932519AbWHAUKF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 Aug 2006 16:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932477AbWHAUKF
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Aug 2006 16:10:05 -0400
Received: from web31809.mail.mud.yahoo.com ([68.142.207.72]:3920 "HELO
	web31809.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932519AbWHAUKB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Aug 2006 16:10:01 -0400
Received: (qmail 96108 invoked by uid 60001); 1 Aug 2006 20:10:00 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=KHtQ6cKjyCxAstCpRov95oYTDmMAvHRWFQlxo+IZS+MhWU9DSQnzS6qBOsPuakyOefhfCvi3tH/t7cbqAmaEtamj9ZzajfJC6MEdk0wDnvaq4kns3RBVQjBZt23mqwy4aD8f9OwzEuw7AINkSRwfOzjtxfSjdFmiaGqa6uqOdHI=  ;
Received: from [64.215.88.90] by web31809.mail.mud.yahoo.com via HTTP; Tue, 01 Aug 2006 13:10:00 PDT
To: Junio C Hamano <junkio@cox.net>, Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <7vzmep2icr.fsf_-_@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24611>

--- Junio C Hamano <junkio@cox.net> wrote:
> One thing to note.  Please make sure that you do not see
> anything in Apache error log after you make your changes.  I do
> not remember the details but kernel.org folks were very unhappy
> earlier when gitweb spewed stuff into the error log, and if I
> recall correctly things that output to the error stream were not
> friendly to the http-server cache for some reason.

I've been meaning to mention this as well.  Gitweb patches,
especially recent ones, need more (thorough) testing, before
posted to the list for inclusion.

    Luben
