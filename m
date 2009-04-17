From: Hannu Koivisto <azure@iki.fi>
Subject: Tests in Cygwin
Date: Fri, 17 Apr 2009 12:47:02 +0300
Organization: NOYB
Message-ID: <83prfbhasp.fsf@kalahari.s2.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 17 11:48:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lukgq-0007FS-5U
	for gcvg-git-2@gmane.org; Fri, 17 Apr 2009 11:48:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757894AbZDQJrR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Apr 2009 05:47:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757786AbZDQJrR
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Apr 2009 05:47:17 -0400
Received: from main.gmane.org ([80.91.229.2]:42643 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757748AbZDQJrQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Apr 2009 05:47:16 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LukfC-00038y-7e
	for git@vger.kernel.org; Fri, 17 Apr 2009 09:47:14 +0000
Received: from s2.org ([195.197.64.39])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 17 Apr 2009 09:47:14 +0000
Received: from azure by s2.org with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 17 Apr 2009 09:47:14 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: s2.org
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/22.2 (gnu/linux)
Cancel-Lock: sha1:u3GrTZPVS9BM25ixSsmZCywcZi4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116729>

Greetings,

I upgraded to the latest git.git as of yesterday
(f800b65bea1504299747e7be03ee279508a74e1f) in Cygwin to see if it
still has the rebase and bogus modified files problem(s) (reported
earlier http://osdir.com/ml/git/2009-04/msg00619.html).  It does;
I'll try to bisect it if I manage to make the test case automatic.

I also thought I'd run all the tests just for the heck of it.  The
result is about 240 failures which are available here (lines
indicating passed tests removed):

http://www.iki.fi/azure/tmp/git-test-results-cygwin-f800b65bea1504299747e7be03ee279508a74e1f.txt

I wonder, since there seems to be some sort of mechanism to mark
failures "known" (at least I got a couple of "still broken ..."
lines), are all these unexpected, new problems, or is there perhaps
some separate list of known failures on Cygwin?

-- 
Hannu
