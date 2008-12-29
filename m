From: Hannu Koivisto <azure@iki.fi>
Subject: gitk "reset branch to here" bug in Cygwin
Date: Mon, 29 Dec 2008 15:41:49 +0200
Organization: NOYB
Message-ID: <83abafcd42.fsf@kalahari.s2.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 29 14:43:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHIOx-0007Ls-FI
	for gcvg-git-2@gmane.org; Mon, 29 Dec 2008 14:43:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752914AbYL2NmA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Dec 2008 08:42:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752765AbYL2NmA
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Dec 2008 08:42:00 -0500
Received: from main.gmane.org ([80.91.229.2]:48258 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751628AbYL2Nl7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Dec 2008 08:41:59 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LHINY-000164-7Y
	for git@vger.kernel.org; Mon, 29 Dec 2008 13:41:56 +0000
Received: from s2.org ([195.197.64.39])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 29 Dec 2008 13:41:56 +0000
Received: from azure by s2.org with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 29 Dec 2008 13:41:56 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: s2.org
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/22.2 (gnu/linux)
Cancel-Lock: sha1:9EtpJOByzC6lGyrcd4yuBTAkbME=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104101>

Greetings,

First create a test repository with two commits:

mkdir gittest3
cd gittest3
git init
echo foo > foo
git add foo
git commit -m "Foo"
echo foo >> foo
git add foo
git commit -m "2nd. foo"

Now start gitk, point at the first commit and from the context menu
select "Reset master branch to here" and then "Hard:...".

The result is 'can not find channel named "1"'.

git reset --hard HEAD\^1 in the same repository works fine.

Tested with 159c88e5ae95c5b02298193c1658fac5919c8012 (1.6.1 plus a
few commits) on Windows XP.

-- 
Hannu
