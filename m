From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: is gitosis secure?
Date: Sun, 14 Dec 2008 02:51:26 -0800 (PST)
Message-ID: <m3vdtndo9b.fsf@localhost.localdomain>
References: <200812090956.48613.thomas@koch.ro>
	<bd6139dc0812090138l5dbaf20bsd1cde00f52bb94e5@mail.gmail.com>
	<87hc58hwmi.fsf@hades.wkstn.nix> <gi1qsl$22p$1@ger.gmane.org>
	<alpine.DEB.1.10.0812132126470.17688@asgard.lang.hm>
	<4944D4F7.7050501@siamect.com>
	<alpine.DEB.1.10.0812140304320.17688@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: martin <martin@siamect.com>, git@vger.kernel.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Sun Dec 14 11:52:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBoad-0006Qr-8t
	for gcvg-git-2@gmane.org; Sun, 14 Dec 2008 11:52:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752621AbYLNKva (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Dec 2008 05:51:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752591AbYLNKva
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Dec 2008 05:51:30 -0500
Received: from ey-out-2122.google.com ([74.125.78.27]:42196 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752447AbYLNKv3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Dec 2008 05:51:29 -0500
Received: by ey-out-2122.google.com with SMTP id 6so309312eyi.37
        for <git@vger.kernel.org>; Sun, 14 Dec 2008 02:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=adgmxALcWpWsa+vOep0hn8HXxtYXS9b12/yS6RujiNo=;
        b=Pa6NCv+KwmQL0zSY2kPpTkHwmUI5pE2nCXPQYiR5uRVvAVdoaINJI148nhPCQdQJZl
         seduOYB3Y3fyT7pLBVZIYZ58oFqY0bR7g9ABO6ZCh9itl/rVcY5zHN9oY24EusR7XgOv
         r1Ocrj2NJZMYx2LQSXd1P2j92b+HoM9mA8oZ0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=htr/sfVHTltSwssbIlDr5r+dfeQWoXC4b33Hv7w8lXRu2hDrFWwLiOWnzjTkYkBDS6
         jUUdHNmdtE+OH7DocxXp3smVm9dShZ3B0LZaPrR1NwCqpfo4DzZJi0phuNHnJN4ea9p0
         D04OnBLCzw92v2+80ImJXcXw3rVXA6PaUWl6s=
Received: by 10.210.62.12 with SMTP id k12mr6424284eba.140.1229251887143;
        Sun, 14 Dec 2008 02:51:27 -0800 (PST)
Received: from localhost.localdomain (abxb72.neoplus.adsl.tpnet.pl [83.8.251.72])
        by mx.google.com with ESMTPS id h4sm12215122nfh.62.2008.12.14.02.51.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 14 Dec 2008 02:51:26 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id mBEAol0s015698;
	Sun, 14 Dec 2008 11:50:57 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id mBEAoOvv015694;
	Sun, 14 Dec 2008 11:50:24 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <alpine.DEB.1.10.0812140304320.17688@asgard.lang.hm>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103063>

david@lang.hm writes:
> On Sun, 14 Dec 2008, martin wrote:
> 
> > Dear David.
> > Why do you trust VPN more than the SSH?
> > I ask because I have just removed the "first VPN then SSH" solution
> > in favor for a SSH only solution using Gitosis just to get rid of
> > the VPN which I believe is less secure than SSH (well until I read
> > you comments below).
> > I thought I was doing something right for once but maybe I'm not?
> > Thanks and best regards
> > Martin
> 
> in part it's that a VPN is a single point of control for all remote
> access.
> 
> If you use ssh you end up exposing all the individual machines
> 
> 1. data leakage of just what machines exist to possibly hostile users.

Errr... what? One of established practices is expose only _one_
machine to outside; you have to SSH to gateway.
 
> 2. the many machines are configured seperatly, frequently by different
> people. this makes it far more likely that sometime some machine will
> get misconfigured.

See above.

> 3. people who are focused on providing features have a strong
> temptation to cut corners and just test that the feature works and not
> test that everything that isn't supposed to work actually doesn't
> work. as a result, in many companies there is a deliberate seperation
> (and tension) between a group focused on controlling and auditing
> access and one that is focused on creating fucntionality and features.

And that differs from VPN in what way?

> also from a polical/social point of view everyone recognises that if
> you grant someone VPN access you are trusting them, but people don't
> seem to think the same way with ssh.

Errr... what?  I think everybody knows that unrestricted SSH access
(without limiting done by shell used) means that you trust user.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
