From: "Songmao Tian" <kingkongmao@gmail.com>
Subject: troubles in supersede old development history (git-svn)
Date: Sun, 7 Jan 2007 17:29:58 +0800
Message-ID: <7d73e7d80701070129r48dfa3bcq46112dea56962b3e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Jan 07 10:30:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3UM1-00014V-Jd
	for gcvg-git@gmane.org; Sun, 07 Jan 2007 10:30:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932449AbXAGJaA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 Jan 2007 04:30:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932450AbXAGJaA
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jan 2007 04:30:00 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:55104 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932449AbXAGJ37 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jan 2007 04:29:59 -0500
Received: by nf-out-0910.google.com with SMTP id o25so9074611nfa
        for <git@vger.kernel.org>; Sun, 07 Jan 2007 01:29:58 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=pniNGoaFQto4Adqaspz2n4Td1vUvtpLsTZ29MwLkv1aa1Ez5P/wxQtBIKoKYQeqblMRHJrnH0IjxuTF3W8cBG0hBXKYDheZSBQncN9C2n68q0A7vFUD4hcIYTP1i/FiIksRg7mVkkpTAqFSb7nzMTFE49pfHEH3Imbz7AtMIK7E=
Received: by 10.48.210.20 with SMTP id i20mr16541044nfg.1168162198691;
        Sun, 07 Jan 2007 01:29:58 -0800 (PST)
Received: by 10.48.212.10 with HTTP; Sun, 7 Jan 2007 01:29:58 -0800 (PST)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36142>

our trunk's maintainer is lazy in merging branches, I'd like to merge
the branch kkmao, and now there are so many the conflicts. I want to
just use my version and overcome all the conflicts.

i try in this way:

git-checkout -b trunk remotes/trunk
git-rebase --merge -s ours remotes/kkmao
git-svn dcommit -i trunk
diff-tree 9b75e30191838431810aec4eda98482a8d6935ed~1
9b75e30191838431810aec4eda98482a8d6935ed
Transaction is out of date: Out of date:
'trunk/Targets/Bonito/conf/Bonito.lmbox' in transaction '74-3' at
/home/kkmao/bin/git-svn line 1577

so what's the solution?


and another question. I use normal merge strategy
git-svn remotes/kkmao
got some conflicts..

and one file is missing, i have to git-ls-files -u to see what's beneath.
git-ls-files -u
100644 f7a66ae00d4034ab580e4ee71b0eaccc3a3e44e7 1
Targets/Bonito/conf/Bonito
100644 e6f5d90b30c3ee694acd2199a03e8f34ef1412ac 3
Targets/Bonito/conf/Bonito

I have read some doc, but I think I am still not good at resolve conflict:)
