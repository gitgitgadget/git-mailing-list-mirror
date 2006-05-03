From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: gitk highlight feature
Date: Tue, 2 May 2006 17:07:23 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605021659430.4086@g5.osdl.org>
References: <17495.61142.677439.171773@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 03 02:07:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fb4tu-0008Oi-1v
	for gcvg-git@gmane.org; Wed, 03 May 2006 02:07:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965049AbWECAH1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 May 2006 20:07:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965052AbWECAH1
	(ORCPT <rfc822;git-outgoing>); Tue, 2 May 2006 20:07:27 -0400
Received: from smtp.osdl.org ([65.172.181.4]:15320 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965049AbWECAH0 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 May 2006 20:07:26 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4307OtH007000
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 2 May 2006 17:07:25 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4307Nm0019777;
	Tue, 2 May 2006 17:07:24 -0700
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17495.61142.677439.171773@cargo.ozlabs.ibm.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19447>



On Wed, 3 May 2006, Paul Mackerras wrote:
>
> I just pushed out some changes to gitk which allow you to use one view
> to highlight another (see the "Highlight" submenu under the "View"
> menu), and which allow you to specify arbitrary git-rev-list arguments
> for a view.  The arguments string uses shell quoting conventions.

Ok. It looks interesting. I don't have a particular issue to try it with, 
but the bold-face certainly stands out enough that it was easy to ask for 
a high-light of any commits that changed the kernel/ subdirectory, and it 
was visually very obvious.

The interface does feel a bit awkward, though. Separating out "view" and 
"highlight" into two separate things seems wrong. Wouldn't it be better to 
just have multiple views in the "view" menu, and just a way to mark one or 
more of them as "highliht views". 

Ie not a separate menu, but having the current "view" radio buttons be 
more flexible. 

> I had been thinking of having fields in the view editor dialog where
> you could put in refs that you did and didn't want included, date
> specifiers, etc., all in separate fields with suitable labels.  Now
> I'm thinking that it's probably just as convenient to put
> "ORIG_HEAD.." into the git-rev-list arguments field as it is to put
> "ORIG_HEAD" in the "Don't include commits reachable from this" field.

Yeah. I think it's easier with a single thing, just let people stick it 
there.

> There may be an argument for having fields for "Exclude commits before
> this date" and "Exclude commits after this date", because those things
> often have spaces in them (e.g. "2 weeks ago") which would have to be
> quoted in the git-rev-list arguments field.

I alwaus use "2.weeks.ago" instead, but I guess you could do a calendar 
widget or something.

		Linus
