From: Scott Lamb <slamb@slamb.org>
Subject: Re: git-p4import.py robustness changes
Date: Sat, 2 Jun 2007 13:41:55 -0700
Message-ID: <0EDF1E14-3682-4B1E-A7D2-F82388F752AA@slamb.org>
References: <4ACE2ABC-8D73-4097-87AC-F3B27EDA97DE@slamb.org> <7vbqg01reo.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Jun 02 22:42:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HuaQK-0001mF-W1
	for gcvg-git@gmane.org; Sat, 02 Jun 2007 22:42:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755956AbXFBUmA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Jun 2007 16:42:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756671AbXFBUmA
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jun 2007 16:42:00 -0400
Received: from hobbes.slamb.org ([208.78.103.243]:56270 "EHLO hobbes.slamb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755956AbXFBUmA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jun 2007 16:42:00 -0400
Received: from [172.16.1.4] (ppp-71-139-179-187.dsl.snfc21.pacbell.net [71.139.179.187])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by hobbes.slamb.org (Postfix) with ESMTP id 11F60980AB;
	Sat,  2 Jun 2007 13:41:57 -0700 (PDT)
In-Reply-To: <7vbqg01reo.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48952>


On May 31, 2007, at 4:53 PM, Junio C Hamano wrote:

> Actually, my preference is to have a "patch 0" before all of the
> above, that demotes git-p4import to contrib/ hierarchy.  Having
> no access to p4 managed repositories (nor much inclination to
> get one), I can never test nor maintain it myself, so it is just
> crazy for me to be the maintainer for it.

Will do. What does that mean for Documentation/git-p4import.txt and  
the git-p4 rpm (defined in git.spec.in)? Should I move them with it?  
(Seems nothing else in the main tree references contrib.) If so,  
maybe I should set up a common "Documentation/asciidoc.mak" or  
something for building the man/html pages rather than duplicating all  
that Makefile logic.

-- 
Scott Lamb <http://www.slamb.org/>
