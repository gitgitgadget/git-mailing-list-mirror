From: Darrin Thompson <darrint@progeny.com>
Subject: Re: Dump http servers still slow?
Date: Mon, 01 Aug 2005 09:03:57 -0500
Message-ID: <1122905037.4042.1.camel@localhost.localdomain>
References: <1122584423.12374.11.camel@localhost.localdomain>
	 <7vy87qpcwg.fsf@assigned-by-dhcp.cox.net>
	 <1122645821.4263.6.camel@localhost.localdomain>
	 <7v1x5ftqn5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, barkalow@iabervon.org
X-From: git-owner@vger.kernel.org Mon Aug 01 16:06:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DzavF-0004ZZ-RI
	for gcvg-git@gmane.org; Mon, 01 Aug 2005 16:05:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262052AbVHAOFM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 1 Aug 2005 10:05:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262047AbVHAOFM
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Aug 2005 10:05:12 -0400
Received: from zealot.progeny.com ([216.37.46.162]:63650 "EHLO
	morimoto.progeny.com") by vger.kernel.org with ESMTP
	id S262052AbVHAOD7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2005 10:03:59 -0400
Received: from dhcp-2-246.progeny.com (dhcp-2-246.progeny.com [192.168.2.246])
	by morimoto.progeny.com (Postfix) with ESMTP
	id 5EB5A636AC; Mon,  1 Aug 2005 09:03:58 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v1x5ftqn5.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.2.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, 2005-07-30 at 23:51 -0700, Junio C Hamano wrote:
> Darrin Thompson <darrint@progeny.com> writes:
> 
> > 1. Pack files should reduce the number of http round trips.
> > 2. What I'm seeing when I check out mainline git is the acquisition of a
> > single large pack, then 600+ more recent objects. Better than before,
> > but still hundreds of round trips.
> 
> I've packed the git.git repository, by the way.  It has 43
> unpacked objects totalling 224 kilobytes, so cloning over dumb
> http should go a lot faster until we accumulate more unpacked
> objects.

I did a pull from the office and the times were 27 sec for http and 17
sec for rsync. So the moral of the story should be that frequent repacks
are sufficient for decent http performance.

--
Darrin
