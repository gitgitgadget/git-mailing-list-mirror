From: Erik Blake <erik@icefield.yk.ca>
Subject: Escape character for .gitconfig
Date: Sat, 17 Dec 2011 11:10:37 +0100
Message-ID: <4EEC6A9D.1060005@icefield.yk.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 17 11:50:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbrqT-0003S2-25
	for gcvg-git-2@lo.gmane.org; Sat, 17 Dec 2011 11:50:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751944Ab1LQKuV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Dec 2011 05:50:21 -0500
Received: from bosmailout11.eigbox.net ([66.96.184.11]:59383 "EHLO
	bosmailout11.eigbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751923Ab1LQKuU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Dec 2011 05:50:20 -0500
X-Greylist: delayed 2378 seconds by postgrey-1.27 at vger.kernel.org; Sat, 17 Dec 2011 05:50:20 EST
Received: from bosmailscan18.eigbox.net ([10.20.15.18])
	by bosmailout11.eigbox.net with esmtp (Exim)
	id 1RbrDz-0004xL-V1
	for git@vger.kernel.org; Sat, 17 Dec 2011 05:10:39 -0500
Received: from bosimpout02.eigbox.net ([10.20.55.2])
	by bosmailscan18.eigbox.net with esmtp (Exim)
	id 1RbrDz-0001mY-Im
	for git@vger.kernel.org; Sat, 17 Dec 2011 05:10:39 -0500
Received: from bosauthsmtp10.eigbox.net ([10.20.18.10])
	by bosimpout02.eigbox.net with NO UCE
	id AAAf1i00E0D2CUy01AAfLP; Sat, 17 Dec 2011 05:10:39 -0500
X-EN-OrigOutIP: 10.20.18.10
X-EN-IMPSID: AAAf1i00E0D2CUy01AAfLP
Received: from 221.59.9.46.customer.cdi.no ([46.9.59.221] helo=[192.168.2.3])
	by bosauthsmtp10.eigbox.net with esmtpa (Exim)
	id 1RbrDz-0004Dr-9w
	for git@vger.kernel.org; Sat, 17 Dec 2011 05:10:39 -0500
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:8.0) Gecko/20111105 Thunderbird/8.0
X-EN-UserInfo: 20c972d92b49a3da013d5f179c4005f2:fb4e807829017c6d805c060c7025d0c2
X-EN-AuthUser: erik@icefield.yk.ca
X-EN-OrigIP: 46.9.59.221
X-EN-OrigHost: 221.59.9.46.customer.cdi.no
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187374>

I have an editor path that includes "(" and ")". No matter how I try to 
escape this character, I get either variations on:

C:/Program Files (x86)/Notepad++/notepad++.exe: -c: line 0: syntax error 
near unexpected token `('
C:/Program Files (x86)/Notepad++/notepad++.exe: -c: line 0: `C:/Program 
Files (x86)/Notepad++/notepad++.exe \$@\'
error: There was a problem with the editor 'C:/Program Files 
(x86)/Notepad++/notepad++.exe'.
Please supply the message using either -m or -F option.

or:

fatal: bad config file line 5 in C:\Users\xxx/.gitconfig

As you can see, I'm running git on a Win7 64 machine. Is there any way 
to escape the brackets? Or do I need to reinstall notepad++ on a 
different path?
