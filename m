From: SungHyun Nam <goweol@gmail.com>
Subject: cannot remove remote branch name
Date: Tue, 05 Jan 2010 10:57:18 +0900
Message-ID: <hhu694$3v9$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 05 02:57:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NRyfh-0003sL-Nv
	for gcvg-git-2@lo.gmane.org; Tue, 05 Jan 2010 02:57:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753903Ab0AEB5S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jan 2010 20:57:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753884Ab0AEB5S
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jan 2010 20:57:18 -0500
Received: from lo.gmane.org ([80.91.229.12]:44620 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753829Ab0AEB5R (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jan 2010 20:57:17 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1NRyfb-0003qT-5j
	for git@vger.kernel.org; Tue, 05 Jan 2010 02:57:15 +0100
Received: from 210.181.13.12 ([210.181.13.12])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 05 Jan 2010 02:57:15 +0100
Received: from goweol by 210.181.13.12 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 05 Jan 2010 02:57:15 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 210.181.13.12
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; ko; rv:1.9.1.5) Gecko/20091204 Thunderbird/3.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136151>

Hello,

How I can remove remote branch name if it already removed
in remote side?

$ git branch -a
* master
   remotes/origin/HEAD -> origin/master
   remotes/origin/master
   remotes/origin/test
$ git branch -D -r test
error: remote branch 'test' not found.
$ git branch -D -r remotes/origin/test
error: remote branch 'remotes/origin/test' not found.
$ git branch -D remotes/origin/test
error: branch 'remotes/origin/test' not found.

The 'remotes/origin/test' was removed in remote side.

Thanks,
namsh
