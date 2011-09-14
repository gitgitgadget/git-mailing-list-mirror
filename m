From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Helping on Git development
Date: Wed, 14 Sep 2011 16:32:03 -0500
Message-ID: <20110914213202.GA20473@elie>
References: <CAOz-D1JW8RSR8kVWhT7v-DCbWayU8KhbePJwWrWvJwbmueRezQ@mail.gmail.com>
 <CAOz-D1+77JZRXa57GLz=vZyrcGs4Ojj6Wa0cSD4QcEkMP3PPsA@mail.gmail.com>
 <CAH5451me+MDe34Boak=UDjH9T_WAnO6wxa6pW+JHOoGADoNfkQ@mail.gmail.com>
 <7vehzjugdz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andrew Ardill <andrew.ardill@gmail.com>,
	Eduardo D'Avila <erdavila@gmail.com>, git@vger.kernel.org,
	git@packages.debian.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 14 23:32:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3x4D-0003sf-DM
	for gcvg-git-2@lo.gmane.org; Wed, 14 Sep 2011 23:32:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757469Ab1INVcT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Sep 2011 17:32:19 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:52096 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755922Ab1INVcS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Sep 2011 17:32:18 -0400
Received: by iaqq3 with SMTP id q3so467938iaq.19
        for <git@vger.kernel.org>; Wed, 14 Sep 2011 14:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Iq+3lyW7RMVWSCZAPcSaQF3zDqclsnaJWMBuNXZs9ik=;
        b=BYnvuIGJaDNItfmU9uEtGZYJ2q+GSmCN0k2mgeqFOX5NiIE97hBDWRXv4sAcUXAkd6
         2Zpa9cxYV3QRFoHv/1Rh/i77QZPrn/ltDIvyqLob9mK//5Y/rncaT6ztHVY8/HSKG2zI
         Ir5CvAG339ghrNXTBWjNzG1WONJQ0wLL9YL40=
Received: by 10.231.61.149 with SMTP id t21mr518507ibh.46.1316035936468;
        Wed, 14 Sep 2011 14:32:16 -0700 (PDT)
Received: from elie (99-120-124-35.lightspeed.cicril.sbcglobal.net. [99.120.124.35])
        by mx.google.com with ESMTPS id a11sm1702481ibg.3.2011.09.14.14.32.14
        (version=SSLv3 cipher=OTHER);
        Wed, 14 Sep 2011 14:32:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vehzjugdz.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181402>

Junio C Hamano wrote:

> As to contributing to the project, right now, I think we have enough
> people who want to write code and documentation for Git, but what we lack
> are bandwidth to (this is not meant to be an exhaustive list):
[...]
>  - distilling random wishes from the end user community while winnowing
>    chaffs that are unrealistic or do not fit well with the grand scheme of
>    things, to come up with a concrete proposal and a patch series
[...]
>  - dig list archives to point people at age-old discussions to non-issues
>    that have long been resolved to squelch noise; and
>
>  - remind original submitter, people who were involved in the discussion,
>    and people who should have been involved but who weren't, of a worthy
>    but stalled topics from time to time.

I also should (reluctantly) mention that the Debian bug tracker has
been accepting bugs from outsiders and provides a service like this.
Caveats:

 - it only tracks bugs that affect Debian (usually meaning
   platform-independent bugs).  Occasionally bugs from Windows users
   have been reported there and it's been okay.

 - the interface might seem quirky if you're not used to it.
   Documentation is at http://www.debian.org/Bugs/

 - no guarantee of a quick response.  When there is a response,
   usually it is "here are some thoughts; now let's take this to
   git@vger.kernel.org".

 - if the bugtracker gets swamped with reports from outside without
   manpower to match, the policy re bugs from outside Debian might
   change.

Bug listing: [1].
To subscribe to receive bug reports by email: [2].

Thoughts welcome, as always.
Jonathan

[1] http://bugs.debian.org/cgi-bin/pkgreport.cgi?src=git;include=tags:upstream;exclude=tags:fixed-upstream;exclude=tags:moreinfo;exclude=severity:wishlist
[2] http://www.debian.org/doc/manuals/developers-reference/resources.html#pts-commands
Summary: an email to pts@qa.debian.org whose body contains the two
lines "subscribe git", "keyword git = bts" would do the trick.
