From: David Aguilar <davvid@gmail.com>
Subject: Re: Pro Git Book
Date: Tue, 28 Jul 2009 01:56:01 -0700
Message-ID: <20090728085600.GA33224@gmail.com>
References: <d411cc4a0907271056x458d7b15lc1b2868a46884175@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 28 10:56:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MViTq-0003B9-3l
	for gcvg-git-2@gmane.org; Tue, 28 Jul 2009 10:56:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752523AbZG1I4J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2009 04:56:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752267AbZG1I4I
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jul 2009 04:56:08 -0400
Received: from rv-out-0506.google.com ([209.85.198.237]:40748 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751870AbZG1I4H (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2009 04:56:07 -0400
Received: by rv-out-0506.google.com with SMTP id f6so1045354rvb.1
        for <git@vger.kernel.org>; Tue, 28 Jul 2009 01:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=LvCxy1h/Cje0rQgrvFWS3k1VfKlbF8ARXo4fGh2mito=;
        b=sRyGk94xg5uoZnvUUBJxdI8q7EyDNGBJOqAKpX7LDX5tAXX+3Q4X+rN3emGdf6RYcI
         9wOPWsCzulWVRsCdEQHvzLoAA2u7L7dQhqRmrrBpfwBsq7VksCYBub4NQohKbvGHgxoD
         fJEFE5TpERfBcqA8AhnB09YOs3oyYilA5YInM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=hTkleXSiZ0zIL5iWht+NgMfLwjBT7uUCtn4W3JY+oxVoouU86Ruord02fizcyGRT4A
         OxXvG3vhxXoBhwE5J5wX1pLrSpvz1YMcFveuDc1PEH0vaZbwN4qrbxDtMlon+Ft44+Hl
         0rARoF7HaGBPtFE7ZuKpwCNsTcCHrmna/l8fY=
Received: by 10.140.169.4 with SMTP id r4mr567766rve.102.1248771367628;
        Tue, 28 Jul 2009 01:56:07 -0700 (PDT)
Received: from gmail.com (cpe-76-94-197-182.socal.res.rr.com [76.94.197.182])
        by mx.google.com with ESMTPS id b39sm750379rvf.23.2009.07.28.01.56.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 28 Jul 2009 01:56:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <d411cc4a0907271056x458d7b15lc1b2868a46884175@mail.gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124225>

On Mon, Jul 27, 2009 at 10:56:57AM -0700, Scott Chacon wrote:
> Hey all,
> 
> Just a heads up - I've been working on a book on Git being published
> by Apress called "Pro Git", which is being licensed under a CC 3.0
> license and as I've just finished some of the final reviews, I've put
> the entire content of the book online at:
> 
> http://progit.org
> 
> It should be shipping at the end of August, I think, but I just wanted
> to let people know that there is another resource out there to help
> learn Git.  This one was actually technically edited by Shawn, too, so
> hopefully not too many serious errors of mine got through.
> 
> I've added a link to it on http://git-scm.com under the Books section,
> in case you want to point any newbies there.  Hope this helps take
> some teaching load off some of your plates.
> 
> Thanks,
> Scott

Good stuff,
Thanks Scott.

In http://progit.org/book/ch7-1.html we go through a
lot of machinations to setup an external diff viewer.

That might be a good time to introduce git-difftool, even if
only to mention that the setup is much simpler when difftool is
used.  It allows you to do without the wrapper scripts.

$ p4=/Applications/p4.merge.app/Contents/MacOS/p4merge
$ git config --global difftool.p4.cmd "$p4 \"\$LOCAL\" \"\$REMOTE\""
$ git difftool -t p4

$ git config --global diff.tool p4
$ git difftool

It's even easier if you use one of the several built-in tools,
e.g. opendiff, kompare, meld, etc., since it requires no
configuration.

Mentioning that it's a fairly new feature is probably important,
too.  Hmm. I guess I should've send a patch ;-)


Have fun,

-- 
		David
