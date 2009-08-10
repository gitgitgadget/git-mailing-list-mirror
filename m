From: Rostislav Svoboda <rostislav.svoboda@gmail.com>
Subject: .gitignore vs untracked working file
Date: Mon, 10 Aug 2009 11:57:15 +0200
Message-ID: <286817520908100257n35b178ebu387161658554b4a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 10 11:57:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaRd7-00037n-Cx
	for gcvg-git-2@gmane.org; Mon, 10 Aug 2009 11:57:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753462AbZHJJ5Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2009 05:57:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753369AbZHJJ5P
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Aug 2009 05:57:15 -0400
Received: from mail-fx0-f228.google.com ([209.85.220.228]:37016 "EHLO
	mail-fx0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753366AbZHJJ5P (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2009 05:57:15 -0400
Received: by fxm28 with SMTP id 28so809673fxm.17
        for <git@vger.kernel.org>; Mon, 10 Aug 2009 02:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=lMvSMxpYkMfPUc/j7z3WrZB8ApBWS0m5xl9yueAnePA=;
        b=si2o5G+pTnGVOkJ/yrEGJxanlr5tccRy7U+CDxWYezZXtRmvwNz5MP/j4eh8kJk1Ly
         6oKujAPEIy2zM6SRZxxkBZW+nDCVQKLpy57vSLF2U9jBrDTSO6hqesJdOPnPC+7g/X8i
         5yjVGPYpWgvDbXqrIABm1AX96Y0IJIuEPNfTc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=F40ezoylbdeDJK9+DJ6jYMK3uIunhNjIjk1KzfY+JLzcNw3elWqo9Nz7rz6iKCU4Xo
         iBnpHwi1LrUQMSe6DNzbgiE/vuS94eW5XmTWN6A9ju1430YVucLvA7ILmB1w37BxmJ5m
         TsDyc9iGVfg2F1G3MMyf5WhC7WW2pLoSCBnMk=
Received: by 10.239.177.74 with SMTP id u10mr429762hbf.88.1249898235405; Mon, 
	10 Aug 2009 02:57:15 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125428>

Hi

I have a .gitignore rule to ignore everything in bin/ directories but
I cannot change branch because of a file lying in a bin/ directory
which actually should be ignored. What am I doing wrong?

$ git branch
  master
* mybranch

$ git status
# On branch mybranch
nothing to commit (working directory clean)

$ cat .gitignore
*.class
.cvsignore
CVS/
.metadata/
build/
bin/
.#*

$ git checkout master
error: Untracked working tree file 'Project/bin/path/file.jjt' would
be overwritten by merge.

$ git --version
git version 1.6.4.msysgit.0


thx

Bost
