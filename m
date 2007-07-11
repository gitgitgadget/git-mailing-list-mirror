From: "David Frech" <nimblemachines@gmail.com>
Subject: Re: [PATCH] Support wholesale directory renames in fast-import
Date: Wed, 11 Jul 2007 16:11:41 -0700
Message-ID: <7154c5c60707111611t7692230ah71883dfd6867c52e@mail.gmail.com>
References: <7154c5c60707091809y7e0b67d5u3f94658b7e814325@mail.gmail.com>
	 <20070710031036.GA9045@spearce.org>
	 <7154c5c60707092116p70aaeb8l90cda9265311b999@mail.gmail.com>
	 <20070710140338.GA18450@informatik.uni-freiburg.de>
	 <20070710141442.GM4436@spearce.org>
	 <7154c5c60707101255k7fcd207fg62f1c59518ba5039@mail.gmail.com>
	 <20070711075744.GO4436@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Jul 12 01:11:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8lLY-0002jg-Lq
	for gcvg-git@gmane.org; Thu, 12 Jul 2007 01:11:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763212AbXGKXLq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jul 2007 19:11:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761727AbXGKXLp
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jul 2007 19:11:45 -0400
Received: from wa-out-1112.google.com ([209.85.146.180]:10743 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758591AbXGKXLp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2007 19:11:45 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2507053wah
        for <git@vger.kernel.org>; Wed, 11 Jul 2007 16:11:42 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aediR0F+f+567RQxJX9Co3XCrMgILKovt+6TO1yAPbfjDzzF8ZIcfuxBEvwbffBWo2rphtnqqtSXhlbQu13O4+9wj22fuNlHmZbyxBYTIErfVEAh9+oSZ4kQCF6LAh1Nbc3JqyScu/9IQHnkgCluy9mgRUcJ9XpgIym2pSsuam4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fy9xjDraVboLp7HPhuHXNwUh37GhTxJSeZoXrUwXxahJoIYycTIzMbLoKWbmHD1QpWYrOTUyUg0/P/sT2wAtdDoDKzi+WOl36g5yIYVGr+TagVa75kRyP3YPTbli39VM92PS+/7zIrIxlmWdqRWI82h65VOnxw6Z9Uyty2RHhDw=
Received: by 10.114.156.1 with SMTP id d1mr5576923wae.1184195501933;
        Wed, 11 Jul 2007 16:11:41 -0700 (PDT)
Received: by 10.115.59.9 with HTTP; Wed, 11 Jul 2007 16:11:41 -0700 (PDT)
In-Reply-To: <20070711075744.GO4436@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52221>

On 7/11/07, Shawn O. Pearce <spearce@spearce.org> wrote:
> I'm tired.  I just worked an 18 hour day.  I need to go do it all
> over again in about 4 hours.  So I'm going to head off to bed.  But
> I did manage to implement this (I think).  Its totally untested.
> But feel free to poke at it:
>
>   git://repo.or.cz/git/fastimport.git copy-wip
>
> I'll write documentation and unit tests tomorrow.  And fix any bugs,
> if any get identified.

Shawn, don't knock yourself out. ;-)

I think getting the semantics right (of the command set in
fast-import) is important, but it doesn't have to be right
*yesterday*. I won't need to point my command stream at fast-import
for at least another day or two. ;-) I have some subtle code to write
first that'll take me a bit to get right...

Thanks for your enthusiasm though!

Cheers,

- David

> --
> Shawn.
>

-- 
If I have not seen farther, it is because I have stood in the
footsteps of giants.
