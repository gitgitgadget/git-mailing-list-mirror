From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: how to omit rename file when commit
Date: Mon, 19 Jan 2009 03:01:47 -0800 (PST)
Message-ID: <m3vdsby2y4.fsf@localhost.localdomain>
References: <1976ea660901190113l5407f108lff8f37d9a8331f58@mail.gmail.com>
	<7v63kbr6zc.fsf@gitster.siamese.dyndns.org>
	<1976ea660901190135k71087673p85e995878e539a8f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Frank Li" <lznuaa@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 19 12:03:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOruT-00074I-Up
	for gcvg-git-2@gmane.org; Mon, 19 Jan 2009 12:03:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758051AbZASLBw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jan 2009 06:01:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757039AbZASLBv
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jan 2009 06:01:51 -0500
Received: from mail-gx0-f21.google.com ([209.85.217.21]:43450 "EHLO
	mail-gx0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755231AbZASLBu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jan 2009 06:01:50 -0500
Received: by gxk14 with SMTP id 14so2421611gxk.13
        for <git@vger.kernel.org>; Mon, 19 Jan 2009 03:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=BU6lxx1l0z80UhsXxqgnYA6afHQMuh+127OekX6JH0k=;
        b=aIe1wc9UOdmLFr8VahulZEOyKgnZ/BQfJWpdEJKZTqKtqfbIVtnmUHdtQjLlnyZcSC
         XlbdWB4z8S00Nt4HHYXegenyTbwUFbhUZAgR7ZL4N49QrutlIU7TCM74CBte1nWdVKLu
         47DeH+nnE9tz6A+ChHtCNA/uxA9Gd01WMuHtI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=F4Y+UmY3njaPalidXoZfCAbFv9CXJpqMpzxPhAPuE5IumL6+ltkI0MQ8vXhoP0IDM0
         TwrHscBcZdA+z+AREnwLWV364m3Xe/1V4jFOQuTXHP4ipS8fYOYtRdC4ctqYx6CKFEZt
         NIpOE306IfcWds/u94iPv3wli3pVLqnOpwQDo=
Received: by 10.150.182.16 with SMTP id e16mr7432233ybf.144.1232362909158;
        Mon, 19 Jan 2009 03:01:49 -0800 (PST)
Received: from localhost.localdomain (abwa83.neoplus.adsl.tpnet.pl [83.8.224.83])
        by mx.google.com with ESMTPS id t26sm9509235ele.15.2009.01.19.03.01.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 19 Jan 2009 03:01:47 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n0JB1hH4022786;
	Mon, 19 Jan 2009 12:01:43 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n0JB1exs022782;
	Mon, 19 Jan 2009 12:01:40 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1976ea660901190135k71087673p85e995878e539a8f@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106344>

"Frank Li" <lznuaa@gmail.com> writes:

> For example:
> there are 2 file. a.c and e.c
> I modify e.c.
> and git mv a.c b.c
> 
> git update-index e.c
> 
> I just want to commit e.c and don't commit rename(a.c -> b.c)

The simplest way (but I'm not sure if it is what you want) would be

  $ git commit e.c

-- 
Jakub Narebski
Poland
ShadeHawk on #git
