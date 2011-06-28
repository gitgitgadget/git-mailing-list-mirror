From: Greg Price <price@MIT.EDU>
Subject: Re: Fwd: [PATCH 0/6] rebase: command "ref" and options
	--rewrite-{refs,heads,tags}
Date: Tue, 28 Jun 2011 06:56:32 -0400
Message-ID: <20110628105631.GT5771@dr-wily.mit.edu>
References: <cover.1309133817.git.greg@quora.com> <7vtybbufy2.fsf@alter.siamese.dyndns.org> <BANLkTi=Akib+7R7D2GEwV8dOTQ1vsqgfxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 28 13:01:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QbW2z-0001BD-Gk
	for gcvg-git-2@lo.gmane.org; Tue, 28 Jun 2011 13:01:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755851Ab1F1K6H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jun 2011 06:58:07 -0400
Received: from DMZ-MAILSEC-SCANNER-7.MIT.EDU ([18.7.68.36]:54950 "EHLO
	dmz-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757059Ab1F1K4e (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Jun 2011 06:56:34 -0400
X-AuditID: 12074424-b7bc6ae000005a77-03-4e09b361ddd3
Received: from mailhub-auth-2.mit.edu ( [18.7.62.36])
	by dmz-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 19.FC.23159.163B90E4; Tue, 28 Jun 2011 06:56:33 -0400 (EDT)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-2.mit.edu (8.13.8/8.9.2) with ESMTP id p5SAuXwX012960;
	Tue, 28 Jun 2011 06:56:33 -0400
Received: from localhost (DR-WILY.MIT.EDU [18.181.0.233])
	(authenticated bits=0)
        (User authenticated as price@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id p5SAuWsv015054;
	Tue, 28 Jun 2011 06:56:32 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7vtybbufy2.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAIsWRmVeSWpSXmKPExsUixG6nopu4mdPP4NhLPYuuK91MFg29V5gd
	mDwuXlL2+LxJLoApissmJTUnsyy1SN8ugSujY9sdpoKvrBV3N/g0MF5m6WLk5JAQMJG483YV
	G4QtJnHh3nowW0hgH6PE8yP+XYxcQPYGRomedXvYIJwvjBJrZiwEcjg4WARUJT5cNwdpYBNQ
	kPgxfx0ziC0ioCYxse0Q2AJmAXGJdXPPs4PYwgKxEveeLGQCaeUVMJaYtVcUYtcERonVbwxB
	bF4BQYmTM59AtWpJ3Pj3EqycWUBaYvk/DpAwp4CZxMr9DxhBwqICKhKrlmZOYBSchaR5FpLm
	WQjNCxiZVzHKpuRW6eYmZuYUpybrFicn5uWlFuma6+VmluilppRuYgQHrIvKDsbmQ0qHGAU4
	GJV4eBlXcvgJsSaWFVfmHmKU5GBSEuXt3cTpJ8SXlJ9SmZFYnBFfVJqTWnyIUYKDWUmEd6oR
	UI43JbGyKrUoHyYlzcGiJM5b6v3fV0ggPbEkNTs1tSC1CCYrw8GhJME7AWSoYFFqempFWmZO
	CUKaiYMTZDgP0PDTIDW8xQWJucWZ6RD5U4yKUuK87SAJAZBERmkeXC8sobxiFAd6RZi3HqSK
	B5iM4LpfAQ1mAhpcVgs2uCQRISXVwKiceeDDSsdPDkbJf3znfz2RE7+Jnc/+AmvnzAv280q+
	mSQJRzRESSXtOPbif0DlL8GyY+pbdR+eZsrYuzgsb+IEXV7jSRbP3oZNzD+22uX6ebHlPm2b
	f364vix/xp/bCy3WvD0W7qby5p3oGumNP1/MZ+Nzvu7bKbfccEmO1IrkAxs975w/ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176391>

On Mon, Jun 27, 2011 at 2:23 PM, Junio C Hamano <gitster@pobox.com>
wrote:
> Have you ran all tests with the changes in this series, especially the
> ones in t34xx series?

Err, now that would be smart, now wouldn't it. =)

In fact, I had a stupid bug that this caught.  Fixed, will include in
next reroll (much sooner than this reroll was =P).  All tests now pass.

Greg



diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 42ea3e7..3b1e375 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -741,7 +741,7 @@ else
        revisions=$onto...$orig_head
        shortrevisions=$shorthead
 fi
-if test -z "rewrite_refs"
+if test -z "$rewrite_refs"
 then
        pretty=oneline
 else
