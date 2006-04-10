From: "Aneesh Kumar" <aneesh.kumar@gmail.com>
Subject: git pull origin doesn't update the master
Date: Mon, 10 Apr 2006 10:11:05 +0530
Message-ID: <cc723f590604092141q3517136cmc0a895a069021b8f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Mon Apr 10 06:41:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FSoD8-0004mq-I1
	for gcvg-git@gmane.org; Mon, 10 Apr 2006 06:41:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750883AbWDJElH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Apr 2006 00:41:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750970AbWDJElH
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Apr 2006 00:41:07 -0400
Received: from wproxy.gmail.com ([64.233.184.228]:5988 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750883AbWDJElG convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Apr 2006 00:41:06 -0400
Received: by wproxy.gmail.com with SMTP id i12so748925wra
        for <git@vger.kernel.org>; Sun, 09 Apr 2006 21:41:05 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=gxWIQ3vP2X69MbJjUOnCTV/Ty2I/VhJxyxhJOj1UVkuZT3ewRMczeYvKX7k4jiRkmxqb9tJkIIx8VPAfvL7VzbhWHRIkaT2P+D7SiTdMfcLIUThOnBfAV/hjH+Y0tmd88SRovvxfsbByCZ9kXvZddWLDyAOdqpNL56tPUmEL4zQ=
Received: by 10.64.96.6 with SMTP id t6mr1170958qbb;
        Sun, 09 Apr 2006 21:41:05 -0700 (PDT)
Received: by 10.64.114.13 with HTTP; Sun, 9 Apr 2006 21:41:05 -0700 (PDT)
To: "Git Mailing List" <git@vger.kernel.org>,
	"Junio C Hamano" <junkio@cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18576>

While updating the git code base the master branch is not getting
updated. First look tell me that the below commit is the issue
a9698bb22fb7b66e5882c3a5e7b2b8b53ea03f90

git-pull.sh does
git-fetch --update-head-ok "$@" || exit 1

and git-fetch.sh exit with status 1 printing the below message

* refs/heads/pu: does not fast forward to branch 'pu' of
http://git.kernel.org/pub/scm/git/git;
  not updating.


-aneesh
