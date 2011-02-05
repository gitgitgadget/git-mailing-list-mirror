From: "ashish.mittal" <ashishmittal.mail@gmail.com>
Subject: Apply Patch giving warnings in windows
Date: Sat, 5 Feb 2011 00:44:01 -0800 (PST)
Message-ID: <1296895441967-5995091.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 05 09:44:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PldkX-0007ET-SK
	for gcvg-git-2@lo.gmane.org; Sat, 05 Feb 2011 09:44:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751531Ab1BEIoE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Feb 2011 03:44:04 -0500
Received: from sam.nabble.com ([216.139.236.26]:56645 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751438Ab1BEIoD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Feb 2011 03:44:03 -0500
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.69)
	(envelope-from <ashishmittal.mail@gmail.com>)
	id 1PldkP-0002uW-VS
	for git@vger.kernel.org; Sat, 05 Feb 2011 00:44:01 -0800
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166081>


Hello members,

I created a patch on ubuntu using 'git format-patch -1' for my last commit.
When I did 'git apply --check patch_name', I got 'warning: file_name of type
100644, expected 100755'. The execution bit of the files was set. I set the
filemode in config to true using 'git config core.filemode true'. The git
apply --check was giving no more warnings. But I get same warnings on
Windows even after setting the filemode to true and false both. Can anyone
guide me regarding this?

Thanks,
Ashish Mittal
-- 
View this message in context: http://git.661346.n2.nabble.com/Apply-Patch-giving-warnings-in-windows-tp5995091p5995091.html
Sent from the git mailing list archive at Nabble.com.
