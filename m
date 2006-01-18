From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: "tla missing -s" equivalent with git/cogito
Date: Thu, 19 Jan 2006 07:06:07 +1300
Message-ID: <46a038f90601181006u40a1f8e1n47c27651a4cab3d@mail.gmail.com>
References: <43CE5666.90502@itaapy.com> <43CE75F0.4060009@op5.se>
	 <7vlkxdwhs6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Andreas Ericsson <ae@op5.se>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 18 19:06:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EzHhE-0006vL-8V
	for gcvg-git@gmane.org; Wed, 18 Jan 2006 19:06:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964831AbWARSGJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jan 2006 13:06:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964869AbWARSGJ
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jan 2006 13:06:09 -0500
Received: from wproxy.gmail.com ([64.233.184.202]:57578 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964831AbWARSGI convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jan 2006 13:06:08 -0500
Received: by wproxy.gmail.com with SMTP id 70so1630610wra
        for <git@vger.kernel.org>; Wed, 18 Jan 2006 10:06:07 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZSeDe+yPEyHlHSmeMVKJeeUwNB1Tu93UDUxMwOzqzy8pJVKAB/4JQwnMcUQvq16mfox/+oZfCjtSKubD9jH11KEep3r+8S2e3HKs8mhqzEdIlITC2EmTnrkY5rP/xh7vTezXEDrpaWvYDqtyOakXEUpbBKivMVqvhMFKyzLHcXE=
Received: by 10.54.114.3 with SMTP id m3mr3088635wrc;
        Wed, 18 Jan 2006 10:06:07 -0800 (PST)
Received: by 10.54.127.13 with HTTP; Wed, 18 Jan 2006 10:06:07 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vlkxdwhs6.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14849>

On 1/19/06, Junio C Hamano <junkio@cox.net> wrote:
> Arch star-merge is not an octopus.  They have different "merge
> strategy" just like we have more than one.  No, I do not
> remember the details of how they do it.

In Arch, star-merge is roughly equivalent to git-merge. When I was an
Arch user, I could go out and take a walk under the stars while it
tried to work its magic on my 10K file tree -- so the name was quite
fitting ;-)

The main difference with git is that it has explicit rename tracking
and explicit "patches already applied" tracking. We detect those
things at merge time, and in my projects it has so far worked better
than tla's explicit tracking of things -- but only when I merge with
git-merge. One of these days I'll convince Pasky to use git-merge for
cg-merge's internals.

cheers,


martin
