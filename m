From: David Lang <david.lang@digitalinsight.com>
Subject: Re: GIT 0.99.8d
Date: Sun, 16 Oct 2005 22:29:22 -0700 (PDT)
Message-ID: <Pine.LNX.4.62.0510162228070.28691@qynat.qvtvafvgr.pbz>
References: <7vachadnmy.fsf@assigned-by-dhcp.cox.net><200510161024.37873.tomlins@cam.org> <7vll0txqwu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Ed Tomlinson <tomlins@cam.org>, git@vger.kernel.org,
	linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 17 07:31:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ERNZx-0008SW-KX
	for gcvg-git@gmane.org; Mon, 17 Oct 2005 07:30:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932201AbVJQF3t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 17 Oct 2005 01:29:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932204AbVJQF3t
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Oct 2005 01:29:49 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:29124 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP id S932201AbVJQF3s
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Oct 2005 01:29:48 -0400
Received: from no.name.available by warden.diginsite.com
          via smtpd (for vger.kernel.org [209.132.176.167]) with SMTP; Sun, 16 Oct 2005 22:29:45 -0700
Received: from wlvexc02.digitalinsight.com ([10.201.10.15]) by wlvims02.corp.ad.diginsite.com with InterScan Messaging Security Suite; Sun, 16 Oct 2005 22:29:24 -0700
Received: by wlvexc02.diginsite.com with Internet Mail Service (5.5.2657.72)
	id <VAKDLFT3>; Sun, 16 Oct 2005 22:28:15 -0700
Received: from dlang.diginsite.com ([10.201.10.67]) by wlvexc00.digitalinsight.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2657.72)
	id VAKHLD3H; Sun, 16 Oct 2005 22:25:11 -0700
To: Junio C Hamano <junkio@cox.net>
X-X-Sender: dlang@dlang.diginsite.com
In-Reply-To: <7vll0txqwu.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: dlang@dlang.diginsite.com
In-Reply-To: <7vll0txqwu.fsf@assigned-by-dhcp.cox.net>
References: <7vachadnmy.fsf@assigned-by-dhcp.cox.net><200510161024.37873.tomlins@cam.org>
 <7vll0txqwu.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10178>

when I recently installed git 0.99.8c on my gentoo system it died during 
the install without curl installed, but worked once curl was installed. (I 
haven't gotten around to reporting th packaging bug to gentoo yet)

David Lang

  On Sun, 
16 Oct 2005, Junio C Hamano wrote:

> Date: Sun, 16 Oct 2005 11:22:57 -0700
> From: Junio C Hamano <junkio@cox.net>
> To: Ed Tomlinson <tomlins@cam.org>
> Cc: git@vger.kernel.org, linux-kernel@vger.kernel.org
> Subject: Re: GIT 0.99.8d
> 
> Ed Tomlinson <tomlins@cam.org> writes:
>
> (Obligatory "do not top post" request omitted)
>
>> Debian users beware.  This version introduces a dependency - package:
>> libcurl3-gnutls-dev
>> is now needed to build git.
>
> Is this really true?  The one I uploaded was built on this
> machine:
>
> : siamese; dpkg -l libcurl\* | sed -ne 's/^ii  //p'
> libcurl3          7.14.0-2       Multi-protocol file transfer library, now wi
> libcurl3-dev      7.14.0-2       Development files and documentation for libc
>
> Having said that, a tested patch to debian/control to adjust
> Build-Depends is much appreciated.
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
