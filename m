From: SungHyun Nam <goweol@gmail.com>
Subject: git bundle bug?
Date: Mon, 26 Jul 2010 15:45:32 +0900
Message-ID: <i2jaue$f7a$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 26 08:46:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdHRk-0006xj-QF
	for gcvg-git-2@lo.gmane.org; Mon, 26 Jul 2010 08:45:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752995Ab0GZGpv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jul 2010 02:45:51 -0400
Received: from lo.gmane.org ([80.91.229.12]:36864 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752369Ab0GZGpv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jul 2010 02:45:51 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1OdHRa-0006tZ-7u
	for git@vger.kernel.org; Mon, 26 Jul 2010 08:45:46 +0200
Received: from 210.181.13.12 ([210.181.13.12])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 26 Jul 2010 08:45:46 +0200
Received: from goweol by 210.181.13.12 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 26 Jul 2010 08:45:46 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 210.181.13.12
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; ko; rv:1.9.1.11) Gecko/20100711 Thunderbird/3.0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151810>

Hello,

In a current 'git' source tree, next command does not includes
refs/tags/v1.7.2.
     $ git bundle create ~/git.bundle v1.7.1..master

After applying the git.bundle, now 'git version' does not
show 1.7.2, but...
     $ git version
     git version 1.7.1.772.g64fdc

I hope the 'git bundle' includes all the tags when I use 'master'
or 'HEAD'.

Well, I could use v1.7.1..v1.7.2.  But want to use simple script like:
     $ git bundle create ~/git.bundle lastbundle..master
     $ git tag -f lastbundle master

Thanks,
namsh
