From: Jonathan Nieder <jrnieder@gmail.com>
Subject: fast-import wishlist (Re: [RFC] fast-import: note deletion command)
Date: Sun, 18 Sep 2011 16:03:36 -0500
Message-ID: <20110918210336.GH2308@elie>
References: <CA+gfSn9sdTzQghqQp6hcO-9kN9mPx2JLRig79Rgx2FqGWXXp=A@mail.gmail.com>
 <20110918203506.GG2308@elie>
 <CAGdFq_hpA95Kj4eMr4e1duuXTpr+OkkwF4K5bTapXEi9UjWcSA@mail.gmail.com>
 <CA+gfSn9CsL4tz30B62mDzALdyy1RTFiRT4a1zdJ8pR8aTdcpXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Git List <git@vger.kernel.org>,
	David Barr <davidbarr@google.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Thomas Rast <trast@student.ethz.ch>,
	Johan Herland <johan@herland.net>
To: Dmitry Ivankov <divanorama@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 18 23:03:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5OWe-0003Hk-DB
	for gcvg-git-2@lo.gmane.org; Sun, 18 Sep 2011 23:03:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932325Ab1IRVDk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Sep 2011 17:03:40 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:45311 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932082Ab1IRVDj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Sep 2011 17:03:39 -0400
Received: by iaqq3 with SMTP id q3so4557141iaq.19
        for <git@vger.kernel.org>; Sun, 18 Sep 2011 14:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=GmBzNeDKMH2obU57cJzXWW8KgeZcNM6G/s7l/8KT7lk=;
        b=g0DLchyHtCzea6vsq8DsR4IibL6Kb5W7ZGNwmbRL7ZRpG1xcS4tO6JRg3lSqypLXJg
         Kw/KG9BtP2BLRSdMo1/6y2B0WDrkVNnRCvS++WVkxfnicGkCFqtzBlQJhbc7Rc96kq+1
         AasZpwBPSAzH0MevMiN+quGiTsoGWzxqqDZgk=
Received: by 10.42.133.65 with SMTP id g1mr3262588ict.8.1316379818988;
        Sun, 18 Sep 2011 14:03:38 -0700 (PDT)
Received: from elie (99-120-124-35.lightspeed.cicril.sbcglobal.net. [99.120.124.35])
        by mx.google.com with ESMTPS id n14sm22269723ibi.4.2011.09.18.14.03.38
        (version=SSLv3 cipher=OTHER);
        Sun, 18 Sep 2011 14:03:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CA+gfSn9CsL4tz30B62mDzALdyy1RTFiRT4a1zdJ8pR8aTdcpXA@mail.gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181638>

Dmitry Ivankov wrote:
> On Mon, Sep 19, 2011 at 2:39 AM, Sverre Rabbelier <srabbelier@gmail.com> wrote:

>> Is this perhaps a good moment to also think about branch deletion?

It might be a good temporal moment, but it's not quite the right
thread for it. :)  If someone wants to maintain a fast-import wishlist
in a wiki somewhere, it sounds like it could be useful to some people
(I prefer to read patches and stories about particular use cases,
myself :)).

>> That came up earlier as well, and thinking about that might give us
>> some insights in how to deal with deletions uniformly.
>
> Also maybe marks deletion, getting mark sha1,  resetting a mark with
> explicit sha1. But most probably not tags deletion.
>
> And going much further on commands, following look nice to have:
> - 'ls' storing result to a mark (to allow us not to compute sha1/store
>   object if we don't want to)
> - marks namespaces (to keep ls mark separately, mark deletion will
>   do too, if it's only a single temporary mark). Maybe like ::nr:mark.

Regards,
Jonathan
