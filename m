From: Scott Lamb <slamb@slamb.org>
Subject: Re: git-p4import.py robustness changes
Date: Sat, 2 Jun 2007 16:21:34 -0700
Message-ID: <87F9A283-C51F-49FB-9A13-40E850AC0474@slamb.org>
References: <4ACE2ABC-8D73-4097-87AC-F3B27EDA97DE@slamb.org> <7vbqg01reo.fsf@assigned-by-dhcp.cox.net> <0EDF1E14-3682-4B1E-A7D2-F82388F752AA@slamb.org> <7vzm3inisa.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Jun 03 01:21:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hucum-000822-Ni
	for gcvg-git@gmane.org; Sun, 03 Jun 2007 01:21:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760064AbXFBXVi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Jun 2007 19:21:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761989AbXFBXVi
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jun 2007 19:21:38 -0400
Received: from hobbes.slamb.org ([208.78.103.243]:57089 "EHLO hobbes.slamb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760064AbXFBXVi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jun 2007 19:21:38 -0400
Received: from [172.16.1.4] (ppp-71-139-179-187.dsl.snfc21.pacbell.net [71.139.179.187])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by hobbes.slamb.org (Postfix) with ESMTP id 483D4980AA;
	Sat,  2 Jun 2007 16:21:36 -0700 (PDT)
In-Reply-To: <7vzm3inisa.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48959>


On Jun 2, 2007, at 2:33 PM, Junio C Hamano wrote:

> A much more preferable alternative is for you to say "Hey, don't
> say you want to demote it.  I'll keep it maintained, I regularly
> use p4 and have a strong incentive to keep it working".  Then we
> do not have to do the "patch 0" ;-)

Hmm. I'd like to say that, but keep in mind that I'd never even used  
git before Wednesday, and I'm not sure yet how well git-p4import.py  
will work out for me.

It'd be a huge leap from git-p4import.py to something that could  
remove my need to use p4 commands daily. First, I'd need something  
that could follow all upstream branches with merge history. Then I'd  
either need to convince my team to ditch p4 entirely (not easy, and  
then I wouldn't use/maintain git-p4import.py afterward anyway) or a  
way to robustly generate "p4 integrate", "p4 resolve", "p4 submit"  
command sequences to merge between upstream branches.

We're attempting to address more modest needs, like those of our off- 
site contractors who should only be sending patches anyway. (Another  
guy wrote a script that pulls changes into an svn mirror basically by  
"svn ci -m 'changed some stuff'" every half hour, but I made fun of  
it and now have to replace it. ;)

I'll at least finish up the other patches first and see how it goes.

-- 
Scott Lamb <http://www.slamb.org/>
