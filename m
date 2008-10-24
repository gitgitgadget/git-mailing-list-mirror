From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git performance
Date: Fri, 24 Oct 2008 12:06:37 -0700 (PDT)
Message-ID: <m3zlkthkta.fsf@localhost.localdomain>
References: <000901c93490$e0c40ed0$a24c2c70$@com>
	<20081023163912.GA11489@coredump.intra.peff.net>
	<000001c9358f$232bac70$69830550$@com>
	<20081024142947.GB11568@coredump.intra.peff.net>
	<dfdaadcd0810241042k1469fc30x62daa19273404edc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "George Shammas" <georgyo@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 24 21:08:05 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtS0q-0000Z0-Cf
	for gcvg-git-2@gmane.org; Fri, 24 Oct 2008 21:07:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751556AbYJXTGm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Oct 2008 15:06:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752505AbYJXTGm
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Oct 2008 15:06:42 -0400
Received: from ey-out-2122.google.com ([74.125.78.27]:42603 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750930AbYJXTGl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Oct 2008 15:06:41 -0400
Received: by ey-out-2122.google.com with SMTP id 6so354110eyi.37
        for <git@vger.kernel.org>; Fri, 24 Oct 2008 12:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=kYHG/17M5SXMeOgWz2pZVL3w1/4RbjjEtS4YJNRkAhg=;
        b=FVD8Mc8v8U83PousB4vmaS3aYz8ZZTN8WEWOl53rprLobuMg5RtgD4zlt/dA0ZnHPF
         a4TgZS14p+J9lfxgoEX/LC4JHEJ8PavYFsCzVJ6c9qknIQAt8+N8TxV6PpYrFxbsbi5K
         oOUv4tnXryGdCUjQ5CuFqo4hAYqXSAnyrQryo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=QVc2D5EuE974YXDxqo2QwmL6ikgY+Kjxwl+vQqd2FxwX8j5AteRybxYUf6h6LmoJ17
         arp3r4Bf57Eb4yUN0i1J1NGPvhedoms5Is88rRfK+7/qajfe3JhIoA57fPjKBIcUH6q1
         46/XpHwj35X619JcKWMWsF2od3S083wZLVcwc=
Received: by 10.210.30.1 with SMTP id d1mr2789429ebd.31.1224875199306;
        Fri, 24 Oct 2008 12:06:39 -0700 (PDT)
Received: from localhost.localdomain (abwm208.neoplus.adsl.tpnet.pl [83.8.236.208])
        by mx.google.com with ESMTPS id 5sm801120eyf.8.2008.10.24.12.06.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 24 Oct 2008 12:06:37 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m9OJ9XDO023259;
	Fri, 24 Oct 2008 21:09:43 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m9OJ9Moq023255;
	Fri, 24 Oct 2008 21:09:22 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <dfdaadcd0810241042k1469fc30x62daa19273404edc@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99050>

"George Shammas" <georgyo@gmail.com> writes:

> If you are really trying to backup a filesystem, you may want to look
> at a filesystem that can do snapshots, it would be a lot more
> efficient then a version control system.  Such as NILFS and ZFS.
> 
> http://en.wikipedia.org/wiki/NILFS
> http://en.wikipedia.org/wiki/ZFS

Or ext3cow, or (currently in early stages of development) Tux3

  http://en.wikipedia.org/wiki/Ext3cow
  http://en.wikipedia.org/wiki/Tux3

-- 
Jakub Narebski
Poland
ShadeHawk on #git
