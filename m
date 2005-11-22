From: Nikolai Weibull <mailing-lists.git@rawuncut.elitemail.org>
Subject: Re: Get rid of .git/branches/ and .git/remotes/?
Date: Tue, 22 Nov 2005 20:12:34 +0100
Message-ID: <20051122191234.GA9040@puritan.petwork>
References: <20051122041843.9436.qmail@science.horizon.com> <4382DFDA.6040306@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Nov 22 20:17:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EedZJ-0006A0-4Q
	for gcvg-git@gmane.org; Tue, 22 Nov 2005 20:12:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965105AbVKVTMh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Nov 2005 14:12:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965124AbVKVTMh
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Nov 2005 14:12:37 -0500
Received: from mxfep02.bredband.com ([195.54.107.73]:16035 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S965105AbVKVTMg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Nov 2005 14:12:36 -0500
Received: from ironport.bredband.com ([195.54.107.82] [195.54.107.82])
          by mxfep02.bredband.com with ESMTP
          id <20051122191234.NJDE9142.mxfep02.bredband.com@ironport.bredband.com>
          for <git@vger.kernel.org>; Tue, 22 Nov 2005 20:12:34 +0100
Received: from c-fa2b70d5.018-10-67626713.cust.bredbandsbolaget.se (HELO puritan.petwork) ([213.112.43.250])
  by ironport.bredband.com with ESMTP; 22 Nov 2005 20:11:51 +0100
X-BrightmailFiltered: true
X-IronPort-AV: i="3.97,362,1125871200"; 
   d="scan'208"; a="12211269:sNHT33422472"
Received: by puritan.petwork (Postfix, from userid 1000)
	id D4CEAADFE5; Tue, 22 Nov 2005 20:12:34 +0100 (CET)
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <4382DFDA.6040306@op5.se>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12567>

Andreas Ericsson wrote:

> Excellent error messages aren't good enough. It's ok for Python, since
> that's a programming language. We can expect infinitely more from
> programmers than we can from users.

A semi-related question: who is the target audience of git?  I get the
feeling that most users will be programmers, so that's kind of a
non-argument (even though I agree with your standpoint).

Furthermore, does it really matter what format .git/config has now that
we have git-config-set?  Shouldn't all access go through that command,
so that we can change to some other format (YAML, XML, STUPIDABBR) if we
so desire without breaking anything?

Finally, a plain-text easy-to-edit format is great, and that's a good
enough argument not to use indentation (as has already been pointed out,
indentation is not always what it seems).

        nikolai

-- 
Nikolai Weibull: now available free of charge at http://bitwi.se/!
Born in Chicago, IL USA; currently residing in Gothenburg, Sweden.
main(){printf(&linux["\021%six\012\0"],(linux)["have"]+"fun"-97);}
