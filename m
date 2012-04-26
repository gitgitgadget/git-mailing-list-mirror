From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Bad Man Page URLs
Date: Thu, 26 Apr 2012 17:34:53 -0500
Message-ID: <20120426223453.GB16192@burratino>
References: <20120406025457.GA23997@sigill.intra.peff.net>
 <20120406042215.GA3938@burratino>
 <20120406054637.GA25301@sigill.intra.peff.net>
 <7vzkap1gck.fsf@alter.siamese.dyndns.org>
 <BCD7B631-8C73-4F3F-AB37-9B5CF02655D5@justatheory.com>
 <20120426201921.GA15026@burratino>
 <20120426210251.GA31589@sigill.intra.peff.net>
 <CAP2yMa+mjvFmVwXjrB7FRaD2=iMCCPENWAOoCG5TCsqFdsCDxQ@mail.gmail.com>
 <xmqqehra6swg.fsf@junio.mtv.corp.google.com>
 <CAP2yMaKiAT-YJeqmxzZeVuNhEnN-LaJ2h3fSuzZbonKyxCKCCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	"David E. Wheeler" <david@justatheory.com>, git@vger.kernel.org
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 27 00:35:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNXHI-0007NY-Dx
	for gcvg-git-2@plane.gmane.org; Fri, 27 Apr 2012 00:35:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759548Ab2DZWfB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Apr 2012 18:35:01 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:57272 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752077Ab2DZWfA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2012 18:35:00 -0400
Received: by iadi9 with SMTP id i9so145816iad.19
        for <git@vger.kernel.org>; Thu, 26 Apr 2012 15:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=hW1jXJ4fEMgaTn2ZwZz3SJqaR/tbkAQ1cclBAuvBgrk=;
        b=AbBPGPXP3M0mlJnlO6Y2wGw1nVD4e6gqNhLDbiNrJyzUDX3yclA9OnCry2YrnTizc1
         01jLq0r2RiEQ5G8I5C/lPU7dXmL9OdSeZsJy3+jw2jfb0O8HC76b/7MjiySzTUly/VgH
         sNEf4/kJErP2YiflablPA8xh4/Yyr6wnHVY/i9b00uyDT29POj1IRh66hX5RA39iAQtq
         etljsld6Gj2AWXUMQfQvHNjwMehKENRnvylqCWs97cNJAExXa0bB3hDj/7z0HGb63J4j
         CVpXLDAmglUSlQOAqJRI7tCYX1l2DHRWWr5AqfLwJ7DZOeKkHpkrPoAZ2f2pCYFRHbeE
         3BPA==
Received: by 10.50.212.7 with SMTP id ng7mr20319389igc.30.1335479699896;
        Thu, 26 Apr 2012 15:34:59 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id ew6sm103003igc.6.2012.04.26.15.34.58
        (version=SSLv3 cipher=OTHER);
        Thu, 26 Apr 2012 15:34:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAP2yMaKiAT-YJeqmxzZeVuNhEnN-LaJ2h3fSuzZbonKyxCKCCw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196443>

Scott Chacon wrote:

> Yes, this is pretty easy to do - just about everything in
> Documentation/ will eventually be rendered - including the user-manual
> that is currently missing and the release notes.

Nice. :)  Thanks much for doing this.

It seems from adaa3caf that to add the links to release notes, the
appropriate incantation is ASCIIDOC_EXTRA='-a stalenotes'.

Jonathan
