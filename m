From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Thu, 11 Sep 2008 21:44:47 +0200
Message-ID: <20080911194447.GD1451@cuci.nl>
References: <20080909132212.GA25476@cuci.nl> <alpine.LFD.1.10.0809101733050.3384@nehalem.linux-foundation.org> <20080911062242.GA23070@cuci.nl> <200809111020.55115.jnareb@gmail.com> <20080911123148.GA2056@cuci.nl> <20080911135146.GE5082@mit.edu> <20080911153202.GD2056@cuci.nl> <20080911180037.GH5082@mit.edu> <20080911190335.GB1451@cuci.nl> <alpine.LFD.1.10.0809111527030.23787@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Theodore Tso <tytso@MIT.EDU>, Jakub Narebski <jnareb@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Sep 11 21:48:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kds72-0003qs-RM
	for gcvg-git-2@gmane.org; Thu, 11 Sep 2008 21:45:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752312AbYIKTot (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2008 15:44:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753858AbYIKTot
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Sep 2008 15:44:49 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:55432 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752217AbYIKTos (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2008 15:44:48 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id 9B30B5465; Thu, 11 Sep 2008 21:44:47 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0809111527030.23787@xanadu.home>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95631>

Nicolas Pitre wrote:
>On Thu, 11 Sep 2008, Stephen R. van den Berg wrote:
>> Not quite.  Obviously all parents of p and p^ will continue to exist.
>> I.e. deleting branch B will cause all commits from p till the tip of B
>> (except p itself) to vanish.  Keeping p implies that the whole chain of
>> parents below p will continue to exist and be reachable.  That's the way
>> a git repository works.

>And that's what I called stupid in my earlier reply to you.  Either you 
>have proper branches or tags keeping P around, or deleting B brings 
>everything not reachable through other branches or tags (or reflog) 
>away too.  Otherwise there is no point making a dangling origin link 
>valid.

Well, the principle of least surprise dictates that they should be kept
by gc as described above, however...
I can envision an option to gc say "--drop-weak-links" which does
exactly what you describe.
-- 
Sincerely,
           Stephen R. van den Berg.
"There are three types of people in the world;
 those who can count, and those who can't."
