From: Matthias Kestenholz <mk@spinlock.ch>
Subject: Re: Howto request: going home in the middle of something?
Date: Tue, 23 Oct 2007 22:28:46 +0200
Message-ID: <256C87B5-3ADE-4A96-9530-A45B97601BAA@spinlock.ch>
References: <200710181144.22655.wielemak@science.uva.nl> <20071018112758.GN18279@machine.or.cz> <200710221044.24191.wielemak@science.uva.nl> <20071023135655.x6g6mln1j4880wog@intranet.digizenstudio.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jan Wielemaker <wielemak@science.uva.nl>,
	Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
To: Jing Xue <jingxue@digizenstudio.com>
X-From: git-owner@vger.kernel.org Tue Oct 23 22:29:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkQN7-0003w8-UV
	for gcvg-git-2@gmane.org; Tue, 23 Oct 2007 22:29:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752262AbXJWU2y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2007 16:28:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752238AbXJWU2y
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Oct 2007 16:28:54 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:51326 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751684AbXJWU2y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2007 16:28:54 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1256774nfb
        for <git@vger.kernel.org>; Tue, 23 Oct 2007 13:28:52 -0700 (PDT)
Received: by 10.86.1.1 with SMTP id 1mr665694fga.1193171331887;
        Tue, 23 Oct 2007 13:28:51 -0700 (PDT)
Received: from ?192.168.1.87? ( [83.78.113.143])
        by mx.google.com with ESMTPS id 22sm13000065fkr.2007.10.23.13.28.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 23 Oct 2007 13:28:50 -0700 (PDT)
In-Reply-To: <20071023135655.x6g6mln1j4880wog@intranet.digizenstudio.com>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62157>

Hi,

On 23.10.2007, at 19:56, Jing Xue wrote:
> What does the extra branch gain for us here? That's not a  
> rhetorical question, I'm actually curious to learn, because I  
> always just commit, switch to another computer, pull, and reset HEAD^.

If someone tracks the main branch you are working on and fetches
while you are travelling home, he has the WIP commit as a new tip
in his tree.
If he bases further work upon the WIP commit, he'll need to rebase
or merge his changes onto your new tip once you have amended or
replaced the commit. If you are working on the
master branch, you should really avoid rewinding it. Rewinding topic
branches is ok, but a temporary branch is still better to clearly tell
potential fetch-ers that this is only Work in Progress, and not meant
to be published in the current state.

Matthias

-- 
http://spinlock.ch/blog/
