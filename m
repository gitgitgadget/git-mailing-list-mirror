From: Seth Falcon <sethfalcon@gmail.com>
Subject: Confused about tracking git master
Date: Tue, 18 Apr 2006 11:08:48 -0700
Message-ID: <m2wtdmg3in.fsf@ziti.fhcrc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Apr 18 20:09:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FVudG-0008OM-MX
	for gcvg-git@gmane.org; Tue, 18 Apr 2006 20:08:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932264AbWDRSIy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 18 Apr 2006 14:08:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932267AbWDRSIy
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Apr 2006 14:08:54 -0400
Received: from nz-out-0102.google.com ([64.233.162.194]:49025 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932264AbWDRSIx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Apr 2006 14:08:53 -0400
Received: by nz-out-0102.google.com with SMTP id o37so871241nzf
        for <git@vger.kernel.org>; Tue, 18 Apr 2006 11:08:52 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:subject:from:date:message-id:user-agent:mime-version:content-type;
        b=DFFyHjycRVNRWPwLokexbFVUpAQ9snI1mL8+HmSBqiShA2rWVt5ZW9IJHcXd/DTA1ps/3c7M5DZNDag5ClbckrMrs+9cDdpCLB8EDlqqn1hm84l92GSx/V0QrrbksvqRvqZAce0gZ1kwy5Zt/nPUvUVxFtw0iiWItjSvypjbKg8=
Received: by 10.36.108.11 with SMTP id g11mr7006463nzc;
        Tue, 18 Apr 2006 11:08:52 -0700 (PDT)
Received: from ziti.fhcrc.org ( [67.171.24.140])
        by mx.gmail.com with ESMTP id 40sm122879nzf.2006.04.18.11.08.51;
        Tue, 18 Apr 2006 11:08:52 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (darwin)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18865>

Hi,

I'm tracking git and somehow getting confused about how to get
updates.

To start, I did: git clone git://git.kernel.org/pub/scm/git/git.git

To get updates, I _think_ all I have to do is 'git pull'.  Doing so I
get:

    Unpacking 157 objects
     100% (157/157) done
    * refs/heads/todo: same as branch 'todo' of git://git.kernel.org/pub/scm/git/git
    * refs/heads/maint: same as branch 'maint' of git://git.kernel.org/pub/scm/git/git
    * refs/heads/origin: same as branch 'master' of git://git.kernel.org/pub/scm/git/git
    * refs/heads/pu: does not fast forward to branch 'pu' of git://git.kernel.org/pub/scm/git/git;
      not updating.       

Then when I do git whatchanged, the last change is on Saturday the
15th.  I'm figuring there has probably been at least one commit since
then?  So I tried 'git checkout origin' and then repeated the
whatchanged call and see:

    diff-tree 2855d58... (from bb99661...)
    Author: Junio C Hamano <junkio@cox.net>
    Date:   Mon Apr 17 17:46:07 2006 -0700   

Is there a step I'm missing?  Or am I just misunderstanding what to
expect?  Clarification on either of those would be appreciated.

Thanks,

+ seth
