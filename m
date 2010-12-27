From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC/PATCH] cherry-pick/revert: add support for
 -X/--strategy-option
Date: Mon, 27 Dec 2010 15:25:15 -0600
Message-ID: <20101227212515.GA32352@burratino>
References: <20101211005144.GA6634@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Justin Frankel <justin@cockos.com>,
	Bert Wesarg <bert.wesarg@googlemail.com>,
	Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	Kevin Ballard <kevin@sb.org>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 27 22:25:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PXKZn-0001yF-LC
	for gcvg-git-2@lo.gmane.org; Mon, 27 Dec 2010 22:25:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751605Ab0L0VZl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Dec 2010 16:25:41 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:48423 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750951Ab0L0VZk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Dec 2010 16:25:40 -0500
Received: by qyk12 with SMTP id 12so9805086qyk.19
        for <git@vger.kernel.org>; Mon, 27 Dec 2010 13:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=j62cxLWDSvA/+fLuXeESqpKZRIVXqeq9N6VE6XhdQEA=;
        b=dPt7QBNLugbqLA8Aawaf6nPetUT1nrhGNfpdMYVpkXj/rEdk334t/3CpE+HrTSIWKb
         BW4ITiaZN1qdf32wlBu0OJEI3T7kbAIGQbgNMjoNqedOx8OQZZab3nEi8+dCLrkemW91
         odYH5dwEs0DMQk/BPukfaU1+vAq1JXEOpxoME=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=cB9MSh9aZldOWFPbmSLgL12Nclxce1PTlanFj/tSFbAMqvYEuP1Jz6ExBerPAL2R/2
         4gyOMp+j6teObvzPo3WcOdQ9WMyDyjEWwKsc7T1So/XfcStFUOFUE6B8PIkpXkvr6pxq
         9CvA4Hp1J9984rLu1ZypUqm3oXuzVTCW+SQag=
Received: by 10.224.53.193 with SMTP id n1mr12025475qag.270.1293485139918;
        Mon, 27 Dec 2010 13:25:39 -0800 (PST)
Received: from burratino (c-76-126-174-171.hsd1.ca.comcast.net [76.126.174.171])
        by mx.google.com with ESMTPS id g28sm7209826qck.1.2010.12.27.13.25.35
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 27 Dec 2010 13:25:37 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101211005144.GA6634@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164223>

Jonathan Nieder wrote:

> For example, this would allow cherry-picking or reverting patches from
> a piece of history with a different end-of-line style, like so:
> 
> 	$ git revert -Xrenormalize old-problematic-commit
> 
> Currently that is possible with manual use of merge-recursive but the
> cherry-pick/revert porcelain does not expose the functionality.
> 
> While at it, document the existing support for --strategy.
> 
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> Thoughts?

Ping?  I use this with -Xpatience fairly often.  Am I the only one who
has wanted such a thing?
