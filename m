From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: svn-fe status
Date: Sun, 26 Sep 2010 21:54:58 -0500
Message-ID: <20100927025458.GA8921@burratino>
References: <20100701031819.GA12524@burratino>
 <20100701054849.GA14972@burratino>
 <20100817170216.GA14491@kytes>
 <20100905031528.GA2344@burratino>
 <20100905032253.GB2344@burratino>
 <20100924065900.GA4666@burratino>
 <20100925051926.GA19804@burratino>
 <AANLkTi=sij9TeY+Cv85n61xt3R6nPbkpOyKdoDMzbtaD@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <david.barr@cordelta.com>,
	Sam Vilain <sam@vilain.net>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 27 04:58:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P03uj-0006np-Nu
	for gcvg-git-2@lo.gmane.org; Mon, 27 Sep 2010 04:58:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932615Ab0I0C55 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Sep 2010 22:57:57 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:47797 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932581Ab0I0C54 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Sep 2010 22:57:56 -0400
Received: by qyk33 with SMTP id 33so7121115qyk.19
        for <git@vger.kernel.org>; Sun, 26 Sep 2010 19:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=4wjy5TMY6OW62bHdiXI4rtV7WUBv6zDrXXLbthSzWj8=;
        b=HmOFw3oZ8AbX63h4Vbx0J/XQfblYnZ9f4R64aSU+8azo15rAoNSBDMeJCLWUe9ssXG
         ey7oqRP5w8TqdlQkvdf4xAff5CIgtn0BfrTcLgZil4DWo+KiARhx4jfpDNBI6KdaTbe3
         1FMLYfOIoyOKFtBsxuSkaa9N0tC9yqUJ1jn0Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Ocm4wTDXp7YStkVxs2xJc2quSlPZAaTj/WJtSRSgIOIlBQytpRst/L0eNusxe+ZsQm
         zRIxeNzapd6hrA+mgYPdYSG3hNUJBrzgslxUIr13EQdJ76B43lVJkYARnijSU4fDsd91
         8EJRLIlLq2XCp1Pna3/bkzpcqzIPOmWRnIGNM=
Received: by 10.224.29.16 with SMTP id o16mr4988641qac.55.1285556275706;
        Sun, 26 Sep 2010 19:57:55 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id t18sm5932792qco.20.2010.09.26.19.57.54
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 26 Sep 2010 19:57:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTi=sij9TeY+Cv85n61xt3R6nPbkpOyKdoDMzbtaD@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157290>

Sverre Rabbelier wrote:

> Shouldn't that be 'C' for copy?

Yep, that is better.

 feature copyfromrev
 ...
 C :72 "trunk/README" "branches/topic/README"

We can peek ahead to make sure

 C :72 branches/topic/README

still copies a file named ":72".

> You'll thank yourself later if you add an (optional?) mark to cat, so
> that you can cat previous versions of a file too? Doesn't svn ever
> give you a diff against -. ... never mind!

For completeness it probably does make sense to allow

 cat <dataref> <path>

too, with <dataref> pointing to a tree (as before) or to a tag or
commit.  I just suspect svn-fe would not use it.
