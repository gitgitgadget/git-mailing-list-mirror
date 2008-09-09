From: Steven Grimm <koreth@midwinter.com>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Tue, 9 Sep 2008 09:38:50 -0700
Message-ID: <10BD65EF-A44B-4A43-BEB5-0D9231332632@midwinter.com>
References: <20080909132212.GA25476@cuci.nl> <m3zlmhnx1z.fsf@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: "Stephen R. van den Berg" <srb@cuci.nl>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 09 18:40:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kd6G6-0006Xc-Ih
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 18:40:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755074AbYIIQiv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 12:38:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754557AbYIIQiv
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 12:38:51 -0400
Received: from tater.midwinter.com ([216.32.86.90]:54736 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751792AbYIIQiu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 12:38:50 -0400
Received: (qmail 24135 invoked from network); 9 Sep 2008 16:38:50 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=P3bl8l0aNaN4ChmnvimGkK7pmi60f5lvU8pJ4LHirJG79oJ541r6YSmCUrM1k2N0  ;
Received: from localhost (HELO ?IPv6:::1?) (127.0.0.1)
  by localhost with SMTP; 9 Sep 2008 16:38:50 -0000
In-Reply-To: <m3zlmhnx1z.fsf@localhost.localdomain>
X-Mailer: Apple Mail (2.926)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95405>

On Sep 9, 2008, at 8:44 AM, Jakub Narebski wrote:
> This can also lead to replacing
>
> origin <b> <a>
> origin <c> <b>
>
> by
>
> origin <c> <a>
>
> for squash merge, or squash in rebase interactive.


And, incidentally, the above representation will potentially mesh well  
with svn integration, making it possible to cleanly represent svn 1.5  
merge-tracking metadata directly in git.


> Unless of course one uses more complex merge strategy, which doesn't
> take into account only endpoints (branches to be merged and merge
> bases), but is also affected in some by history...


It does intuitively (but perhaps incorrectly) seem like the origin  
information could be used to make more intelligent decisions about  
automatic conflict resolution, if nothing else. Though obviously that  
might, as you suggest, be a pretty big departure from the way git  
merges currently work.

-Steve
