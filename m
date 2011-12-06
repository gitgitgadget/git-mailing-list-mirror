From: Viresh Kumar <viresh.kumar@st.com>
Subject: Query on git commit amend
Date: Tue, 6 Dec 2011 13:53:00 +0530
Message-ID: <4EDDD0E4.6040003@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Shiraz HASHIM <shiraz.hashim@st.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 06 09:23:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RXqJ1-0005Fz-Fw
	for gcvg-git-2@lo.gmane.org; Tue, 06 Dec 2011 09:23:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933031Ab1LFIXK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Dec 2011 03:23:10 -0500
Received: from eu1sys200aog117.obsmtp.com ([207.126.144.143]:43619 "EHLO
	eu1sys200aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932988Ab1LFIXJ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Dec 2011 03:23:09 -0500
Received: from beta.dmz-ap.st.com ([138.198.100.35]) (using TLSv1) by eu1sys200aob117.postini.com ([207.126.147.11]) with SMTP
	ID DSNKTt3Q6YGNzQrMJb02z/M4q9j59roNKF3L@postini.com; Tue, 06 Dec 2011 08:23:08 UTC
Received: from zeta.dmz-ap.st.com (ns6.st.com [138.198.234.13])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 19413CD
	for <git@vger.kernel.org>; Tue,  6 Dec 2011 08:14:36 +0000 (GMT)
Received: from Webmail-ap.st.com (eapex1hubcas3.st.com [10.80.176.67])
	by zeta.dmz-ap.st.com (STMicroelectronics) with ESMTP id C230CAC7
	for <git@vger.kernel.org>; Tue,  6 Dec 2011 08:23:02 +0000 (GMT)
Received: from [10.199.82.50] (10.199.82.50) by Webmail-ap.st.com
 (10.80.176.7) with Microsoft SMTP Server (TLS) id 8.3.192.1; Tue, 6 Dec 2011
 16:23:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:6.0) Gecko/20110812 Thunderbird/6.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186336>


Hello,

Suppose i want to add few new changes to my last commit (HEAD).
The way i do it is
$ git add all_changed_files
$ git commit --amend

OR
$ git commit --amend -a

With both these ways, i get a screen to edit the message too.

I want to know if there is a way to skip this screen.

i.e.
$ git commit --amend -a -some_other_option

which simply adds new changes to existing commit, without asking to change
message.

If there is no such way, then can we add a patch for this, if it looks a valid
case.

-- 
viresh
