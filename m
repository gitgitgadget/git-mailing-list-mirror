From: "pradeep singh rautela" <rautelap@gmail.com>
Subject: Re: Why does git track directory listed in .gitignore/".git/info/exclude"?
Date: Thu, 24 Jan 2008 16:14:16 +0530
Message-ID: <6bc632150801240244i6833a918y3d003ff8fa79b15c@mail.gmail.com>
References: <6bc632150801230554l3b24e1e4lb4641bf7c16857c0@mail.gmail.com>
	 <6bc632150801230604p2589c893pa05bb6f27e482de8@mail.gmail.com>
	 <alpine.LFD.1.00.0801231313590.2803@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jan 24 11:44:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHzZj-0008Io-5r
	for gcvg-git-2@gmane.org; Thu, 24 Jan 2008 11:44:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753729AbYAXKoT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2008 05:44:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753737AbYAXKoS
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jan 2008 05:44:18 -0500
Received: from py-out-1112.google.com ([64.233.166.180]:61105 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753657AbYAXKoS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2008 05:44:18 -0500
Received: by py-out-1112.google.com with SMTP id u52so297193pyb.10
        for <git@vger.kernel.org>; Thu, 24 Jan 2008 02:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=08og9gbXqvOrfeNj/gJjAEv6u7U8IMgXc0gs9iEqT14=;
        b=rd8sqtTlH9zXW21ogZdoWVFqe6/MFpjOkb/3ze0yq7Ys8pMDqDrNlR1UXSTcm4wLwg9Cy07dTG0vKArjSS3kHynWp7dA4ADjxpgkn3wR4xHETxdUWQP++8Qnm861ILbOX4hhPQeIndZ8Nhuv9j2PGfdAll8JzphIXHt8Ty94IE4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CgIklGK+1ZQvwQFrve7D3VbMv+1KvsFtyTHqXYC5xX5U/CU+p+gBvGkrhrsJUe+Boj038mE4152VUYtr8TlJYzYEiHU9B+0yrYpT09RCwdTQZRq2C74s0TWEUey+UWTKgliIbGMoKYNtb0OG+6EXjKwzzhDkuK4lcG0OaeLGJFs=
Received: by 10.142.191.2 with SMTP id o2mr198368wff.132.1201171456202;
        Thu, 24 Jan 2008 02:44:16 -0800 (PST)
Received: by 10.142.102.10 with HTTP; Thu, 24 Jan 2008 02:44:16 -0800 (PST)
In-Reply-To: <alpine.LFD.1.00.0801231313590.2803@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71613>

Hi Linus,

On 24/01/2008, Linus Torvalds <torvalds@linux-foundation.org> wrote:
[...]
> > Isn't it fine to include a directory name as
> >
> >    $directory_name/
> >     instead of
> >    $directory_name/*
>
> Heh.
>
> I think your problem is that "/" itself. By adding it, the exclude
> information does *not* match the directory entry itself (because the
> directory entry itself is called just "xen-3.1.0-src" - note no slash!),
> and since you added it, it also doesn't match any names _under_ that
> directory exactly.

Got that.
Thanks a lot for explaining that to me Linus.

Best Regards,
                --Pradeep
>
> So what you *should* have done is to just tell git to ignore the directory
> named "xen-3.1.0-src", and you'd have been ok.
>
> Using "xen-3.1.0-src/*" works too, but it is heavy-handed and unnecessary.
>
>                 Linus
>


-- 
--
pradeep singh rautela
http://eagain.wordpress.com
http://emptydomain.googlepages.com
