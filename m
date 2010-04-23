From: martinvz <martin.von.zweigbergk@gmail.com>
Subject: Re: Problems with file name case on Windows.
Date: Fri, 23 Apr 2010 04:16:06 -0800 (PST)
Message-ID: <1272024966257-4950180.post@n2.nabble.com>
References: <1271969657620-4947131.post@n2.nabble.com> <4BD14066.3040307@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 23 14:16:18 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5Hns-0003x6-Gc
	for gcvg-git-2@lo.gmane.org; Fri, 23 Apr 2010 14:16:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752241Ab0DWMQK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Apr 2010 08:16:10 -0400
Received: from kuber.nabble.com ([216.139.236.158]:45896 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751599Ab0DWMQI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Apr 2010 08:16:08 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <martin.von.zweigbergk@gmail.com>)
	id 1O5Hni-0007cd-8T
	for git@vger.kernel.org; Fri, 23 Apr 2010 05:16:06 -0700
In-Reply-To: <4BD14066.3040307@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145611>


Thanks, I had forgotten about "git mv". Still, when you receive just a
tarball of code (actually from another VCS in my case), you would have to
figure out which files had been renamed, before you could run the command,
so it is not very useful in scripting in this case. Maybe what I
could/should do is something like "git rm -rf *; <untar> ; git add -A"?

/Martin
-- 
View this message in context: http://git.661346.n2.nabble.com/Problems-with-file-name-case-on-Windows-tp4947131p4950180.html
Sent from the git mailing list archive at Nabble.com.
