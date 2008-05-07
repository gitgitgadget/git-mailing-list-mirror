From: "Steve Hoelzer" <shoelzer@gmail.com>
Subject: Re: How can I specify multiple refs on one line in the config file?
Date: Wed, 7 May 2008 18:58:17 -0500
Message-ID: <588192970805071658v7a3efab7g5d1c36afc818985d@mail.gmail.com>
References: <588192970805071415wb7b502ch2047ac5e4865c296@mail.gmail.com>
	 <18071eea0805071433j5bde8868w305d9a80c00bd2bd@mail.gmail.com>
	 <588192970805071519i76c23367ue497e37445fa7c74@mail.gmail.com>
	 <20080507222751.GC23672@genesis.frugalware.org>
	 <18071eea0805071538w1e898ebalf4166b08fe7cfac3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "git mailing list" <git@vger.kernel.org>
To: "Thomas Adam" <thomas.adam22@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 08 01:59:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JttXU-0001YK-EM
	for gcvg-git-2@gmane.org; Thu, 08 May 2008 01:59:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755124AbYEGX6W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2008 19:58:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754129AbYEGX6W
	(ORCPT <rfc822;git-outgoing>); Wed, 7 May 2008 19:58:22 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:12576 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753976AbYEGX6U (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2008 19:58:20 -0400
Received: by nf-out-0910.google.com with SMTP id d3so299133nfc.21
        for <git@vger.kernel.org>; Wed, 07 May 2008 16:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=xO5iePSUcJu37T8HSivos0UJKBwTgTsJnBerxn5O1Vg=;
        b=EBya5pupFt1ou1oU5g7YzUSgXt3cIV0ASbvgHhEEZ/OPM3KRcVJFgZDTFVdO3r9wHu4kxbw9X+B9FMF+mde1nJn/MVdgGCKmL5jpTbIBH8/f/Z5/MmHoWcXWIulSwbgmN9iKclEcJc85leM5rhSjHlOHil9oglPFJRf0NMsZEYs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HixnHbvEydJ2SnW89cwEG/H4zl6uCF0Hp2jMQLzVdqFlMOVV6NKgxB5Q/tARrfV7/l+9N3pV5Uc23Ylo1jHY6fJW6ES7VlejTx4aWRlsUaqQYTZyq86cRbdbkNgHjt2R5k8SAkuekGlOFGh1ETpHOnR9tq8RNeiK1XRdN4JN/7o=
Received: by 10.86.31.18 with SMTP id e18mr4960513fge.41.1210204697648;
        Wed, 07 May 2008 16:58:17 -0700 (PDT)
Received: by 10.86.62.15 with HTTP; Wed, 7 May 2008 16:58:17 -0700 (PDT)
In-Reply-To: <18071eea0805071538w1e898ebalf4166b08fe7cfac3@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81493>

On Wed, May 7, 2008 at 5:38 PM, Thomas Adam <thomas.adam22@gmail.com> wrote:
> 2008/5/7 Miklos Vajna <vmiklos@frugalware.org>:
>>  are you sure pushing tags by default is a good idea? people regularly
>>  create local tags to mark a commit before a rebase, to mark a commit as
>>  a fix for a given bug, etc. those tags aren't interesting for others.
>>  tags which should be pushed usually rare. then you can use git push
>>  origin tag v1.0, since you know which tag you really want to push.
>
> Probably not, which is why '--tags' exists in the first place.  But
> then if you're working from a shared repository (which I am -- as are
> many, no doubt in a corporate environment) it's rather useful.  I
> would find local tags though to be odd.

That's exactly my use case and why I asked the question.

However, now I'm reconsidering because local tags and branches are a
great feature to show off git. If the default is to push all tags and
branches just like a centralized VCS, it becomes an obstacle to
learning how git does it -- and I think that the more people learn
about git the more they will like it.

Steve
