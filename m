From: "Vegard Nossum" <vegard.nossum@gmail.com>
Subject: Re: [ANNOUNCE] Java Git (aka jgit) has switched to 3-clause BSD
Date: Mon, 26 May 2008 10:13:45 +0200
Message-ID: <19f34abd0805260113w1341a26bg140d1dbb7438bf46@mail.gmail.com>
References: <20080526044640.GB30245@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Robin Rosenberg" <robin.rosenberg@dewire.com>,
	"Dave Watson" <dwatson@mimvista.com>,
	"Marek Zawirski" <marek.zawirski@gmail.com>, git@vger.kernel.org,
	laforge@gnumonks.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon May 26 10:14:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0Xr7-0005hE-Rs
	for gcvg-git-2@gmane.org; Mon, 26 May 2008 10:14:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753563AbYEZINr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 May 2008 04:13:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753463AbYEZINr
	(ORCPT <rfc822;git-outgoing>); Mon, 26 May 2008 04:13:47 -0400
Received: from rv-out-0506.google.com ([209.85.198.233]:25495 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752710AbYEZINq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 May 2008 04:13:46 -0400
Received: by rv-out-0506.google.com with SMTP id l9so2231196rvb.1
        for <git@vger.kernel.org>; Mon, 26 May 2008 01:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=z1IQFJ0fdkt1d4szglTu2/cVLBWpnJ1Jl4pjqbXVyn8=;
        b=q4lWeyc7+PHPd8ryE+jE1kURJV3OeR9SF9P8j+IeMuxdHOqVwPZTqArwt0nbNBaCPNQO4PpzwsKFQbAgPv8H4xVwhvrtbhpZ5WLH+7CSxMvIxV1hu0KYaHGXbme5r9n1VYQOY2wy8ZK0CZIWvF8NjdtvgLJPODCsn3RddKtdTB8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=myJLNKLq5Pwbt+5Z3O1MXhVL/nmKly3uHalXUC1fdEn25xU++VfT/3euFxZuU3VXqH5YyMi5cBe9DmzfSgJomz4hSkwvwJyaHP+fUobXZI9IkLNlOtpYqUIHknedhSMzlIYowyx5idGucMpDIqPsMd1w+uPH/kYCkAIfpMysyug=
Received: by 10.141.128.19 with SMTP id f19mr1065628rvn.45.1211789625586;
        Mon, 26 May 2008 01:13:45 -0700 (PDT)
Received: by 10.141.145.9 with HTTP; Mon, 26 May 2008 01:13:45 -0700 (PDT)
In-Reply-To: <20080526044640.GB30245@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82907>

Hi,

On Mon, May 26, 2008 at 6:46 AM, Shawn O. Pearce <spearce@spearce.org> wrote:
> As of 53a2cc3 the jgit library (a 100% pure Java implementation
> of git) is now licensed under a 3-clause (new-style) BSD license.
> The change was done with a Perl script to rewrite all source code
> headers within the org.spearce.jgit package.  Copyright information
> was updated based upon the output of git-blame.

I previously read about this transition from GPL to BSD.

IANAL, but isn't the current version a derivative of the older
version, meaning that you need to take all authors into account when
doing this switch, and not just the authors of the _current_ code?

(Or did you get a consent from all previous authors as well as current authors?)


Vegard

-- 
"The animistic metaphor of the bug that maliciously sneaked in while
the programmer was not looking is intellectually dishonest as it
disguises that the error is the programmer's own creation."
	-- E. W. Dijkstra, EWD1036
