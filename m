From: viresh kumar <viresh.kumar@st.com>
Subject: Copying Git repository from Linux to Windows.
Date: Wed, 15 Jun 2011 14:58:34 +0530
Message-ID: <4DF87B42.1020004@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Shiraz HASHIM <shiraz.hashim@st.com>,
	Vipin KUMAR <vipin.kumar@st.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 15 11:28:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWmP4-0001xJ-Bl
	for gcvg-git-2@lo.gmane.org; Wed, 15 Jun 2011 11:28:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754459Ab1FOJ2p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jun 2011 05:28:45 -0400
Received: from eu1sys200aog102.obsmtp.com ([207.126.144.113]:52453 "EHLO
	eu1sys200aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754209Ab1FOJ2p (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Jun 2011 05:28:45 -0400
Received: from beta.dmz-ap.st.com ([138.198.100.35]) (using TLSv1) by eu1sys200aob102.postini.com ([207.126.147.11]) with SMTP
	ID DSNKTfh7Sk61wXubgQ0x8OHXyql3b3OOQG7s@postini.com; Wed, 15 Jun 2011 09:28:44 UTC
Received: from zeta.dmz-ap.st.com (ns6.st.com [138.198.234.13])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id B39C4189
	for <git@vger.kernel.org>; Wed, 15 Jun 2011 09:28:37 +0000 (GMT)
Received: from Webmail-ap.st.com (eapex1hubcas4.st.com [10.80.176.69])
	by zeta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 5A162AE1
	for <git@vger.kernel.org>; Wed, 15 Jun 2011 09:28:37 +0000 (GMT)
Received: from [10.199.16.92] (10.199.16.92) by Webmail-ap.st.com
 (10.80.176.7) with Microsoft SMTP Server (TLS) id 8.2.234.1; Wed, 15 Jun 2011
 17:28:36 +0800
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.12) Gecko/20101027 Lightning/1.0b2 Thunderbird/3.1.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175813>

Hello,

I wanted to copy my complete Linux GIT repo from Linux PC to Windows. I also wanted everything
related to remote branches too, so need to copy and clone and fetch wouldn't work.

I don't have windows on same network, so i need to copy to memory stick and then to Windows PC.

After completing copy operation on mem stick, i found something strange.
- git branch shows correct results and is exactly same of state at Linux machine.
- git log is also fine.
- git status, shows me a lot of files are modified, which is not present in Linux.
- git reset --hard also doesn't work and fails with following error.


$ git reset --hard HEAD
error: unable to create symlink arch/microblaze/boot/dts/system.dts (Operation not permitted)
Checking out files: 100% (36696/36696), done.
fatal: Could not reset index file to revision 'HEAD'.


Any help about this issue would be very helpful.

-- 
viresh
