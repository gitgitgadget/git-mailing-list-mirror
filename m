From: tsgatesv <tsgatesv@gmail.com>
Subject: Yet another "emacs-git" mode on emacs
Date: Mon, 24 Mar 2008 21:55:18 +0900
Message-ID: <1206363318.8927.28.camel@prosummer>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 24 13:55:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdmDT-00008U-6d
	for gcvg-git-2@gmane.org; Mon, 24 Mar 2008 13:55:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754668AbYCXMzF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2008 08:55:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752450AbYCXMzF
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Mar 2008 08:55:05 -0400
Received: from wr-out-0506.google.com ([64.233.184.230]:32827 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752090AbYCXMzD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2008 08:55:03 -0400
Received: by wr-out-0506.google.com with SMTP id c48so1687616wra.1
        for <git@vger.kernel.org>; Mon, 24 Mar 2008 05:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:subject:from:to:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        bh=NDfZhpR2SSmqpuPgTcaQHu/dG5E0GC47RnL9K9KeYEE=;
        b=Lt1khQMnsadkahXbaruqPwqUwOyVtKyhShHpMScgty5vOCNrjvClSnFDHdKXKezjesubcANus2krxZBYjolD4HDwGJbR5gnFCpQRuSjksrTtafLkzpY07UjWy+iZJeXDRA3IggACOQ1Z9E+4Xazi5A5Ind9koPalI2EjTy3tia4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=subject:from:to:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=cyVhie+pOb1xDBR/qnW8ekkjan2rrhnZNjaDQx3nXMwZm7iheF0KQccooJ/Qjb60LvI46YwE+JOdrwMGwrHw2Po0S7AFgC+mYdlrIXURPyO6I4so7c8y6C9KnEszOWKRd0RLVVscnJwvoLFxiSp4OOzFw/KIKFL1uvc/58reE5U=
Received: by 10.141.18.14 with SMTP id v14mr2089381rvi.171.1206363296979;
        Mon, 24 Mar 2008 05:54:56 -0700 (PDT)
Received: from ?192.168.77.113? ( [125.143.160.43])
        by mx.google.com with ESMTPS id y11sm10519154pod.9.2008.03.24.05.54.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 24 Mar 2008 05:54:56 -0700 (PDT)
X-Mailer: Evolution 2.12.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78028>

Hi!

I has written yet another git mode on Emacs in order to contribute to
the git organization.

I expected the below

 1. Understanding git
 2. Use friend and powerful mode for emacs
 3. Introduce myself to you :-)

Actually, I followed the suggestion listed on the soc 2008 ideas.

---------------------------------------------------------------------- 
Better Emacs integration
Make git mode for Emacs full featured git GUI, and not only commit tool,
following ideas of PCL-CVS... and its limitation. Existing is today
git.el, which is very limited in features, and DVC
(http://download.gna.org/dvc), which still doesn't take full advantage
of Git's capabilities. Merging git.el and DVC would probably be a good
start. Other git GUIs, like git-gui, gitk, qgit, tig could also be
inspiration for features. 

Goal: Allow creating and switching branches, examining history, merging,
fetching etc. from withing Emacs. Should include modes for git config
file format and format-patch patches. 
Language: Emacs Lisp 
Suggested mentors: 

      * Alexandre Julliard 
      * David Kagedal 


Possible Co-mentor: 

      * Matthieu Moy 
---------------------------------------------------------------------------

Introduction & guided tour is on the links below.

Tour   : http://tsgates.cafe24.com/git/git-emacs.html 
Source : http://tsgates.cafe24.com/git/git-emacs-1.0.tar.gz

I happy to get a bug reports and any suggestions!

Since it is my first experience of contributing to open source, if there
are any misunderstandings or fallacies, please inform me anytime!
