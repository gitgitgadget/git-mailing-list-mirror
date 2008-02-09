From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Add gitattributes file making whitespace checking pickier
Date: Sat, 9 Feb 2008 21:22:00 +0100
Message-ID: <200802092122.01656.jnareb@gmail.com>
References: <20080209162234.GA25533@fieldses.org> <m3abm9hqix.fsf@localhost.localdomain> <20080209200435.GA8919@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Sat Feb 09 21:22:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNwDk-0007Ft-EA
	for gcvg-git-2@gmane.org; Sat, 09 Feb 2008 21:22:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755563AbYBIUWL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2008 15:22:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755543AbYBIUWK
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Feb 2008 15:22:10 -0500
Received: from mu-out-0910.google.com ([209.85.134.186]:58890 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755527AbYBIUWJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2008 15:22:09 -0500
Received: by mu-out-0910.google.com with SMTP id i10so4786380mue.5
        for <git@vger.kernel.org>; Sat, 09 Feb 2008 12:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=Gh6jt5UOWG8L6a0GBvpOPjR7iQ0cfDEWESeRE/l09FA=;
        b=OE2R7XNZShN9Xvv/fjLGkSap1+A8dKc3hOEkI2D/R8nmLT3LwUIeoZLsRTTSepLtWpEuNa5UlIVCxkg3/PhEVhoeXSUx4IGsG4w2esHnEr8McgvRULEhdgSDRjurJHolRhlsAX7YloIeTXJIMRweFHQ8RIZgPXeYFF9PTBKvQR8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=LQ1gU3BO5INf538QxGpMEvlOEWlEcOxz0sQWt7TZ0EJ9Tr7X/u0Ycf+gPUR2d3nF80M6xvMB5j5So4UKesh8AzLg+NFMUOQDNHQJzsI+pyU2SNIgVLcaUe2yHReU/6Df8C9eMOduFIJahNTQy8/YcvNlvqEoe/ZmJcNXy8iZF1g=
Received: by 10.78.107.8 with SMTP id f8mr25741894huc.38.1202588527817;
        Sat, 09 Feb 2008 12:22:07 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.255.105])
        by mx.google.com with ESMTPS id 35sm1173191nfu.12.2008.02.09.12.22.05
        (version=SSLv3 cipher=OTHER);
        Sat, 09 Feb 2008 12:22:06 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20080209200435.GA8919@fieldses.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73262>

J. Bruce Fields wrote:
> On Sat, Feb 09, 2008 at 11:36:31AM -0800, Jakub Narebski wrote:
> > "J. Bruce Fields" <bfields@fieldses.org> writes:
> > 
> > >  gitweb/gitweb.perl                                  |  566 ++--
> > >  index-pack.c                                        |   30 
> > 
> > gitweb (at my insistence) uses tabs for indent, but spaces for align,
> > so that the layout is [roughly] preserved independently of the tab
> > size. IMHO it is superior style, but much harder to check
> > algorithmically (although I send some sketch of idea how to check that
> > at least for aligned commands). That is why there is such a big change.
> > 
> > I'd rather have real bugfixes, real documentation improvements, new
> > features instead of such bikeshedding.  If someone is making a change
> > somewhere, he/she can fix the whitespace in the neighbourhood.
> 
> I agree completely.  Did I suggest otherwise?

Ah, sorry, I have misunderstood.

This is an informational piece, then, isn't it?
-- 
Jakub Narebski
Poland
