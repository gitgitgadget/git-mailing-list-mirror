From: "Steven E. Harris" <seh@panix.com>
Subject: Using format-patch and apply against files with CRLF line endings
Date: Wed, 20 Apr 2011 07:48:02 -0400
Organization: SEH Labs
Message-ID: <m2tydt5ekt.fsf@Spindle.sehlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 20 13:48:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QCVtO-00042R-Hv
	for gcvg-git-2@lo.gmane.org; Wed, 20 Apr 2011 13:48:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754412Ab1DTLsR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2011 07:48:17 -0400
Received: from lo.gmane.org ([80.91.229.12]:55290 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754302Ab1DTLsQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2011 07:48:16 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1QCVtH-0003wn-8v
	for git@vger.kernel.org; Wed, 20 Apr 2011 13:48:15 +0200
Received: from c-24-23-122-157.hsd1.pa.comcast.net ([24.23.122.157])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 20 Apr 2011 13:48:15 +0200
Received: from seh by c-24-23-122-157.hsd1.pa.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 20 Apr 2011 13:48:15 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: c-24-23-122-157.hsd1.pa.comcast.net
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2.50 (darwin)
Cancel-Lock: sha1:vwOPrhRLIrIsd3FtTlvNFmxjLS4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171861>

Is it the case that format-patch will always emit text with LF line
endings, or is it respecting whatever the host platform considers to be
the proper line ending? Is the line ending in use configurable?

I ask because I see that git-p4 uses format-patch and apply internally
to apply changes against files in the Perforce workspace, and those
files have CRLF line endings, but it looks like format-patch is emitting
patches with LF line endings, and none of those patches will apply
cleanly.

Perhaps I just need to pipe the output from format-patch through
unix2dos before feeding it to apply, but I'm wondering whether I'm
barking up the wrong tree here.

-- 
Steven E. Harris
