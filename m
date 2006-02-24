From: Carl Baldwin <cnb@fc.hp.com>
Subject: Re: [PATCH] diff-delta: produce optimal pack data
Date: Fri, 24 Feb 2006 11:35:54 -0700
Organization: Hewlett Packard
Message-ID: <20060224183554.GA31247@hpsvcnb.fc.hp.com>
References: <Pine.LNX.4.64.0602212043260.5606@localhost.localdomain> <7v4q2pf8fq.fsf@assigned-by-dhcp.cox.net> <20060224174422.GA13367@hpsvcnb.fc.hp.com> <Pine.LNX.4.64.0602241252300.31162@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 24 19:36:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FChnM-000486-Mc
	for gcvg-git@gmane.org; Fri, 24 Feb 2006 19:36:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932419AbWBXSf4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Feb 2006 13:35:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932420AbWBXSf4
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Feb 2006 13:35:56 -0500
Received: from atlrel6.hp.com ([156.153.255.205]:32408 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S932419AbWBXSfz (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Feb 2006 13:35:55 -0500
Received: from smtp1.fc.hp.com (smtp.fc.hp.com [15.15.136.127])
	by atlrel6.hp.com (Postfix) with ESMTP id F3FF534332;
	Fri, 24 Feb 2006 13:35:54 -0500 (EST)
Received: from hpsvcnb.fc.hp.com (hpsvcnb.fc.hp.com [15.6.94.42])
	by smtp1.fc.hp.com (Postfix) with ESMTP id C2C266EA2;
	Fri, 24 Feb 2006 18:35:54 +0000 (UTC)
Received: by hpsvcnb.fc.hp.com (Postfix, from userid 21523)
	id B4812BFA3; Fri, 24 Feb 2006 11:35:54 -0700 (MST)
To: Nicolas Pitre <nico@cam.org>
Mail-Followup-To: Nicolas Pitre <nico@cam.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0602241252300.31162@localhost.localdomain>
X-Origin: hpsvcnb.fc.hp.com
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16724>

On Fri, Feb 24, 2006 at 12:56:04PM -0500, Nicolas Pitre wrote:
My version is 1.2.1.  I have not been following your work.  When was
pack data reuse introduced?  From where can I obtain your delta patches?

There is really no opportunity for pack-data reuse in this case.  The
repository had never been packed or cloned in the first place.  As I
said, I do not intend to pack these binary files at all since there is
no benefit in this case.

The delta patches may help but I can't say for sure since I don't know
anything about them.  Let me know where I can get them.

Carl

> 
> I must ask if you had applied my latest delta patches?
> 
> Also did you use a recent version of git that implements pack data 
> reuse?
> 
> 
> Nicolas
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 Carl Baldwin                        RADCAD (R&D CAD)
 Hewlett Packard Company
 MS 88                               work: 970 898-1523
 3404 E. Harmony Rd.                 work: Carl.N.Baldwin@hp.com
 Fort Collins, CO 80525              home: Carl@ecBaldwin.net
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
