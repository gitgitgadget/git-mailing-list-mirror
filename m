From: SungHyun Nam <goweol@gmail.com>
Subject: [BUG] 'git stash save' cannot create stash
Date: Thu, 10 Dec 2009 21:17:55 +0900
Message-ID: <hfqoth$7em$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 10 13:18:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NIhyZ-0006e3-Bd
	for gcvg-git-2@lo.gmane.org; Thu, 10 Dec 2009 13:18:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932827AbZLJMSR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Dec 2009 07:18:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932805AbZLJMSQ
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Dec 2009 07:18:16 -0500
Received: from lo.gmane.org ([80.91.229.12]:38074 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932786AbZLJMSP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Dec 2009 07:18:15 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1NIhyN-0006b4-6R
	for git@vger.kernel.org; Thu, 10 Dec 2009 13:18:19 +0100
Received: from 210.181.13.12 ([210.181.13.12])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 10 Dec 2009 13:18:19 +0100
Received: from goweol by 210.181.13.12 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 10 Dec 2009 13:18:19 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 210.181.13.12
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; ko; rv:1.9.1.5) Gecko/20091130 Thunderbird/3.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135018>

Hello,

'git stash save' generates error:

/usr/local/libexec/git-core/git-stash: 436: cannot create
/home/namsh/work/project/.git/logs/refs/stash: Directory
nonexistent

Is it caused by my 'core.logAllRefUpdates' setting?
$ git config core.logAllRefUpdates
false

Anyway, 'git stash save' works fine after I do 'mkdir -p
.git/logs/refs'.

Thanks,
namsh
