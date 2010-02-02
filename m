From: Ron Garret <ron1@flownet.com>
Subject: What does git reset do?
Date: Mon, 01 Feb 2010 23:47:56 -0800
Organization: Amalgamated Widgets
Message-ID: <ron1-A2A2DE.23475601022010@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 02 08:48:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcDUq-0001XH-Ke
	for gcvg-git-2@lo.gmane.org; Tue, 02 Feb 2010 08:48:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755550Ab0BBHsT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2010 02:48:19 -0500
Received: from lo.gmane.org ([80.91.229.12]:45110 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755443Ab0BBHsS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2010 02:48:18 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1NcDUe-0001Q6-9R
	for git@vger.kernel.org; Tue, 02 Feb 2010 08:48:16 +0100
Received: from 68-190-211-184.dhcp.gldl.ca.charter.com ([68.190.211.184])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 02 Feb 2010 08:48:16 +0100
Received: from ron1 by 68-190-211-184.dhcp.gldl.ca.charter.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 02 Feb 2010 08:48:16 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 68-190-211-184.dhcp.gldl.ca.charter.com
User-Agent: MT-NewsWatcher/3.5.1 (Intel Mac OS X)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138690>

The docs say that git-reset:

"Sets the current head to the specified commit..."

So I tried this:


[ron@mickey:~/devel/gittest]$ git branch
* br1
  master
[ron@mickey:~/devel/gittest]$ git reset --soft master


...expecting HEAD to now point to master.  But it doesn't:


[ron@mickey:~/devel/gittest]$ git branch
* br1
  master
[ron@mickey:~/devel/gittest]$ more .git/HEAD 
ref: refs/heads/br1


So... what does git reset do?

Thanks,
rg
