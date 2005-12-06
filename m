From: Artem Khodush <greenkaa@gmail.com>
Subject: Re: announce: git browser
Date: Tue, 6 Dec 2005 10:31:55 +0300
Message-ID: <40b2b7d90512052331s22adb055y9f99b8cafe20c0c3@mail.gmail.com>
References: <40b2b7d90512041623g1e22fecai9470ffcb94f40a58@mail.gmail.com>
	 <20051205004238.GE22159@pasky.or.cz>
	 <40b2b7d90512041720i65f63ee1pcfe32d2c0c3c357b@mail.gmail.com>
	 <20051205232626.GH22159@pasky.or.cz>
	 <40b2b7d90512052240t778f1c8kf182ff065687068c@mail.gmail.com>
	 <7voe3u67ik.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 06 08:33:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EjXIu-0007SJ-M1
	for gcvg-git@gmane.org; Tue, 06 Dec 2005 08:32:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751464AbVLFHb5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Dec 2005 02:31:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751465AbVLFHb5
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Dec 2005 02:31:57 -0500
Received: from nproxy.gmail.com ([64.233.182.207]:54732 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751464AbVLFHb5 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 6 Dec 2005 02:31:57 -0500
Received: by nproxy.gmail.com with SMTP id x29so97186nfb
        for <git@vger.kernel.org>; Mon, 05 Dec 2005 23:31:55 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Lwy1FsBRL21wRO807oREXCSxRzPUeSeCcyGLEU5vVjp+H4hsdPOQTP+A4ivOfxicV12aF/G3F1f6P52a8XK6vvh54IMi632q+6UVmuk1FDXtBViHubXFvkbdn9sOXatiZoyRaDWVbOB3s/p6Ut03cVKpTPP1fiAgWvP+b+mENrE=
Received: by 10.48.211.20 with SMTP id j20mr27674nfg;
        Mon, 05 Dec 2005 23:31:55 -0800 (PST)
Received: by 10.48.216.3 with HTTP; Mon, 5 Dec 2005 23:31:55 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7voe3u67ik.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13261>

> I think there are at least two web interfaces already

The web does not care how many web pages it has :-)

> This is not to discourage yet another web based one, but I wish
> there were an NNTP interface, that feeds each repository/branch
> as a newsgroup and each commit as if it is "git-format-patch"
> output, with References: pointing at its parent commit "articles".
>
> A merge commit would probably become a multipart with usually 2
> attachments (but N attachments for a N-way octopus), showing
> diff from each branch.

I'll see if I can do something with Perl and Net::NNTP..
