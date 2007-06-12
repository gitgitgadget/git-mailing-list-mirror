From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] Edit user manual for grammar
Date: Tue, 12 Jun 2007 20:27:59 +0100
Message-ID: <200706122028.01310.andyparkins@gmail.com>
References: <588192970706120518p201b52fdi9ed48896278b9f3e@mail.gmail.com> <200706121643.19837.andyparkins@gmail.com> <20070612175421.GA26767@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="ansi_x3.4-1968"
Content-Transfer-Encoding: 7bit
Cc: "J. Bruce Fields" <bfields@fieldses.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 12 21:28:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyC2K-0000GN-M7
	for gcvg-git@gmane.org; Tue, 12 Jun 2007 21:28:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752026AbXFLT2H (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jun 2007 15:28:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752020AbXFLT2G
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jun 2007 15:28:06 -0400
Received: from wr-out-0506.google.com ([64.233.184.233]:25208 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751863AbXFLT2D (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2007 15:28:03 -0400
Received: by wr-out-0506.google.com with SMTP id 76so1396121wra
        for <git@vger.kernel.org>; Tue, 12 Jun 2007 12:28:03 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=hbpN2T8GmD8FQodYtDShfPrzN6bkFdCpHwhXentQs3OQ0exfeteihdZuQIEEjwFc9VBCBV/rddn4vDg9KPlMO29AFWOfq8xHdvysn/M2C0vvSThFawLaobtVe8tNvSNV1T62JjoHqt8f7pey0OmB3xH+upvvib/m0fE58gacwEI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=NxsN1/kaUNjTOwD1/j22x0cPXifbkTzRrxmhQXMWv/WNdljL02iO0BN9GqF8XZ6U/ef8BaEoD43FD7dX2dlnk+9V2JI9b9nm9WC0h8SwKU89+eL+KkZnYigakweejgk/qSxAGXjV4icj9wjZnJwyOdUmgnT83/k/P9M8/ZKusT4=
Received: by 10.78.138.6 with SMTP id l6mr2877373hud.1181676482470;
        Tue, 12 Jun 2007 12:28:02 -0700 (PDT)
Received: from grissom.local ( [84.201.153.164])
        by mx.google.com with ESMTP id 35sm1523584nfu.2007.06.12.12.28.01
        (version=SSLv3 cipher=OTHER);
        Tue, 12 Jun 2007 12:28:01 -0700 (PDT)
User-Agent: KMail/1.9.7
In-Reply-To: <20070612175421.GA26767@fieldses.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49992>

On Tuesday 2007, June 12, J. Bruce Fields wrote:
> On Tue, Jun 12, 2007 at 04:43:19PM +0100, Andy Parkins wrote:
> >  - "last-resort" is two words, not a conjoined word, it doesn't
> > require the hyphen
>
> Right, but when you've got a couple words functioning together to
> modify a following noun, the hyphen's pretty standard: "rosy-fingered
> dawn". Is this case an exception?  I suspect it's fine either way....

It's certainly common, I don't think that it's correct though.  The 
hyphen's is to form a new word from multiple other words; but often 
these days it's just used to join two words that the author wanted 
saying faster in his head.  The test I always use is if the meaning 
remains the same without the hyphen, it wasn't necessary.

Examples:
  merry-go-round    versus    merry go round
  editor-in-chief   versus    editor in chief

Both of the above loose their meaning when they don't have the hyphens.

"last-resort" doesn't need to be compound because separated it still 
means "the resort that is last".

I don't say that it is a definitive _wrong_ as the meaning is not lost 
nor modified; but I've always viewed English like programming - don't 
add unnecessary complication.

> >  - "method of" is vulgar, "method for" is nicer
>
> Reference?

Please don't take "vulgar" to mean disgusting, I meant "common".  Sorry 
if that was offensive.

Preposition selection and use is highly localised.  I will happily 
accept if you don't agree.  Here is the only reference I can find, but 
it is certainly not definitive, not entirely about this subject...

http://mb.sparknotes.com/mb.epl?b=2437&m=1259471&t=355765&w=1

However, it does make the case that "of" is possessive, so a "method 
of ..." means "a method that belongs to ...", so to my ears "a method 
for" seems the better choice.

> What we really need is a complete recovery tutorial to stick in here
> someplace.  (One day git complains about a corrupt pack file.  What
> do you do?)  What's been stopping me from doing it, besides time, is
> no idea how to come up with a good example to work with.

A big magnet on your hard disk? ;-)


Andy

-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
