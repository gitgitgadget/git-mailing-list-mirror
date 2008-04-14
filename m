From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Reporting bugs and bisection
Date: Sun, 13 Apr 2008 17:36:38 -0700 (PDT)
Message-ID: <m3ve2ls26p.fsf@localhost.localdomain>
References: <47FEADCB.7070104@rtr.ca>
	<20080413121831.d89dd424.akpm@linux-foundation.org>
	<20080413202118.GA29658@2ka.mipt.ru> <200804132233.50491.rjw@sisk.pl>
	<20080413205406.GA9190@2ka.mipt.ru> <48028830.6020703@earthlink.net>
	<alpine.DEB.1.10.0804131546370.9318@asgard>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stephen Clark <sclark46@earthlink.net>,
	Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	Andrew Morton <akpm@linux-foundation.org>,
	Willy Tarreau <w@1wt.eu>, Tilman Schmidt <tilman@imap.cc>,
	Valdis.Kletnieks@vt.edu, Mark Lord <lkml@rtr.ca>,
	David Miller <davem@davemloft.net>, jesper.juhl@gmail.com,
	yoshfuji@linux-ipv6.org, jeff@garzik.org,
	linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org,
	netdev@vger.kernel.org
To: david@lang.hm
X-From: netdev-owner@vger.kernel.org Mon Apr 14 02:37:43 2008
connect(): Connection refused
Return-path: <netdev-owner@vger.kernel.org>
Envelope-to: linux-netdev-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlChZ-00013d-MV
	for linux-netdev-2@gmane.org; Mon, 14 Apr 2008 02:37:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753673AbYDNAgm (ORCPT <rfc822;linux-netdev-2@m.gmane.org>);
	Sun, 13 Apr 2008 20:36:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753565AbYDNAgm
	(ORCPT <rfc822;netdev-outgoing>); Sun, 13 Apr 2008 20:36:42 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:53179 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753444AbYDNAgl (ORCPT
	<rfc822;netdev@vger.kernel.org>); Sun, 13 Apr 2008 20:36:41 -0400
Received: by fg-out-1718.google.com with SMTP id l27so1351076fgb.17
        for <netdev@vger.kernel.org>; Sun, 13 Apr 2008 17:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=yS6Ok7jmc4IKKg9eWc8YgrTBtFCgg2by+aXQlcd3OWQ=;
        b=p80sh9tKwkHQE6mS+eoCXRn/2nCoxUv21DXLgk2C+ZtF+KQorDoDBNCgpuJvVTTagYjerYfsrgIQhxBlwRn6dVpazWW1vuCcvDvVpZhD/JVywd7OpnipiDU4cJSjZpgGZZggPnkWAOtnjud9ygygLcOYDJAIA0x7Vd/A4QvscVA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=ezCfP9RvKGWkeWlrg+mZ2VGNWjvBHqZNDFVYyBW8qTRiPEZS+7tDOz/0g3g47426btAsbrPeY3zH+onrwrD5L6JvCiKpIt33bnhaq22ED7KCbfQLX6M3Z9TSPWFnMc4WB5uhPgr4cqxFeOFKAk2MtdXhNNRrsJKa6rK466UrQ7E=
Received: by 10.86.51.2 with SMTP id y2mr12080560fgy.50.1208133399520;
        Sun, 13 Apr 2008 17:36:39 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.221.164])
        by mx.google.com with ESMTPS id c14sm8230329nfi.6.2008.04.13.17.36.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 13 Apr 2008 17:36:38 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m3E0aD2w008745;
	Mon, 14 Apr 2008 02:36:14 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m3E0ZxiR008735;
	Mon, 14 Apr 2008 02:35:59 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <alpine.DEB.1.10.0804131546370.9318@asgard>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: netdev-owner@vger.kernel.org
Precedence: bulk
List-ID: <netdev.vger.kernel.org>
X-Mailing-List: netdev@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79431>

david@lang.hm writes:

> cross-posted to git for the suggestion at the bottom

[...]

> Elsewhere in this thread someone said that the pre-git way was to do a
> manual bisect where the developer would send patches backing out
> specific changes to find the problem. one big difference between that
> and bisecting the problem is that the manual process was focused on
> the changes in the area that is suspected of causing the problem,
> while the git bisect process goes after all changes. this makes it
> much more likely that the tester will run into unrelated problems
> along the way.
> 
> I wonder if it would be possible to make a variation of git bisect
> that only looked at a subset of the tree when picking bisect points
> (if you are looking for a e1000 bug, testing bisect points that
> haven't changed that driver won't help you for example). If this can
> be done it would speed up the reporters efforts, but will require more
> assistance from the developers (who would need to tell the reporters
> what subtrees to test) so it's a tradeoff of efficiancy vs simplicity.

Errr... the synopisis of git-bisect contains the following:

 git bisect start [<bad> [<good>...]] [--] [<paths>...]

so you can limit bisection to commits affecting specified subsystem.

P.S. Unfortunately git currently doesn't deal with directory renames,
so if there was sime big code restructuring one has to provide all
historic pathspecs.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
