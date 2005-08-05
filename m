From: Petr Baudis <pasky@ucw.cz>
Subject: Re: garbage in the cogito.git repository
Date: Fri, 5 Aug 2005 02:06:13 +0200
Message-ID: <20050805000613.GD3900@pasky.ji.cz>
References: <20050731124228.GB11570@procyon.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 05 02:09:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E0pl3-0007JC-4R
	for gcvg-git@gmane.org; Fri, 05 Aug 2005 02:08:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262786AbVHEAHK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 Aug 2005 20:07:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262788AbVHEAHK
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Aug 2005 20:07:10 -0400
Received: from w241.dkm.cz ([62.24.88.241]:42254 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262786AbVHEAGQ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Aug 2005 20:06:16 -0400
Received: (qmail 17910 invoked by uid 2001); 5 Aug 2005 00:06:14 -0000
To: Sergey Vlasov <vsu@altlinux.ru>
Content-Disposition: inline
In-Reply-To: <20050731124228.GB11570@procyon.home>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sun, Jul 31, 2005 at 02:42:28PM CEST, I got a letter
where Sergey Vlasov <vsu@altlinux.ru> told me that...
> Hello!

Hi,

> Today's pull from rsync://rsync.kernel.org/pub/scm/cogito/cogito.git
> downloaded more than 10 MB.  It seems that the cogito.git repository
> currently contains all objects in unpacked form, even though most of
> that objects are already in pack files.
> 
> Also there are two mysterious files:
> 
> objects/base.idx
> objects/base.pack
> 
> Could this be fixed?

yes, sorry about this. Packs got there through rsyncs all the way from
git-core, and my immediate naive git-unpack-objects didn't actually do
anything since all the objects were, well, in
.git/objects/pack/thatpackfile. Obviously, this behaviour is reasonable
when you think about it, but rather pitfallous, I would say. At least
documenting it might be worthwhile.

BTW, if you pull now, be prepared to get git-core from elsewhere, since
it will disappear from under your hands as I just unbundled it from
Cogito. ;-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
