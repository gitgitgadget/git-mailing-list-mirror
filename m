From: =?ISO-8859-1?Q?Tor_Arne_Vestb=F8?= <torarnv@gmail.com>
Subject: Re: jgit and ignore
Date: Sun, 01 Mar 2009 18:42:54 +0100
Message-ID: <49AAC91E.1000401@gmail.com>
References: <9e4733910902280831j70448ce9h7239f14e13b92b76@mail.gmail.com> <20090228172622.GC26689@spearce.org> <49AA5F64.6070207@pelagic.nl> <9e4733910903010454u662eb5afob45f608321660500@mail.gmail.com> <49AA884D.1050806@pelagic.nl> <49AA8ECD.4090302@gmail.com> <49AA91F0.7050008@pelagic.nl> <49AAA2B3.40808@gmail.com> <20090301171648.GB14365@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Ferry Huberts (Pelagic)" <ferry.huberts@pelagic.nl>,
	Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Mar 01 18:45:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdpjB-0000eq-W3
	for gcvg-git-2@gmane.org; Sun, 01 Mar 2009 18:45:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755970AbZCARnJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Mar 2009 12:43:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755381AbZCARnH
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Mar 2009 12:43:07 -0500
Received: from mail-fx0-f176.google.com ([209.85.220.176]:62079 "EHLO
	mail-fx0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753634AbZCARnG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Mar 2009 12:43:06 -0500
Received: by fxm24 with SMTP id 24so1696493fxm.37
        for <git@vger.kernel.org>; Sun, 01 Mar 2009 09:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=vuxsxhUQhEyvtGaw6YsO8FtL8RJfMmKLeeenLwfQDbU=;
        b=gpSI8/xjetglHlBLxHH477CPOfJV7BrYgtjhrc2qA3925FSxb3x3CPAYwL3vLafGcz
         5duyhGScAn8EAAoa6CD7ezJXatTBwpUqEvo+8iZ+78eD0ssR7Rt/wY3vCuwKJRPoi+2C
         HDgTk5MB0GPDOYyZwm+Y/1LbsGHd9YuN2shQE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=EkFNsW88AfTxoGbYzS4kX8L52K61vF0cKb87JHFK7LyqiaI6tY7SXjo6tehbIlbEzX
         atc1hd3MxrQebBYG61q+nIazCXKUcAmzm+X5XrebzLoOuvqq3f8Urak3CMNGr2zNPtn4
         je4QyPWNrc41HFJc3tcr9Qf1fQhijCqOM5sls=
Received: by 10.86.74.15 with SMTP id w15mr5771898fga.60.1235929382018;
        Sun, 01 Mar 2009 09:43:02 -0800 (PST)
Received: from ?192.168.1.226? (212251244070.customer.cdi.no [212.251.244.70])
        by mx.google.com with ESMTPS id 4sm9641390fge.54.2009.03.01.09.43.00
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 01 Mar 2009 09:43:01 -0800 (PST)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
In-Reply-To: <20090301171648.GB14365@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111859>

Shawn O. Pearce wrote:
> IMHO, we should honor ignores in EGit as:
> 
>   per-directory .gitignore
>   per-repostiory GIT_DIR/info/exclude
> 
>   per-repository core.excludesfile (yes, really, it can be per
>   repository, which overrides ~/.gitconfig setting of same)
> 
>   Eclipse global team ignore patterns

Just to be clear, I noticed you left out the global core.excludesfile
(from ~/.gitconfig) here. I guess this intentional?

Or should we combine the ignores from the global team ignores and the
ignores from the global core.excludesfile in ~/.gitconfig?

Either way, I full agree that we should honor all repository ignores
(whether they are in directory .gitignores, info/exclude, or given by
repository-specific core.excludesfile).

Tor Arne
