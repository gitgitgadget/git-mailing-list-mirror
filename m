From: Pavel Roskin <proski@gnu.org>
Subject: Re: [RFC] qgit with tabs
Date: Sat, 13 May 2006 07:07:26 -0400
Message-ID: <20060513070726.qa5ssccws80go044@webmail.spamcop.net>
References: <e5bfff550605130344n75e3e55eq533c49fc2a4f5483@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 13 13:07:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FeryN-0003vZ-2e
	for gcvg-git@gmane.org; Sat, 13 May 2006 13:07:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932328AbWEMLHa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 May 2006 07:07:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932339AbWEMLHa
	(ORCPT <rfc822;git-outgoing>); Sat, 13 May 2006 07:07:30 -0400
Received: from mailgate.cesmail.net ([216.154.195.36]:29913 "HELO
	mailgate.cesmail.net") by vger.kernel.org with SMTP id S932328AbWEMLH3
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 May 2006 07:07:29 -0400
Received: (qmail 10574 invoked from network); 13 May 2006 11:07:26 -0000
Received: from unknown (HELO gamma.cesmail.net) (192.168.1.20)
  by mailgate.cesmail.net with SMTP; 13 May 2006 11:07:26 -0000
Received: (qmail 25299 invoked by uid 99); 13 May 2006 11:07:26 -0000
Received: from pool-68-163-58-250.phil.east.verizon.net
	(pool-68-163-58-250.phil.east.verizon.net [68.163.58.250]) by
	webmail.spamcop.net (Horde) with HTTP for <proski@spamcop.net@cesmail.net>;
	Sat, 13 May 2006 07:07:26 -0400
To: Marco Costalba <mcostalba@gmail.com>
In-Reply-To: <e5bfff550605130344n75e3e55eq533c49fc2a4f5483@mail.gmail.com>
Content-Disposition: inline
User-Agent: Internet Messaging Program (IMP) 4.0-cvs
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19931>

Hello, Marco!

Quoting Marco Costalba <mcostalba@gmail.com>:

>    I have pushed some patches that add tabs to qgit UI.

That's _really_ appreciated.

> I don't expect a new release any time soon, but I am interested to
> hear comments, especially on the usability front, so to be able to
> steer new development in advance.

Just one thing for now.  Double click on a file on the "rev list" tab should
show the patch (what Ctrl-P would do), not the whole file.  That would be more
compatible with gitk, and it's what I normally need if I just browse the latest
changes in the rev list.

> With new UI I found myself more and more using keyboard bindings
> instead of mouse:
>
> - r, p, f to switch to revisions list, patch and file views respectively
>
> - t to toggle tree view
>
> - s to toggle split view (very useful IMHO)

The later is very useful, but a bit hard to discover without checking the menu. 
Maybe it should be a button in the toolbar.

> NOTE:
> Due to some repacking on a dumb host probably you need to re-clone:

I don't think re-clone should be needed.  I didn't re-clone, yet I could update.

On the other hand, that host sometimes returns something that crashes
git-http-fetch.  Sorry, no time to debug it right now.  I guess it returns
error messages in HTML without reporting error 404, but git-http-fetch should
be more robust anyway.

--
Regards,
Pavel Roskin
