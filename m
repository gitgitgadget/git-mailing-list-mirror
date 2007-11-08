From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Inconsistencies with git log
Date: Wed, 7 Nov 2007 19:09:11 -0500
Message-ID: <9e4733910711071609t3e5412f1mf02e501b2d820bb3@mail.gmail.com>
References: <9e4733910711071415i1729e277u6be19b72cd682a85@mail.gmail.com>
	 <Pine.LNX.4.64.0711072242230.4362@racer.site>
	 <9e4733910711071445p7cfb6cffx83adb1d84d6bf9d8@mail.gmail.com>
	 <Pine.LNX.4.64.0711072255420.4362@racer.site>
	 <9e4733910711071503va92a653s25fd978989d5917d@mail.gmail.com>
	 <Pine.LNX.4.64.0711072309380.4362@racer.site>
	 <9e4733910711071529m604f3b12v29b3a040074ea4e@mail.gmail.com>
	 <Pine.LNX.4.64.0711080003080.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Nov 08 01:09:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ipuxb-0002we-Vm
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 01:09:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754856AbXKHAJN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 19:09:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754304AbXKHAJM
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 19:09:12 -0500
Received: from wa-out-1112.google.com ([209.85.146.180]:62997 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754203AbXKHAJL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 19:09:11 -0500
Received: by wa-out-1112.google.com with SMTP id v27so3040570wah
        for <git@vger.kernel.org>; Wed, 07 Nov 2007 16:09:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=esk1R+QHpBwFMC4++DbKDhFgwdLsH5TkG46q7Nw6ad0=;
        b=oSZ9RFhd/L/ccSc5LWo1/6E3Q9xfhcHBap590qTylcIvKJbnVk9vT951Rd/mwekf3DKJR27RmrCQvXNjRRIuHgBzm1TAATZBEbGxyeJtrl+25739fFgo1+F10Uw0uo9pR1KDNZ0kqFH6UPfj/R9xwz8pNnX8vJZBmmweptjUW1Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iyXzzLAfI5sTtr7ShTTeH+eBZMxosbQs+kkzH9lNnR9me0tMzK9iUxnk+jum8ukSNEFXzC6MVO4cd1MjG/iWfJJbqlmWdNeBw4tygWPmen275CLumoCRlSKPBwPSFtjgJqZkzxRw2xrlajk0GWrgsTsc6EP1hSFWlROJUVi79IU=
Received: by 10.114.94.1 with SMTP id r1mr8197673wab.1194480551239;
        Wed, 07 Nov 2007 16:09:11 -0800 (PST)
Received: by 10.115.54.19 with HTTP; Wed, 7 Nov 2007 16:09:11 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0711080003080.4362@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63901>

On 11/7/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> It is consistent, when you realise that the path arguments are interpreted
> relative to the project root.

Then why doesn't this work?

jonsmirl@terra:~/mpc5200b$ git log Documentation
all the log for Documentation....
jonsmirl@terra:~/mpc5200b$ cd Documentation
jonsmirl@terra:~/mpc5200b/Documentation$ git log Documentation
fatal: ambiguous argument 'Documentation': unknown revision or path
not in the working tree.
Use '--' to separate paths from revisions
jonsmirl@terra:~/mpc5200b/Documentation$



>
> Hth,
> Dscho
>
>


-- 
Jon Smirl
jonsmirl@gmail.com
