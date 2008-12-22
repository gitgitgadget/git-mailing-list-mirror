From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Perl 5 now uses Git for version control
Date: Mon, 22 Dec 2008 18:24:50 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0812221608410.19665@iabervon.org>
References: <a92222c80812212356p766345aaj5f4dc31ebba616aa@mail.gmail.com> <9b18b3110812220332u4cae3a89rf957cbf96af530bf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: demerphq <demerphq@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 23 00:26:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LEuAL-0004U3-Tz
	for gcvg-git-2@gmane.org; Tue, 23 Dec 2008 00:26:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755477AbYLVXYx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2008 18:24:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755511AbYLVXYx
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Dec 2008 18:24:53 -0500
Received: from iabervon.org ([66.92.72.58]:47778 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755477AbYLVXYw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2008 18:24:52 -0500
Received: (qmail 1500 invoked by uid 1000); 22 Dec 2008 23:24:50 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 22 Dec 2008 23:24:50 -0000
In-Reply-To: <9b18b3110812220332u4cae3a89rf957cbf96af530bf@mail.gmail.com>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103781>

On Mon, 22 Dec 2008, demerphq wrote:

> In true open source style, Sam Vilain converted Perl's history from
> Perforce to Git. He did the work both in his spare time and in time
> donated by his employer, Catalyst IT. He spent more than a year building
> custom tools to transform 21 years of Perl history into the first
> ever unified repository of every single change to Perl. In addition
> to changes from Perforce, Sam patched together a comprehensive view
> of Perl's history incorporating publicly available snapshot releases,
> changes from historical mailing list archives and patch sets recovered
> from the hard drives of previous Perl release engineers.

At some point, some of the custom tools were visible to the public 
(although not widely announced), and they include such things as an 
elaborate algorithm to figure out what a perforce depot's contents is 
supposed to mean in a number of weird cases. Are these going to be 
officially released, or are they considered to have served their purpose 
and be no longer interesting?

I'd be interested to see the final version, and I think it would be useful 
to anyone working on interoperation between perforce and git (even though 
the actual code needs a copy of the perforce database and is not 
incremental).

	-Daniel
*This .sig left intentionally blank*
