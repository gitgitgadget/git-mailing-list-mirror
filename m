From: Kalle Valo <Kalle.Valo@iki.fi>
Subject: Re: [RFC] undo and redo
Date: Thu, 25 Aug 2005 20:39:05 +0300
Message-ID: <87u0hdor0m.fsf@litku.valo.iki.fi>
References: <20050824172339.GA7083@hpsvcnb.fc.hp.com>
	<20050824181004.GA18790@hpsvcnb.fc.hp.com>
	<Pine.LNX.4.58.0508241148480.3317@g5.osdl.org>
	<20050824195615.GA693@hpsvcnb.fc.hp.com>
	<Pine.LNX.4.63.0508241634350.23242@iabervon.org>
	<20050824204736.GA13194@hpsvcnb.fc.hp.com>
	<Pine.LNX.4.63.0508241651420.23242@iabervon.org>
	<7vd5o3ar4a.fsf@assigned-by-dhcp.cox.net>
	<20050825024134.GA31886@hpsvcnb.fc.hp.com>
	<7v1x4izjtm.fsf@assigned-by-dhcp.cox.net>
	<20050825163201.GA3944@hpsvcnb.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 25 19:37:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E8Ld6-0007U1-6Z
	for gcvg-git@gmane.org; Thu, 25 Aug 2005 19:35:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932308AbVHYRfB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 Aug 2005 13:35:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932245AbVHYRfB
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Aug 2005 13:35:01 -0400
Received: from fep01-0.kolumbus.fi ([193.229.0.41]:19584 "EHLO
	fep01-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id S1751352AbVHYRfA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Aug 2005 13:35:00 -0400
Received: from litku.valo.iki.fi ([81.197.35.21]) by fep01-app.kolumbus.fi
          with ESMTP
          id <20050825173456.PWVY23558.fep01-app.kolumbus.fi@litku.valo.iki.fi>;
          Thu, 25 Aug 2005 20:34:56 +0300
To: Carl Baldwin <cnb@fc.hp.com>
In-Reply-To: <20050825163201.GA3944@hpsvcnb.fc.hp.com> (Carl Baldwin's
 message of "Thu, 25 Aug 2005 10:32:01 -0600")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7753>

Carl Baldwin <cnb@fc.hp.com> writes:

> For this, I may also use branching, as suggested.  I meant for undo/redo
> to be a lighter weight alternative to allow for a faster context switch.

I have been missing the undo command since I started to use git, so
I'll share a user's perspective. 

I was also considering undo as a really lightweight command, nothing
too fancy. Usually, I want to try implement something wild or stupid,
but almost immediately decide to abandon it. With 'git undo', this
kind of prototyping would be really easy. For me, redo would be just a
backup if (read: when) I undo something important, nothing more. For
anything else I would use branches, as was suggested.

-- 
Kalle Valo
