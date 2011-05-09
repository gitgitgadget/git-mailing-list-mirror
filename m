From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Qgit should use "git config" instead of "git repo-config"
Date: Mon, 9 May 2011 18:19:42 -0500
Message-ID: <20110509231942.GA23781@elie>
References: <4DC85AA7.2090502@socialserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Marco Costalba <mcostalba@gmail.com>,
	Thiago Farina <tfransosi@gmail.com>
To: Jonathan Rogers <jrogers@socialserve.com>
X-From: git-owner@vger.kernel.org Tue May 10 01:19:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJZk1-0002IG-QF
	for gcvg-git-2@lo.gmane.org; Tue, 10 May 2011 01:19:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932444Ab1EIXTt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2011 19:19:49 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:36706 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755129Ab1EIXTs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2011 19:19:48 -0400
Received: by gyd10 with SMTP id 10so1973528gyd.19
        for <git@vger.kernel.org>; Mon, 09 May 2011 16:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=hFcU07b1btXjketpj78AWzbyOs9nV5/IM5dH0AokXx4=;
        b=cXXkAfTsSeO9x4hWnC6K1+TgQWqvi/D9Lwql+hgJxX2SxiyUIKt+mslqWA6ESknHKT
         QYw58gYwnDZtce0U17uW4awKSb1JBNNdKOSsbSPg6nH90DsWMNgtGNco8eWy8T8gghGH
         QcKQk1sYbDs17IhepFOBx1gmplVjdeP9qLPPw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=PrJoMc84bEDv+5G10YrSWYBQAWfWQXpjmy/2gRjrQ38Rf1JwMFXf+t27bPV0zN9c7Q
         L6cO6+rKgcOTAcp0k0bh2TGjg3OkxQwCDmZ+CR6fM5FEPHBkTj+AOTqXxV5bGBbC1mHY
         oIcLXcKJXDdNa8jAG56HB0R0p25iHrKPAYXog=
Received: by 10.90.250.8 with SMTP id x8mr6069165agh.164.1304983187780;
        Mon, 09 May 2011 16:19:47 -0700 (PDT)
Received: from elie (adsl-68-255-107-251.dsl.chcgil.sbcglobal.net [68.255.107.251])
        by mx.google.com with ESMTPS id u9sm6817753anl.22.2011.05.09.16.19.45
        (version=SSLv3 cipher=OTHER);
        Mon, 09 May 2011 16:19:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4DC85AA7.2090502@socialserve.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173286>

Hi Jonathan,

Jonathan Rogers wrote:

> Here's a small patch to cause qgit to use "git config" instead of
> "git repo-config" in a couple of places.

Thanks!  I noticed you also submitted this at [1].

Looking at the qgit source[2] I don't see an address to send patches to;
cc-ing Marco for advice.

Hope that helps,
Jonathan

[1] http://sourceforge.net/tracker/index.php?func=detail&aid=3299672&group_id=139897&atid=744829
[2] http://git.kernel.org/?p=qgit/qgit4.git
