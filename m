From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC PATCH 0/8] Git remote helpers to implement smart
	transports.
Date: Tue, 1 Dec 2009 08:52:45 -0800
Message-ID: <20091201165245.GF21299@spearce.org>
References: <1259675838-14692-1-git-send-email-ilari.liusvaara@elisanet.fi> <fabb9a1e0912010812t4de8027dj1faf828051d1adc2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Tue Dec 01 17:52:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFVyB-0002sM-7k
	for gcvg-git-2@lo.gmane.org; Tue, 01 Dec 2009 17:52:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754134AbZLAQwo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2009 11:52:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753841AbZLAQwo
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Dec 2009 11:52:44 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:61625 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753834AbZLAQwn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2009 11:52:43 -0500
Received: by yxe17 with SMTP id 17so4730158yxe.33
        for <git@vger.kernel.org>; Tue, 01 Dec 2009 08:52:49 -0800 (PST)
Received: by 10.101.135.38 with SMTP id m38mr2483711ann.163.1259686368525;
        Tue, 01 Dec 2009 08:52:48 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 23sm119220yxe.54.2009.12.01.08.52.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 01 Dec 2009 08:52:47 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <fabb9a1e0912010812t4de8027dj1faf828051d1adc2@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134226>

Sverre Rabbelier <srabbelier@gmail.com> wrote:
> On Tue, Dec 1, 2009 at 14:57, Ilari Liusvaara
> <ilari.liusvaara@elisanet.fi> wrote:
> > This series implements extensions to remote helpers for carrying smary
> > transports. It is against next, because master doesn't contain necressary
> > patches (the allow specifying remote helper in url one).
> 
> Could you please explain how this relates to Shawn's smart http series
> and the sr/vcs-helper series?

Or better, why this is even necessary?

I thought git:// over TCP is pretty simple and efficient, and fairly
widely deployed.  Smart http(s):// will be in 1.6.6 and available
soon, and isn't all that ugly.

Since the introduction of git:// nobody has asked for another
protocol... other than wanting to make http:// as efficient as
git:// is.  Which is now done.

So why do we need this?

The sr/vcs-helper series makes sense if you want to make SVN, Hg,
or P4 remotes act transparently like Git remotes.  But that's not
embedding the git:// protocol inside of another protocol, its doing a
full up conversion from a non-Git set of semantics to Git semantics.

-- 
Shawn.
