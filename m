From: Carl Baldwin <cnb@fc.hp.com>
Subject: Re: [Question] info/grafts file.
Date: Mon, 14 Nov 2005 17:03:49 -0700
Organization: Hewlett Packard
Message-ID: <20051115000349.GA32136@hpsvcnb.fc.hp.com>
References: <20051114182019.GA19105@hpsvcnb.fc.hp.com> <7vhdafx81m.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 15 01:05:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EboIt-0001Dq-B8
	for gcvg-git@gmane.org; Tue, 15 Nov 2005 01:04:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932252AbVKOADz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Nov 2005 19:03:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932253AbVKOADz
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Nov 2005 19:03:55 -0500
Received: from atlrel8.hp.com ([156.153.255.206]:23002 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S932252AbVKOADz (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Nov 2005 19:03:55 -0500
Received: from smtp1.fc.hp.com (smtp.fc.hp.com [15.11.136.119])
	by atlrel8.hp.com (Postfix) with ESMTP id C9CD44992;
	Mon, 14 Nov 2005 19:03:54 -0500 (EST)
Received: from hpsvcnb.fc.hp.com (hpsvcnb.fc.hp.com [15.6.94.42])
	by smtp1.fc.hp.com (Postfix) with ESMTP
	id 98B9A380C5; Tue, 15 Nov 2005 00:03:49 +0000 (UTC)
Received: by hpsvcnb.fc.hp.com (Postfix, from userid 21523)
	id 806ECB614; Mon, 14 Nov 2005 17:03:49 -0700 (MST)
To: Junio C Hamano <junkio@cox.net>
Mail-Followup-To: Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vhdafx81m.fsf@assigned-by-dhcp.cox.net>
X-Origin: hpsvcnb.fc.hp.com
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11870>

This is fine, I just needed to know.

How hard is it to, in a generic way, take a grafts file and reconstruct
commits to include the parents in the graft file in the actual tree?  I
am wondering because I couldn't, after much work, get git-svnimport to
find my merges correctly.  So, I am needing to hand-graft some merges in
to make things right.  Any suggestions?  I could try to figure something
out if I can find some time.  I'm good with graph traversals and such.

Carl

On Mon, Nov 14, 2005 at 12:56:37PM -0800, Junio C Hamano wrote:
> Grafts are considered local preference, and not copied when
> cloned.  I am unsure this was a right decision, but that is how
> things are right now.
> 

-- 
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 Carl Baldwin                        Systems VLSI Laboratory
 Hewlett Packard Company
 MS 88                               work: 970 898-1523
 3404 E. Harmony Rd.                 work: Carl.N.Baldwin@hp.com
 Fort Collins, CO 80525              home: Carl@ecBaldwin.net
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
