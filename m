From: "igor.mikushkin" <igor.mikushkin@gmail.com>
Subject: Why git silently replaces untracked files?
Date: Fri, 25 Mar 2011 07:52:34 -0700 (PDT)
Message-ID: <1301064754576-6207950.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 25 15:52:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q38NX-0008RU-1u
	for gcvg-git-2@lo.gmane.org; Fri, 25 Mar 2011 15:52:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753905Ab1CYOwg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2011 10:52:36 -0400
Received: from sam.nabble.com ([216.139.236.26]:38546 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753701Ab1CYOwg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2011 10:52:36 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.69)
	(envelope-from <igor.mikushkin@gmail.com>)
	id 1Q38NO-0006yi-KQ
	for git@vger.kernel.org; Fri, 25 Mar 2011 07:52:34 -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169988>

Why git silently replaces untracked files?

# mkdir test.git
# mkdir 1
# mkdir 2
# echo 1 > 1/test
# echo 2 > 2/test
# cd test.git
# git init --bare
# cd ..
# git clone test.git
# cp -r test/.git 1
# cp -r test/.git 2
# cd 1
# git add test
# git commit -am 1
# git push origin master
# cd ../2
# git pull
# cat test
1

In my opinion it is wrong behavior.
I've just lost important file due to it.

Should not "git pull" fail here?
Anyhow it looks more correct then silent replacing.

Thanks,
Igor





--
View this message in context: http://git.661346.n2.nabble.com/Why-git-silently-replaces-untracked-files-tp6207950p6207950.html
Sent from the git mailing list archive at Nabble.com.
