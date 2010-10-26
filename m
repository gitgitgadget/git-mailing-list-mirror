From: "George Spelvin" <linux@horizon.com>
Subject: How do I get a list of all unmerged files?
Date: 26 Oct 2010 10:32:45 -0400
Message-ID: <20101026143245.11433.qmail@science.horizon.com>
Cc: linux@horizon.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 26 16:33:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PAkaP-00022w-Tx
	for gcvg-git-2@lo.gmane.org; Tue, 26 Oct 2010 16:33:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758152Ab0JZOdG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Oct 2010 10:33:06 -0400
Received: from science.horizon.com ([71.41.210.146]:25314 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755807Ab0JZOdF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Oct 2010 10:33:05 -0400
Received: (qmail 11434 invoked by uid 1000); 26 Oct 2010 10:32:45 -0400
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159993>

After a merge with conflicts, mostly resolved by rerere, I want to pass a list of
all unmerged files to the editor for manual review.

I can see the list (wrapped in a bunch of inconvenient human-readable cruft)
in "git status".  I can also get a list (again with a bunch of extraneous
info) from "git ls-files -u".  What I can't figure out is how to get
"git ls-files -u" with --stage turned *off*.

I'm sure this exists somewhere, but I can't find it.  Can someone enlighten
me?

vim `git command here`

Thank you.
