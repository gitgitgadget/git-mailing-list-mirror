From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: git notes and git-commit
Date: Fri, 10 Dec 2010 20:11:54 +0700
Message-ID: <AANLkTi=q1F7WEgH+dLKTHOKhsNVuhU=OeyJ2AsP7oW2G@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Dec 10 14:12:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PR2m2-0007Pe-W1
	for gcvg-git-2@lo.gmane.org; Fri, 10 Dec 2010 14:12:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756411Ab0LJNM1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Dec 2010 08:12:27 -0500
Received: from mail-ey0-f171.google.com ([209.85.215.171]:33037 "EHLO
	mail-ey0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756396Ab0LJNM0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Dec 2010 08:12:26 -0500
Received: by eyg5 with SMTP id 5so2673871eyg.2
        for <git@vger.kernel.org>; Fri, 10 Dec 2010 05:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:from:date
         :message-id:subject:to:content-type;
        bh=+xTNAxSeIbonf2gkq3MoFk9RsJIegtc6oHwQQA3qNRc=;
        b=BMxksz43uRfTs2RWPXpylTNLDxWOeg80aDXzbqzTivPfBxGr6oSsCJw5nRuohWBm6p
         WIjT2vWuwxL4Mj1igSc0R4qGGcuzL7WZKl+xGDaBjOsq3EsFEt03pEF0dvMrFqlX47hW
         SqDvXtS8k3+opPkjAPmCGDdtZ9I2THwhwKVVY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=n7hAOY1fDzTiLD0t2q7DfWtBzCUa4mc8l4smM4yQS5QBoOCzchcg712qmnDQktVhpm
         95MRVeOEZWARTwIGTwkt5A/zA6d19nw9rIkL0Y4YIEVPkNDcv5cjTAWE6ackD3WEDblO
         6lwVqji1BMmJ60gKuvLAAZWC+KwkvHGtT4Qmg=
Received: by 10.216.169.6 with SMTP id m6mr1007077wel.49.1291986744835; Fri,
 10 Dec 2010 05:12:24 -0800 (PST)
Received: by 10.216.158.83 with HTTP; Fri, 10 Dec 2010 05:11:54 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163410>

Hi,

I have never used git-notes before, just have had a quick look over
git-notes.txt so this may have already been discussed.

Isn't it more convenient to write/update notes when editing commit
message? Jakub mentioned of "---" in the archive elsewhere. There's
notes.rewriteRef for commit --amend. But if I amend a commit, I might
as well change my notes. rewriteRef would not work with "git commit
-c" either.

Another (probably silly) thing. Can I temporarily attach notes to
HEAD? I could add up notes while working, the notes show up when I
edit for commit message. I could make revise the notes a bit and
commit. Then the notes are attached to a commit.
-- 
Duy
