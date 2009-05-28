From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Strangely hosed git install
Date: Thu, 28 May 2009 09:22:13 +0200
Message-ID: <46a038f90905280022s1c07565bnf26335fccf7c7e94@mail.gmail.com>
References: <46a038f90905280008h5510d03aj5f6e5728ca075027@mail.gmail.com>
	 <7vprdthezg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 28 09:22:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9ZwW-00050v-Ea
	for gcvg-git-2@gmane.org; Thu, 28 May 2009 09:22:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752309AbZE1HWO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2009 03:22:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751183AbZE1HWO
	(ORCPT <rfc822;git-outgoing>); Thu, 28 May 2009 03:22:14 -0400
Received: from mail-fx0-f168.google.com ([209.85.220.168]:51868 "EHLO
	mail-fx0-f168.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752016AbZE1HWN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2009 03:22:13 -0400
Received: by fxm12 with SMTP id 12so3474062fxm.37
        for <git@vger.kernel.org>; Thu, 28 May 2009 00:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=bw14qzLQQzXP4OTRqLvB737GWTGDfqUOpFN+cq/3zhY=;
        b=RyEskOD8YJHblfIf4L+yjOjmqkhERkEWqMiIP2deNPPdmwJb7SSaDJns4dfI9FNCYb
         9kNpIxyLbtzYr79DKHnPKenWMJ0/q94Vw3AeKx3p4yR2ZtoQwmE70udU6K83nBPuoZza
         IUTBEAOuCjcch5Go/QJH17+rPAI0sgLYwnyDI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=BpubzQkZprwcwagDqk01xNTjTzZaBh/1uAMBuDrzaN8Jql5FGtfrQPaXGiyr7Q8hnE
         5Rdc5uq0XDD5BlifCWDhVB+TJAyiF8up8EROVO32OtTobC7PCGwpjdvFjHe9Wwn8owZq
         VUqiz5Fh19YkHD36+/2Rlfy33n00t6CfYa9kA=
Received: by 10.223.116.205 with SMTP id n13mr804261faq.103.1243495333550; 
	Thu, 28 May 2009 00:22:13 -0700 (PDT)
In-Reply-To: <7vprdthezg.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120163>

On Thu, May 28, 2009 at 9:18 AM, Junio C Hamano <gitster@pobox.com> wrote:
> "type --all git"?
> "git --exec-path"?
> "ls $(git --exec-path)"?
>

It all looks fairly correct to me:

$ type --all git
git is /home/martin/bin/git
$ git --exec-path
/home/martin/libexec/git-core
$ ls $(git --ex
ec-path)
git                    git-merge-index
git-add                git-merge-octopus
git-add--interactive   git-merge-one-file
git-am                 git-merge-ours
git-annotate           git-merge-recursive
git-apply              git-merge-resolve
git-archimport         git-merge-stupid
git-archive            git-merge-subtree
git-bisect             git-mergetool
git-bisect--helper     git-mergetool--lib
git-blame              git-merge-tree
git-branch             git-mktag
git-bundle             git-mktree
git-cat-file           git-mv
git-check-attr         git-name-rev
git-checkout           git-pack-objects
git-checkout-index     git-pack-redundant
git-check-ref-format   git-pack-refs
git-cherry             git-parse-remote
git-cherry-pick        git-patch-id
git-citool             git-peek-remote
git-clean              git-prune
git-clone              git-prune-packed
git-commit             git-pull
git-commit-tree        git-push
git-config             git-quiltimport
git-count-objects      git-read-tree
git-cvsexportcommit    git-rebase
git-cvsimport          git-rebase--interactive
git-cvsserver          git-receive-pack
git-daemon             git-reflog
git-describe           git-relink
git-diff               git-remote
git-diff-files         git-repack
git-diff-index         git-repo-config
git-difftool           git-request-pull
git-difftool--helper   git-rerere
git-diff-tree          git-reset
git-fast-export        git-revert
git-fast-import        git-rev-list
git-fetch              git-rev-parse
git-fetch-pack         git-rm
git-fetch--tool        git-send-email
git-filter-branch      git-send-pack
git-fmt-merge-msg      git-shell
git-for-each-ref       git-shortlog
git-format-patch       git-show
git-fsck               git-show-branch
git-fsck-objects       git-show-index
git-gc                 git-show-ref
git-get-tar-commit-id  git-sh-setup
git-grep               git-stage
git-gui                git-stash
git-gui--askpass       git-status
git-hash-object        git-stripspace
git-help               git-submodule
git-help--browse       git-svn
git-http-fetch         git-symbolic-ref
git-http-push          git-tag
git-imap-send          git-tar-tree
git-index-pack         git-unpack-file
git-init               git-unpack-objects
git-init-db            git-update-index
git-instaweb           git-update-ref
git-log                git-update-server-info
git-lost-found         git-upload-archive
git-ls-files           git-upload-pack
git-ls-remote          git-var
git-ls-tree            git-verify-pack
git-mailinfo           git-verify-tag
git-mailsplit          git-web--browse
git-merge              git-whatchanged
git-merge-base         git-write-tree
git-merge-file

cheers,


m
-- 
 martin.langhoff@gmail.com
 martin@laptop.org -- School Server Architect
 - ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
