From: Robert Dailey <rcdailey.lists@gmail.com>
Subject: How are submodule conflicts resolved during rebase?
Date: Tue, 28 Apr 2015 09:34:06 -0500
Message-ID: <CAHd499CSshO-929PF7fiR4hpxd9J=S+XFuE3sdQHFjPvXT_C0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 28 16:34:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yn6aT-0002We-Ub
	for gcvg-git-2@plane.gmane.org; Tue, 28 Apr 2015 16:34:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030799AbbD1OeJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2015 10:34:09 -0400
Received: from mail-ie0-f176.google.com ([209.85.223.176]:36622 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030713AbbD1OeH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Apr 2015 10:34:07 -0400
Received: by iebrs15 with SMTP id rs15so19437578ieb.3
        for <git@vger.kernel.org>; Tue, 28 Apr 2015 07:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:message-id:subject:from:to:content-type;
        bh=xNyL6T6MSX3lK4N9ptktHt8Q9dCAqcN6uRLvkMyv6Lc=;
        b=RB8l5AdoVLSmW+wMaohVSSnHerC/XiNzP3ukc+G99gWuBsVbQR1v/EhPWtzIJG4CX8
         GJRs0FYPBlj2ULR3vNhqLW3JiukorHYnbC/TyI+o0Q6z1CNJO7RYyh7jHpRhFHialWH+
         z6PeMQu5qKZClaotitmxmrCKyxgFDCadHMS9RZhYB65KEhvBirsNxw8Xt/irnGJFlqLx
         UoK4QW6i4Nb/LtHKrDkfzSeFBAX1/KIAkB9yABI/oRidfQ3zkmmDGjPkWe7y/FYcj52e
         zdOtKoZK0p8N1wAaW2l/a0NIVc50hHn2qKUCWBTYd47vMpUXl7RCQhumKi2s/RVd6MDx
         YSDQ==
X-Received: by 10.50.79.195 with SMTP id l3mr439345igx.40.1430231646178; Tue,
 28 Apr 2015 07:34:06 -0700 (PDT)
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.36.86.148 with HTTP; Tue, 28 Apr 2015 07:34:06 -0700 (PDT)
X-Google-Sender-Auth: y6PDrkj6GvanGFGqhJuvJ7rr-4k
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267925>

Hey guys,

I'm using Git for Windows 2.3.6. There is a bit of confusion I have
with regards to how submodule conflicts are resolved/handled during a
rebase.

Suppose I have a branch with 10 commits on it, 3 of those commits
contain a change to the same (and only) submodule in the repository.
When I rebase this branch onto the tip of its parent branch, I get a
conflict in each of the 3 commits because the submodule also changed
on the parent branch since my last rebase.

I've seen some cases where I am asked to resolve the submodule
conflict with local or remote. I expect this behavior and it isn't
confusing to me. However, I have also seen cases where rebase auto
resolves the conflicted submodule.

How does Git know to auto resolve some submodule conflicts but not the
others? I find this behavior unpredictable and I haven't found any
documentation on it (I'm giving the git docs the benefit of the doubt
and assuming it's there, since the git docs are very very good).

Help is appreciated. Thank you.
