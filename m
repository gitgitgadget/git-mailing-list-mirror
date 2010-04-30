From: Mahesh Vaidya <forvaidya@gmail.com>
Subject: push instead of
Date: Fri, 30 Apr 2010 15:26:35 +0530
Message-ID: <z2gb42431c81004300256ke7248f40y7bce060d52cfa943@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 30 19:18:03 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O7tqi-0002cc-Bl
	for gcvg-git-2@lo.gmane.org; Fri, 30 Apr 2010 19:18:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932710Ab0D3RNZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Apr 2010 13:13:25 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:63223 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758591Ab0D3RNV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Apr 2010 13:13:21 -0400
Received: by pxi17 with SMTP id 17so269137pxi.19
        for <git@vger.kernel.org>; Fri, 30 Apr 2010 10:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=qTF4yttxluVyNC05hVx7pbP6NqlLMOyFLi/W3bHXKGw=;
        b=Wbb9wJgHL1N0Gp0KZ89nGC/4qq4ZVUyQaOtG0S+4FF5Vm4cIt2wbHSHKXoqdfR/seX
         Rjum0DoB0s0tfwlbb+0I4/ngtRiDPjvzICBwX73CIHehOQalAz1SIBGVJONzkijvz7C+
         G0qUqoAYbY32Lcm9S9oedtskIaGHlDRlPVeHw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=bwvNA4xtqCKTkXzWn2uQzqbhgPXpEUGz7A+Fx+0Ix9bTklfOPASCAdJr5GTrXqMNhT
         IKa0V0AlE6moO7o9OLjsGGGv4dyFBbQ9z1Ec5wmk+39Bubxz0gFO3VNMIetnXKO+leqm
         CXF7mIJJIJi3P2BbCUNWlP+mKFMJm6c+shtg0=
Received: by 10.142.60.21 with SMTP id i21mr6224570wfa.132.1272621395463; Fri, 
	30 Apr 2010 02:56:35 -0700 (PDT)
Received: by 10.142.134.21 with HTTP; Fri, 30 Apr 2010 02:56:35 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146034>

I am facing problem at pushInsteadIOf. I would like pull from
"pullhost" and push to "pushhost" as my pullhost as pre-receive
trigger which not accepting pushes.

However when I do git push it still hits pull host. I have following config.

[remote "origin"]
        fetch = +refs/heads/*:refs/remotes/origin/*
        url = gitosis@pull_host:repos.git
[url "gitosis@localhost"]
        pushInsteadOf = gitosis@PUSH_host:repos.git


-- 
Thank you and best regards.
Mahesh Vaidya  / 9740500144
http://www.twitter.com/forvaidya
