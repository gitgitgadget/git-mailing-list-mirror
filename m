From: Steffen Daode Nurpmeso <sdaoden@googlemail.com>
Subject: Re: Jabber, question on push,pull and --tags, and no help but jabber
Date: Tue, 7 Jun 2011 12:24:44 +0200
Message-ID: <20110607102444.GA85904@sherwood.local>
References: <20110606130205.GA41674@sherwood.local>
 <4DECE4D6.9000204@drmicha.warpmail.net>
 <20110606214639.GA38620@sherwood.local>
 <4DEDBB56.7000200@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Jun 07 12:24:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTtT0-0002dL-JJ
	for gcvg-git-2@lo.gmane.org; Tue, 07 Jun 2011 12:24:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751333Ab1FGKYy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2011 06:24:54 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:51638 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751029Ab1FGKYx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2011 06:24:53 -0400
Received: by fxm17 with SMTP id 17so2974720fxm.19
        for <git@vger.kernel.org>; Tue, 07 Jun 2011 03:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=7IOCQlaKZAdvaCT8qQ+xJWDvsSDeEKVReTpCKj1rlSs=;
        b=BzYM29Y37Vm1EDMli0LK8p1McnTkd0/Muy7oxRZGEkOj48tGlhCfO8XNY9a6K99+QC
         UK4af/RQMPTHoESYeR//Z1RjdCuoOc034QphK7ifU14sbJxGR2CgjxBDcaq4c0OORRLv
         O0pgWZprpvgbZYY9C62RN4XELyNyoz7VXbXd0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=knuEq4nw+VjiZGTeXmk7zErrTFkdZLiLLIwt2WWsrycdZlgN2SEYmTRzy2ET0n8HyM
         9v/HoWKgcFCf7xwcJmYFeWxb0Tk4pCD22QQTV0G+eDlP0iDp+XnBQrxACR29IRZBtHlR
         UnyEr6I3UUw7RHbTI68YhCW7Fpp2Hp4oWfoxE=
Received: by 10.223.44.86 with SMTP id z22mr3963399fae.3.1307442291860;
        Tue, 07 Jun 2011 03:24:51 -0700 (PDT)
Received: from sherwood.local ([89.204.137.222])
        by mx.google.com with ESMTPS id 20sm373332faf.37.2011.06.07.03.24.49
        (version=SSLv3 cipher=OTHER);
        Tue, 07 Jun 2011 03:24:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4DEDBB56.7000200@drmicha.warpmail.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175192>

@ Michael J Gruber <git@drmicha.warpmail.net> wrote (2011-06-07 07:47+0200):
> > +	refs under `refs/heads/` be pushed explicitely.
> 
> I don't mind but I don't think it adds clarity.

Yes you're right - it was around midnight and i was tired.
That's a stupid change.

> That is implicit in the line before it. In any case: The main problem of
> git-push(1) seems to be that one has to read all the way down (through
> all options) in order to grasp the default case, 

In fact i'm lazy, so i'll assume that hardly happens until the
first error occurs :).

> so I feel the first paragraph needs to improve.

This morning i've reread tutorial(-2)? and user-manual, which,
plus core-tutorial, where the files i've really read :-).
And guess what, in neither of these files you will find a single
word or even example about this, but the talk is only on branches!
everyday.txt and gitworkflows.txt, however, give you

    <13> push the tag out, too.
..
    You need to push the new tag to a public git serve..
    This makes the tag available

Interesting ", too" and "You need to" that is, maybe ;-/.
I'll propose for real fewest minor changes in the documentation,
so that users get a glance on that fact.  I would assume that
these few lines would have been enough for me to "get a starter".

Thanks for the responses.
(By the way: "an arbitrary SHA-1 expression will do" sounds like
it's talking about a cool and flexible software.)
--
Ciao, Steffen
sdaoden(*)(gmail.com)
() ascii ribbon campaign - against html e-mail
/\ www.asciiribbon.org - against proprietary attachments
