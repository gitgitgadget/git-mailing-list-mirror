From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: RE: What's cooking in git.git (May 2014, #05; Fri, 23)
Date: Fri, 23 May 2014 18:17:16 -0500
Message-ID: <537fd6fc10cfd_707c65304ef@nysa.notmuch>
References: <xmqqppj4gm96.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 24 01:28:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnytE-0000vx-Jy
	for gcvg-git-2@plane.gmane.org; Sat, 24 May 2014 01:28:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751154AbaEWX2h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2014 19:28:37 -0400
Received: from mail-oa0-f52.google.com ([209.85.219.52]:56224 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751010AbaEWX2g (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2014 19:28:36 -0400
Received: by mail-oa0-f52.google.com with SMTP id eb12so6210720oac.25
        for <git@vger.kernel.org>; Fri, 23 May 2014 16:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-type:content-transfer-encoding;
        bh=Hpdl6VI3koAcNsAH1CScJPHSfJhomSEzxU1iJfEwvbI=;
        b=J0lXVog/E23/SpeqScQBbFsD8249x0wGGhQ30kf+xjA08KSrdf0EqiCTaYvyrHebIY
         8ibLoikEJg1MGYkJ0M+h5YSQPiiYw8aMwExvu0meHKjZG0C3+Gs5xnEF5pV9dSFwos7t
         Cfq+DeQVnbdHjhaCoBiVMhXhiYd+oZ63QjZYgfMklzz2V+PzcK0x3xRi3j1+4CeCrpBo
         wpKsKDxV4ZSTvyNoIPhbHM8986cnKK04/pO5L6+FBTC1+HOMkrueAAqyDUWZ6yv7JqVu
         8biu5nx1a9U7hpUNViTDhhUP+mOWvRAnnPIusuzcawRmlnV9tZhsj+BhLqUWBp731A1r
         cDgw==
X-Received: by 10.182.24.230 with SMTP id x6mr6766079obf.75.1400887716134;
        Fri, 23 May 2014 16:28:36 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id js4sm15173061oeb.3.2014.05.23.16.28.34
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 May 2014 16:28:35 -0700 (PDT)
In-Reply-To: <xmqqppj4gm96.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250047>

Junio C Hamano wrote:
> * fc/publish-vs-upstream (2014-04-21) 8 commits
>  . sha1_name: add support for @{publish} marks
>  . sha1_name: simplify track finding
>  . sha1_name: cleanup interpret_branch_name()
>  . branch: display publish branch
>  . push: add --set-publish option
>  . branch: add --set-publish-to option
>  . Add concept of 'publish' branch
>  . t5516 (fetch-push): fix test restoration
> 
>  Add branch@{publish}; it seems that this is somewhat different from
>  Ram and Peff started working on.  At least the tip needs to be
>  rerolled not to squat on @{p} which @{push} and possibly @{pull}
>  may want to share.
> 
>  Ejected from 'pu' to unclutter.

Sure, to "unclutter".

Either way I'm not going to pursue this anymore. I've made changes since
I sent those patches, for those who want this feature, you can find the
latest patches here:

https://github.com/felipec/git/commits/fc/publish

Or just use git-fc.

> * fc/remote-hg-fixes-for-hg-3.0 (2014-05-08) 5 commits
>  . [DONTMERGE-not signed-off] remote-hg: work with older versions of mercurial
>  . remote-hg: add support for hg v3.0
>  . t: remote-hg: trivial cleanups and fixes
>  . t: remote-hg: add file operation tests
>  . remote-hg: add more tests
> 
>  No longer relevant, as 'master' unbundles contrib/remote-helpers/.

And for the record, the branch was never properly named, as those
patches are *not* "for hg 3.0".

> * fc/remote-helpers-hg-bzr-graduation (2014-04-29) 11 commits
>  . remote-hg: trivial cleanups
>  . remote-hg: make sure we omit multiple heads
>  . git-remote-hg: use internal clone's hgrc
>  . t: remote-hg: split into setup test
>  . remote-hg: properly detect missing contexts
>  . remote-{hg,bzr}: store marks only on success
>  . remote-hg: update to 'public' phase when pushing
>  . remote-hg: fix parsing of custom committer
>   (merged to 'next' on 2014-04-22 at fed170a)
>  + remote-helpers: move tests out of contrib
>  + remote-helpers: move out of contrib
>  + remote-helpers: squelch python import exceptions
> 
>  No longer relevant, as 'master' unbundles contrib/remote-helpers/.

Again a badly named branch; those changes are independent of the
"graduation".

-- 
Felipe Contreras
