From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Be more verbose when checkout takes a long time
Date: Sat, 23 Feb 2008 14:32:35 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0802231430100.21332@woody.linux-foundation.org>
References: <alpine.LFD.1.00.0802231323590.21332@woody.linux-foundation.org> <7v8x1b1fiu.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 23 23:33:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JT2vz-0005ze-Ha
	for gcvg-git-2@gmane.org; Sat, 23 Feb 2008 23:33:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753774AbYBWWc4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2008 17:32:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753843AbYBWWc4
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Feb 2008 17:32:56 -0500
Received: from smtp1.linux-foundation.org ([207.189.120.13]:38574 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753578AbYBWWcz (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Feb 2008 17:32:55 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1NMWZL4004371
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 23 Feb 2008 14:32:37 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1NMWZcC017942;
	Sat, 23 Feb 2008 14:32:35 -0800
In-Reply-To: <7v8x1b1fiu.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-3.09 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 207.189.120.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74866>



On Sat, 23 Feb 2008, Junio C Hamano wrote:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
> 
> > So I find it irritating when git thinks for a long time without telling me 
> > what's taking so long. And by "long time" I definitely mean less than two 
> > seconds, which is already way too long for me.
> 
> Do you mean more than two or less than two?

I mean that "long time" starts at a point that is less than two seconds.

Anything over a second is a long time for me.

> Geez you are impatient ;-).

I like to call it "discerning in my time usage".

> The other user of start_progress_delay uses 95% as cutoff.  and
> probably 50% was too low, but that may just be bikeshedding.

I did think that 50% was a bit low, and considered upping it to 75, but 
with the one-second thing it wasn't as much of a deal any more. 

> I agree.  Perhaps we can add some message when "-m" codepath
> falls back to the three-way merge to make "merge-error" less
> scary.  Perhaps like:

Sounds sane to me.

		Linus
