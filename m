From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: is gitosis secure?
Date: Wed, 4 Feb 2009 13:12:04 +0100
Message-ID: <20090204121204.GA12393@cuci.nl>
References: <200812090956.48613.thomas@koch.ro> <1228813453.28186.73.camel@maia.lan> <873afgsul8.fsf@mid.deneb.enyo.de> <200901180650.06605.bss@iguanasuicide.net> <20090203213135.GA1970@eagain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>,
	Florian Weimer <fw@deneb.enyo.de>, git@vger.kernel.org
To: Tommi Virtanen <tv@eagain.net>
X-From: git-owner@vger.kernel.org Wed Feb 04 13:13:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUgdP-0000CP-25
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 13:13:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752605AbZBDMMM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 07:12:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750892AbZBDMMK
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 07:12:10 -0500
Received: from aristoteles.cuci.nl ([212.125.128.18]:48890 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750782AbZBDMMJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 07:12:09 -0500
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id 4EB9E542D; Wed,  4 Feb 2009 13:12:04 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20090203213135.GA1970@eagain.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108340>

Tommi Virtanen wrote:
>Summary: I fully expect gitosis to be more secure than a manually
>maintained git-shell over SSH setup, mostly because it can make
>human errors more rare.

I installed gitosis a year ago.
Then I tried to audit the code.
I couldn't, the whole thing is too much spaghetti code.
I.e. the individual python routines might be well written, but there
is no concise overview in 10 lines max which can explain to me what
happens which might or might not open up security holes.  There are too
many pieces of code depending on each other.

I.e. if you trust the author not to have made any mistakes, then it
is probably secure.
Auditing gitosis turned out to be too painful to be worth the trouble,
so I reverted to a manually maintained git-shell solution which is so
simple that I can actually audit it, and therefore is provably secure
(which gitosis is not).
-- 
Sincerely,
           Stephen R. van den Berg.
Humor in the Court:  Q: What happened then?  A: He told me, he says,
"I have to kill you because you can identify me."  Q: Did he kill you?  A: No.
