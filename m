From: Travis Carden <travis.carden@gmail.com>
Subject: Feature Request: `git remote prune --all`
Date: Sat, 16 Aug 2014 19:52:44 -0500
Message-ID: <CAByVDef1_7x8Q1SL5wMtrKJQE51gvEOiKJ4xkpexXN5omBDn-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 17 02:52:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XIoiN-0002ox-4g
	for gcvg-git-2@plane.gmane.org; Sun, 17 Aug 2014 02:52:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751686AbaHQAwq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Aug 2014 20:52:46 -0400
Received: from mail-yh0-f46.google.com ([209.85.213.46]:53434 "EHLO
	mail-yh0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751530AbaHQAwp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Aug 2014 20:52:45 -0400
Received: by mail-yh0-f46.google.com with SMTP id a41so3444090yho.33
        for <git@vger.kernel.org>; Sat, 16 Aug 2014 17:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=drjCpCvW1UZSyfNFOyIFb3kphN4x3hkbY7UalwMeZH0=;
        b=kcawk5syWXkDhy46auzA+8rfJ6PiYh2xMAtcVL1ZSar+kkH6/b5Olsts6eRpt57a/r
         DP73od4JnlfM04OyQu0SFbmNU62zz1VPgWynhwx6AUK/Cpcrw1A+Vdc0sJGk0CPI4Tvt
         srmkK0cOgEuN2BeGedLcW+V0F5uiC7memHGwzkBbISnaJpjan4xmGKwH2w56oogZP4m+
         QPutAg1SCrSSM9b1CrbX33Bh6qGCJUj1VImiuZh/xw8dqmn9yln4h7KaptVSOAcyhnj3
         9yfizPtI6dG8VhlKB8gQVSdcsmmIJoKxDLOuPS+1ecEdCnJULfhcJg70JSC8w296n8rU
         pKPw==
X-Received: by 10.236.29.171 with SMTP id i31mr42445889yha.37.1408236764785;
 Sat, 16 Aug 2014 17:52:44 -0700 (PDT)
Received: by 10.170.159.130 with HTTP; Sat, 16 Aug 2014 17:52:44 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255346>

I would like to propose the addition of a `git remote prune --all`
command option or similar mechanism for pruning all remotes in a
repository. For lack of such a feature, I've been using the following
bash alias:

alias git-remote-prune-all='for REMOTE in `git remote`; do echo
"Pruning $REMOTE"; git remote prune $REMOTE; done;'
