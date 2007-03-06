From: Paolo Bonzini <paolo.bonzini@lu.unisi.ch>
Subject: Re: [PATCH 1/3] git-branch: add --track and --no-track options
Date: Tue, 06 Mar 2007 08:26:19 +0100
Message-ID: <45ED179B.90500@lu.unisi.ch>
References: <esgm1m$33f$1@sea.gmane.org> <7vejo2uaxs.fsf@assigned-by-dhcp.cox.net>
Reply-To: bonzini@gnu.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Paolo Bonzini <bonzini@gnu.org>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Mar 06 08:26:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOU3y-0005FR-Ax
	for gcvg-git@gmane.org; Tue, 06 Mar 2007 08:26:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932743AbXCFH0U (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Mar 2007 02:26:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932750AbXCFH0U
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Mar 2007 02:26:20 -0500
Received: from server.usilu.net ([195.176.178.200]:23290 "EHLO mail.usilu.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932743AbXCFH0U (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2007 02:26:20 -0500
Received: from [192.168.68.211] ([192.168.68.211] RDNS failed) by mail.usilu.net over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 6 Mar 2007 08:26:18 +0100
User-Agent: Thunderbird 1.5.0.10 (Macintosh/20070221)
In-Reply-To: <7vejo2uaxs.fsf@assigned-by-dhcp.cox.net>
X-OriginalArrivalTime: 06 Mar 2007 07:26:18.0896 (UTC) FILETIME=[BB974100:01C75FC0]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41551>


> Hmm. I think your use of 'mytopic' is very good for the purpose
> of illustration. It makes clear which configuration takes name
> from what. So I like your first paragraph. However, one reason
> people like the separate remote layout is that it allows you to
> name your own branch identically with that of the other side, so
> in that sense, the description in your second paragraph matches
> the real-life usage better. What I am getting at is that (1)
> these two paragraphs are inconsistent, (2) there is a reason to
> prefer the description in the first paragraph, and (3) there is
> another reason to prefer the description in the second one.

Ok, I'll prefer using "mytopic" anywhere.

> As Johannes already pointed this out, I think allowing this to
> be controlled per remote is nice but overkill.  A single boolean
> configuration, say "branch.autosetupmerge", would suffice.

In this case, patch 2/3 should also be withdrawn, right?

Paolo
