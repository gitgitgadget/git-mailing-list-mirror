From: Lea Wiemann <lewiemann@gmail.com>
Subject: Re: [GSoC] What is status of Git's Google Summer of Code 2008 projects?
Date: Fri, 15 Aug 2008 21:38:53 +0200
Message-ID: <48A5DB4D.5060906@gmail.com>
References: <200807080227.43515.jnareb@gmail.com> <200808140457.56464.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Sam Vilain <sam@vilain.net>,
	Joshua Roys <roysjosh@gmail.com>,
	Sverre Rabbelier <alturin@gmail.com>,
	Sverre Rabbelier <sverre@rabbelier.nl>,
	David Symonds <dsymonds@gmail.com>,
	John Hawley <warthog19@eaglescrag.net>,
	Marek Zawirski <marek.zawirski@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Miklos Vajna <vmiklos@frugalware.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 15 21:40:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KU59X-0005CH-Ge
	for gcvg-git-2@gmane.org; Fri, 15 Aug 2008 21:40:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758044AbYHOTjA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Aug 2008 15:39:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758073AbYHOTjA
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Aug 2008 15:39:00 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:17656 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757684AbYHOTi7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Aug 2008 15:38:59 -0400
Received: by fg-out-1718.google.com with SMTP id 19so918056fgg.17
        for <git@vger.kernel.org>; Fri, 15 Aug 2008 12:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding:from;
        bh=X1ozLQbHUYwYFwjjKDVC7bjof6gYmCL5uktzx+ed0Cc=;
        b=V5BIzIULoQFtyDJ+ShPCN668+tmmQkGvxlhT+rJZvJ1PgGwUxw4EOOcUxcFoaE8eL6
         24ZSSi15LQhWEhzuu1bOhDxRrpFJn0gkojqVu4GXmFe0irewVgDzi2aDjiHO5AOjCHgg
         mFy+AjWhagRSbhKNTsGZF5AUPV/zPeuT0CFh8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding:from;
        b=mac+KmfHSaffxVlKc+jnxrxv6yKZLony2w1VeJwnS/AHkHmFp5NgWr2Vv3e2E8/xT2
         grhf+vapZS7qvFZzCmjiU4aNC3llU2SpzXFH/Mw2Hs5lkg0MperQVJfrtD/In9jXzVHs
         wTJrHCVA+oK/uDWIVGNHf2trS0l4n+QmDvmx4=
Received: by 10.180.245.15 with SMTP id s15mr1910352bkh.103.1218829137717;
        Fri, 15 Aug 2008 12:38:57 -0700 (PDT)
Received: from ?172.16.30.128? ( [91.33.254.9])
        by mx.google.com with ESMTPS id g28sm4469992fkg.8.2008.08.15.12.38.54
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 15 Aug 2008 12:38:55 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.16) Gecko/20080707 Thunderbird/2.0.0.16 Mnenhy/0.7.5.666
In-Reply-To: <200808140457.56464.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92512>

Jakub Narebski wrote:
> 3. Gitweb caching
> 
> Student: Lea Wiemann
> Mentor: John 'warthog' Hawley
> 
> There are new tests for gitweb (to check if caching would not break 
> anything new: it did caught a few breakages), new object Perl API to 
> git, and gitweb caching implemented using caching data at the level 
> slightly above calling git commands.  But full code (tests, Perl API 
> and changes to gitweb) are only after first, maybe second round of 
> review.

Correct.  I'm planning to post the next round of patches tonight or
tomorrow.  The remaining to-do items are:

1. We'll still have to have some discussion wrt. what to do about the
API and what status it should have -- Petr (and you as well?) complained
about missing command-line calling functionality.

2. I'll run benchmarks under various conditions, to measure how much
performance we gain with caching, and under what conditions it is most
beneficial.

3. Optional, but with some real performance benefits: Add support for
Last-Modified/If-Modified-Since.

4. Deploy on kernel.org (though John will have to do some/most of this,
and it'll take time beyond the pencils-down deadline I expect).

> Student retention: unknown.

Well, on the downside, I'm expecting to be pretty busy with college, so
there won't be much time to do substantial work on git or gitweb.  On
the upside, I feel perfectly comfortable with contributing to git (i.e.,
maintaining my own patch queue, sending patches, etc.), so it's very
much possible that at some point I'll be hacking git or gitweb again.

-- Lea
