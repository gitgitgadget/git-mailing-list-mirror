From: Russ Allbery <rra@stanford.edu>
Subject: Re: Trying to use AUTHOR_DATE
Date: Fri, 29 Apr 2005 21:32:30 -0700
Organization: The Eyrie
Message-ID: <87zmvganq9.fsf@windlord.stanford.edu>
References: <B8E391BBE9FE384DAA4C5C003888BE6F035EDE2C@scsmsx401.amr.corp.intel.com>
	<42730061.5010106@zytor.com>
	<Pine.LNX.4.58.0504292101230.2296@ppc970.osdl.org>
	<Pine.LNX.4.58.0504292114580.2296@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Apr 30 06:27:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRjZ4-0002Ts-4v
	for gcvg-git@gmane.org; Sat, 30 Apr 2005 06:26:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262505AbVD3Ecd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Apr 2005 00:32:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262508AbVD3Ecd
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Apr 2005 00:32:33 -0400
Received: from smtp2.Stanford.EDU ([171.67.16.125]:37540 "EHLO
	smtp2.Stanford.EDU") by vger.kernel.org with ESMTP id S262505AbVD3Ecc
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Apr 2005 00:32:32 -0400
Received: from windlord.stanford.edu (windlord.Stanford.EDU [171.64.19.147])
	by smtp2.Stanford.EDU (8.12.11/8.12.11) with SMTP id j3U4WU8a030722
	for <git@vger.kernel.org>; Fri, 29 Apr 2005 21:32:31 -0700
Received: (qmail 8572 invoked by uid 1000); 30 Apr 2005 04:32:30 -0000
To: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0504292114580.2296@ppc970.osdl.org> (Linus
 Torvalds's message of "Fri, 29 Apr 2005 21:22:27 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4 (Jumbo Shrimp, linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> It also seems to do so in a particularly stupid way, and David
> Woodhouses suggestion of just using mktime() on Jan 1st, 1970, seems to
> be much simpler than what curl does.

Because of daylight savings time, this doesn't actually work.  I know from
personal experience; this is the tactic that I took at first when writing
INN's date parser and was educated by test failures.

-- 
Russ Allbery (rra@stanford.edu)             <http://www.eyrie.org/~eagle/>
