From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: t7006 sometimes hangs in cronjobs on OS X
Date: Fri, 11 Feb 2011 20:05:13 -0600
Message-ID: <20110212020513.GB24629@elie>
References: <201102091538.46594.trast@student.ethz.ch>
 <20110209190900.GA8314@sigill.intra.peff.net>
 <201102092016.55078.trast@student.ethz.ch>
 <201102092122.19178.trast@student.ethz.ch>
 <20110209205056.GA2083@sigill.intra.peff.net>
 <20110212020321.GA24629@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Feb 12 03:05:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Po4rU-0007yV-Ot
	for gcvg-git-2@lo.gmane.org; Sat, 12 Feb 2011 03:05:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757027Ab1BLCFU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Feb 2011 21:05:20 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:51877 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756209Ab1BLCFT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Feb 2011 21:05:19 -0500
Received: by ywo7 with SMTP id 7so1339060ywo.19
        for <git@vger.kernel.org>; Fri, 11 Feb 2011 18:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=s23wYmmOHXSjWXwjzfoGTcUAfQTZCIo+w7U/pD8drME=;
        b=JDlJ5nZM17aDOPaHFQLm3gI6X6bVZTcpuQ/+9juOGrFqEVoa9YFmLSdp5c/c0NM8z2
         OUe4eJl+8aWxgl95WKVyOHhJ4mbtXXk5pLA+0YNjPICkBqUmQf9AhjwXxC3MsrMM4jhz
         MaYfYhkYfZimERLAyc/XtioSn7LzXqixCYj8g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Cf910vLcmwUCBE5o6VmJ99oRrejfaxbtvTjI0J6obJum5QGKDEPx7dS/kuRK6xln0T
         Ln25fpNE7oj/ss7GZASn9lCV/ybtAcNSfaMo2R0VzyenMxBh/mkWHNMMRnjtcT07tJsh
         jsV04QhZ/0nqccIqQkdbXwOr6bqKGGOgfY1DE=
Received: by 10.236.110.39 with SMTP id t27mr2263837yhg.31.1297476318506;
        Fri, 11 Feb 2011 18:05:18 -0800 (PST)
Received: from elie (adsl-76-206-235-233.dsl.chcgil.sbcglobal.net [76.206.235.233])
        by mx.google.com with ESMTPS id i59sm3117yhd.3.2011.02.11.18.05.16
        (version=SSLv3 cipher=OTHER);
        Fri, 11 Feb 2011 18:05:17 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110212020321.GA24629@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166590>

Jonathan Nieder wrote:

> Sometimes output includes some streams of
> null bytes, which makes me suspect something awry in the kernel.

(or maybe that last part is a consequence of using stderr both for
standard, unbuffered output and our debugging output) :)
