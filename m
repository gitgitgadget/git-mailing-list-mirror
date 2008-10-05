From: Ed Avis <eda@waniasset.com>
Subject: Re: Build bug report: 'make check' needs sparse, but configure doesn't check it
Date: Sun, 5 Oct 2008 09:46:57 +0000 (UTC)
Message-ID: <loom.20081005T094301-345@post.gmane.org>
References: <loom.20081004T131652-828@post.gmane.org> <20081005003446.GN21650@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 05 11:49:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KmQEA-0008Qc-55
	for gcvg-git-2@gmane.org; Sun, 05 Oct 2008 11:48:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753256AbYJEJrO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Oct 2008 05:47:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753168AbYJEJrO
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Oct 2008 05:47:14 -0400
Received: from main.gmane.org ([80.91.229.2]:37987 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753092AbYJEJrN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Oct 2008 05:47:13 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KmQCi-0006me-FM
	for git@vger.kernel.org; Sun, 05 Oct 2008 09:47:08 +0000
Received: from dsl-217-155-72-22.zen.co.uk ([217.155.72.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 05 Oct 2008 09:47:08 +0000
Received: from eda by dsl-217-155-72-22.zen.co.uk with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 05 Oct 2008 09:47:08 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 217.155.72.22 (Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.0.2) Gecko/2008092318 Fedora/3.0.2-1.fc9 Firefox/3.0.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97505>

Dmitry Potapov <dpotapov <at> gmail.com> writes:

>The whole point of 'make check' is to run 'sparce' on all files.

>If you want to build
>and to test the resulting binaries then you run 'make test'.

Thanks, I didn't realize that.  I assumed that 'make check' was to run the test
suite.

That is the convention used by most autoconf-based programs: for example if you
download coreutils then 'make check' runs the tests, so the normal way to build
and install is something like 'configure && make check && make install'.

To reduce confusion I suggest renaming the target to 'make sparse'.  Then it's
obvious what it does and it can't get confused with the more common usage of
'make check'.

-- 
Ed Avis <eda@waniasset.com>
