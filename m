From: madmarcos <fru574@my.utsa.edu>
Subject: Re: Java Inflater problem decompressing packfile
Date: Sat, 16 Apr 2011 07:23:52 -0700 (PDT)
Message-ID: <1302963832717-6279028.post@n2.nabble.com>
References: <1302919505984-6278154.post@n2.nabble.com> <20110416063729.GC28853@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 16 16:24:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QB6Pv-00082V-4q
	for gcvg-git-2@lo.gmane.org; Sat, 16 Apr 2011 16:24:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755237Ab1DPOYD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Apr 2011 10:24:03 -0400
Received: from sam.nabble.com ([216.139.236.26]:55874 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754154Ab1DPOXy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2011 10:23:54 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.69)
	(envelope-from <fru574@my.utsa.edu>)
	id 1QB6Ph-0005lQ-2K
	for git@vger.kernel.org; Sat, 16 Apr 2011 07:23:53 -0700
In-Reply-To: <20110416063729.GC28853@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171671>

No, my inflater doesn't handle deltas, yet. 
But there are a few reasons why I don't think that's the case.
1. The project has only been pushed once to the git repository before my
tests. No updates to the git repository project or anything like that. 
2. If it were a delta, would the first 1/3 of it be completely normal and
readable? There is no pattern that I can see to the remaining 2/3. It looks
as if the characters in the 2/3 part were interleaved with the other
characters about 10 times.
3. The object type in the header is parsed as 3, or a blob. Aren't the delta
object types higher numbers than that?


--
View this message in context: http://git.661346.n2.nabble.com/Java-Inflater-problem-decompressing-packfile-tp6278154p6279028.html
Sent from the git mailing list archive at Nabble.com.
