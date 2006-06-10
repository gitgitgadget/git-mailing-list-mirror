From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Figured out how to get Mozilla into git
Date: Sat, 10 Jun 2006 13:14:13 +1200
Message-ID: <46a038f90606091814n1922bf25l94d913238b260296@mail.gmail.com>
References: <9e4733910606081917l11354e49q25f0c4aea40618ea@mail.gmail.com>
	 <46a038f90606082006t5c6a5623q4b9cf7b036dad1e5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 10 03:14:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fos3P-000589-Lt
	for gcvg-git@gmane.org; Sat, 10 Jun 2006 03:14:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932192AbWFJBOR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Jun 2006 21:14:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932609AbWFJBOR
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jun 2006 21:14:17 -0400
Received: from wr-out-0506.google.com ([64.233.184.238]:37159 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932192AbWFJBOQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jun 2006 21:14:16 -0400
Received: by wr-out-0506.google.com with SMTP id i20so783225wra
        for <git@vger.kernel.org>; Fri, 09 Jun 2006 18:14:14 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bHdnAzSfynEWMgGROzaRs9uxWiF1mp+FLlOyEf3cuMmWxF1MVZ0WMNNZTKpPxkvbE2uDdPGrl3jFGjDzkaldfcfskRyMOZo9DCcH2A8GlsaL824f/AUMr/0VqeXVjVZGBMtQ93vpPtDMgLoJ8Q1POaq2Icn53kz1ZA0RJwwPKvY=
Received: by 10.54.95.11 with SMTP id s11mr3611667wrb;
        Fri, 09 Jun 2006 18:14:14 -0700 (PDT)
Received: by 10.54.71.4 with HTTP; Fri, 9 Jun 2006 18:14:13 -0700 (PDT)
To: "Jon Smirl" <jonsmirl@gmail.com>
In-Reply-To: <46a038f90606082006t5c6a5623q4b9cf7b036dad1e5@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21577>

On 6/9/06, Martin Langhoff <martin.langhoff@gmail.com> wrote:
> mozilla.git$ du -sh .git/
> 2.0G    .git/

Ok -- pushed the repository out to our mirror box. Try:

   git-clone http://mirrors.catalyst.net.nz/pub/mozilla.git/

Now, good news. No, _very_ good news. As I was rsync'ing this out, and
looking at the repo, suddently something was odd. Apparently after a
git-repack -a -d OOMd on me, and I had posted this message, I re-ran
it.

[As it happens I have been running several imports of gentoo and moz
lately on thebox. It is entirely possible that cvsps or a stray
git-cvsimport was sitting on a whole lot of ram at the time]

Now I don't know how much memory or time this took, but it clearly
completed ok. And, it's now a single pack, weighting a grand total of
617MB

So my comments about OOM'ing were wrong apparently. Hey, if the whole
history is actually only 617MB, then initial checkouts are back to
something reasonable, I'd say.

cheers,



martin
