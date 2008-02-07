From: "Anand Kumria" <wildfire@progsoc.org>
Subject: Re: git-fetch in 1.5.4 fails versus 1.5.3.8
Date: Thu, 7 Feb 2008 21:36:32 +0000
Message-ID: <971f65790802071336k2383b408k66b3cebfb4e1da13@mail.gmail.com>
References: <pan.2008.02.04.18.25.26@progsoc.org>
	 <20080205050741.GA4624@coredump.intra.peff.net>
	 <pan.2008.02.06.21.56.35@progsoc.org>
	 <20080207042332.GA7632@sigill.intra.peff.net>
	 <pan.2008.02.07.10.15.05@progsoc.org>
	 <20080207142322.GC18497@mail-vs.djpig.de>
	 <alpine.LFD.1.00.0802071039010.2883@woody.linux-foundation.org>
	 <20080207201445.GD18497@mail-vs.djpig.de>
	 <alpine.LFD.1.00.0802071246320.2896@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Frank Lichtenheld" <frank@lichtenheld.de>, git@vger.kernel.org
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Feb 07 22:37:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNERF-0001Zk-PO
	for gcvg-git-2@gmane.org; Thu, 07 Feb 2008 22:37:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935382AbYBGVgh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2008 16:36:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933094AbYBGVgg
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Feb 2008 16:36:36 -0500
Received: from ti-out-0910.google.com ([209.85.142.190]:2679 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762414AbYBGVge (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2008 16:36:34 -0500
Received: by ti-out-0910.google.com with SMTP id 28so40354tif.23
        for <git@vger.kernel.org>; Thu, 07 Feb 2008 13:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=EfX/QzkcVzXN27VcLPXUUC4O9Tp0AYJr4tF0CGNJHgQ=;
        b=cHl7r2URXs5HfRV8gfE2zrTb+YD3sIagog3V9cp7BnJyvAmQFFupQqchOui3l28tqoHjGk0RG6LXoM68DBiIbbVD3jJL09Iyp+Ai6P5TZ3tdSaTzsegf6X1hbuCp1+M02J6JTzgDUF0TO/9WOXdmsuLbxKyjW/hbus8tKdtNryk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=u7rqDx5euROg4WbmfTVy1kCHhZYpbo/JZaWrpBfG2QYQif6XT5K3OnmdqoOkPcY49YcOyryNBnYW49QD9CWL91lq5IIdvR9OiAa2Il2JEwuYJhkJGmzawGlmXs7FW1Qck4mQvoLqLwl14fISPmm8VxMHuTynZj5AYy4919gO6SU=
Received: by 10.110.68.10 with SMTP id q10mr6748486tia.28.1202420192750;
        Thu, 07 Feb 2008 13:36:32 -0800 (PST)
Received: by 10.70.24.9 with HTTP; Thu, 7 Feb 2008 13:36:32 -0800 (PST)
In-Reply-To: <alpine.LFD.1.00.0802071246320.2896@woody.linux-foundation.org>
Content-Disposition: inline
X-Google-Sender-Auth: 64ce8026a136cf81
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73004>

On 2/7/08, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
>
> On Thu, 7 Feb 2008, Frank Lichtenheld wrote:
> >
> > Easy to say for someone who only distributes source code... (AFAIK
> > anyway)
>
> Sure. But I'd like to point out that there are tons of distributiors of
> Linux _and_ other operating systems - with real lawyers involved - that
> distribute things compiled with OpenSSL, and nobody sane actually thinks
> it is a problem.

Whoa.

I didn't mean to start a flamefest about distributable or not within
Debian. (disclaimer, I'm a Debian developer).

If there is anything I can do to debug the issue with gnutls - let me
know. I'm just stumped about how to debug the problem.

Anand
