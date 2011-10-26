From: Hannu Koivisto <azure@iki.fi>
Subject: Out of memory error with git rebase
Date: Wed, 26 Oct 2011 12:21:24 +0300
Organization: NOYB
Message-ID: <83vcrc9kh7.fsf@kalahari.s2.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 26 11:21:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RIzg9-0008Fx-Do
	for gcvg-git-2@lo.gmane.org; Wed, 26 Oct 2011 11:21:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932593Ab1JZJVk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Oct 2011 05:21:40 -0400
Received: from lo.gmane.org ([80.91.229.12]:50507 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932571Ab1JZJVk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Oct 2011 05:21:40 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1RIzg0-0008Cr-JN
	for git@vger.kernel.org; Wed, 26 Oct 2011 11:21:36 +0200
Received: from s2.org ([80.83.7.53])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 26 Oct 2011 11:21:36 +0200
Received: from azure by s2.org with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 26 Oct 2011 11:21:36 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: s2.org
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.3 (gnu/linux)
Cancel-Lock: sha1:7O/U95g8NTyNRVViR2DOHXGOs/Q=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184252>

Hi,

If 'git rebase origin/master' dies with an out of memory error
(probably due to a few of large binary files in the repository, the
largest being ~300MB and ~1GB in total in one directory), which
settings should be tweaked and how to get rid of the problem?  I
tried...

[pack]
        threads = 1
        windowMemory = 64M
        packSizeLimit = 512M

...based on some suggestions in the net but that was of no help.

I'm using git 1.7.5.1 in Cygwin and I also tried the latest master
branch version (which behaved identically).

-- 
Hannu
