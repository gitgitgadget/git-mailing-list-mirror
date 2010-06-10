From: =?ISO-8859-1?Q?Gustav_H=E5llberg?= <gustav@gmail.com>
Subject: Re: [StGit] Emacs mode merge request
Date: Thu, 10 Jun 2010 09:31:03 +0200
Message-ID: <AANLkTim2n3MuBZP4lHEOlX0kxDfPBrz28c_7JlFMgQUv@mail.gmail.com>
References: <AANLkTiklRA-d8p3NhpvjZLua0zE7uK8RFrJTegCr-Jjd@mail.gmail.com>
	<AANLkTik7p3H9xHbZz80-Zn6nXWy0txfe-ShJNlD241cH@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?David_K=E5gedal?= <davidk@lysator.liu.se>
To: git@vger.kernel.org, Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 10 09:31:30 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMcEc-0001Po-Bf
	for gcvg-git-2@lo.gmane.org; Thu, 10 Jun 2010 09:31:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753956Ab0FJHbJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Jun 2010 03:31:09 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:46675 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752633Ab0FJHbH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Jun 2010 03:31:07 -0400
Received: by fxm8 with SMTP id 8so4035800fxm.19
        for <git@vger.kernel.org>; Thu, 10 Jun 2010 00:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=vKpUBHka3Ph2weRDzp+x/94b/kOLuG0prHAwhHU22sk=;
        b=xAIEkNqwuFr86Gbz0PYNpE59jZ5xZHkk/Bs+zwwiiHM73tjeHt2y6vwH1e57Evpluq
         p6JIqqJ9UYnAv08Ob7TChFi2HTK8kNMLfqr4/LrsJ404AtslY2dsAK9wdy/gI4JRByWR
         4TT64aEbkEFGKaKz6+lXXrefxFn+dYRjqdtmY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=EMxJ1InFzjP9E7L5ZQME/8+QCVtdskrF2hWh58leaoqvdEKb9GtTipe1n+1zWDPd5L
         q2po+GascA68PTbLdxQ7jRlHNpTF5jNKI6ttLxjpdHfVoimsWZsLujf0uvCWCnabXTdU
         hI8xzKeu6bK181PyVo6qCiC2aC2NCJZ9tD+gQ=
Received: by 10.204.161.194 with SMTP id s2mr2062487bkx.21.1276155063679; Thu, 
	10 Jun 2010 00:31:03 -0700 (PDT)
Received: by 10.204.53.206 with HTTP; Thu, 10 Jun 2010 00:31:03 -0700 (PDT)
In-Reply-To: <AANLkTik7p3H9xHbZz80-Zn6nXWy0txfe-ShJNlD241cH@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148835>

2010/6/9 Gustav H=E5llberg <gustav@gmail.com>:
> Turns out I forgot to push those changes; they've been pushed now.

Sigh, the patches had the wrong Committer; I've fixed that now.
Same patches, new SHA1s:

9680572 tutorial: Very minor typo fixes in the Emacs section
548ddfa stgit.el: Add stgit-{git,stg}-program variables
fefc11a stgit.el: Rearrange customizations a bit
0611554 stgit.el: Add "Customize StGit" menu entry
2c2b8ec stgit.el: Improve how "t h" mode finds old commits
006cd3e stgit.el: Make C-{up,down} move between groups of patches
6779943 stgit.el: Add a few links to some customization variables
b4f12bc stgit.el: Repair ! for historical commits
de8efe1 stgit.el: Honor stgit-find-copies-harder in stgit-diff-range
a27d0b7 stgit.el: Honor stgit-find-copies-harder when showing entire pa=
tches
108e5c8 stgit.el: Fix showing diff in file that has been both copied
and modified

- Gustav
