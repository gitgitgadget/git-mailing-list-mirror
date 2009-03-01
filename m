From: =?ISO-8859-1?Q?Tor_Arne_Vestb=F8?= <torarnv@gmail.com>
Subject: Re: jgit and ignore
Date: Sun, 01 Mar 2009 15:21:57 +0100
Message-ID: <49AA9A05.6010404@gmail.com>
References: <9e4733910902280831j70448ce9h7239f14e13b92b76@mail.gmail.com>	 <20090228172622.GC26689@spearce.org> <49AA5F64.6070207@pelagic.nl>	 <9e4733910903010454u662eb5afob45f608321660500@mail.gmail.com>	 <49AA884D.1050806@pelagic.nl> <9e4733910903010608u1777f0d4j843f12551154f962@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Ferry Huberts (Pelagic)" <ferry.huberts@pelagic.nl>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 01 15:23:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdmZv-0004P1-4o
	for gcvg-git-2@gmane.org; Sun, 01 Mar 2009 15:23:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753188AbZCAOWM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Mar 2009 09:22:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752980AbZCAOWK
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Mar 2009 09:22:10 -0500
Received: from fg-out-1718.google.com ([72.14.220.158]:16850 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752416AbZCAOWI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Mar 2009 09:22:08 -0500
Received: by fg-out-1718.google.com with SMTP id 16so837868fgg.17
        for <git@vger.kernel.org>; Sun, 01 Mar 2009 06:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=Wj8GKpTOY9c2XXXp1PAveuUqfJGILfpntCbX9qb2+Es=;
        b=rnBDpeqXhEFWwAQWTaU4NsnZ18bTnKbIF3wMxw2CcxnAntl0nQ0/KAl8TFk4iJEkN5
         6m0IZaXPusxH+/lZJtz4jDjevaX5bXZtlQpW4zfWxhLsWXGlhjqyadebNWsy4xlP9QKj
         0zY1lKAVfHik07QcjfedZxIdRldyOqPyuKiBU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=Sffn10OFScDTSa3XBAFkSwufEZEh6kgK7XRiC1pNyAF8qMADyxGEwRXZlGPZytwuch
         jYvAZ6+MJ5zYQhRvCj8djIkBjoOQM46D9UtOZzWGIAk0CZ+KQY5ALiLjqDqKYeemG/7x
         fNBYJlWqzPCXDKMnn/IyM65akeW4v45olEU00=
Received: by 10.86.53.11 with SMTP id b11mr2240123fga.70.1235917324502;
        Sun, 01 Mar 2009 06:22:04 -0800 (PST)
Received: from ?192.168.1.226? (212251244070.customer.cdi.no [212.251.244.70])
        by mx.google.com with ESMTPS id l19sm8022520fgb.47.2009.03.01.06.22.03
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 01 Mar 2009 06:22:04 -0800 (PST)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
In-Reply-To: <9e4733910903010608u1777f0d4j843f12551154f962@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111846>

Jon Smirl wrote:
> I have a C/C++ perspective open right now. Navigator is on the left,
> editor in the middle, outline on the right. In the navigator there are
> several files that should be ignored. I'd like to right click on them
> and select team/ignore. When I do that they will be ignored in git and
> also disappear from my navigator.

That would be Team->Add to .gitignore, as Eclipse does not have a way to
add files to the global ignore from context menus, but I agree, we
should have something like that eventually.

If we were to also remove ignored files from the views we would have to
either add a View Filter for .git-ignored files, or for globally ignored
files. Good idea for enhancement, please report in the issue tracker:

    http://code.google.com/p/egit/issues/

> I also don't like how I have a global .git for all of my projects
> instead of a .git for each project individually. (Did I select that
> when I first installed egit and didn't know what I was doing?) Now I'm
> in a mess and can't publish individual projects.

That's a result of choosing "Create repository in project's parent
directory" when you shared the project in Eclipse.

Perhaps we should try to detect if the project is a Java (/JDT) project,
or otherwise likely to be a "child"-project, where it makes sense to
have the repository in the parent directory?

Tor Arne
