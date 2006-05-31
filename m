From: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
Subject: Re: git --version
Date: Wed, 31 May 2006 21:13:03 +0200
Message-ID: <4d8e3fd30605311213m6f2f2660u90701ad6bd5daabc@mail.gmail.com>
References: <4d8e3fd30605301516l782ad81dk5b11074e88db90a4@mail.gmail.com>
	 <7vu077ywmw.fsf@assigned-by-dhcp.cox.net>
	 <4d8e3fd30605311158n9d669dgd6c392ee8d194b78@mail.gmail.com>
	 <7vac8yypxc.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 31 21:13:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FlW7x-0007aC-Ma
	for gcvg-git@gmane.org; Wed, 31 May 2006 21:13:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965101AbWEaTNG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 May 2006 15:13:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965109AbWEaTNG
	(ORCPT <rfc822;git-outgoing>); Wed, 31 May 2006 15:13:06 -0400
Received: from wr-out-0506.google.com ([64.233.184.230]:38431 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S965101AbWEaTNE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 May 2006 15:13:04 -0400
Received: by wr-out-0506.google.com with SMTP id i12so90216wra
        for <git@vger.kernel.org>; Wed, 31 May 2006 12:13:04 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=p+/wSUEOs55Rtbi8mCetd02HUrEMwX1uK7D/a/Zbq2i9qgdKYYUlsH4x4kzHcAd4hLGk1a2NuhOnjnrctiDb6Z+nq3CZfzN9S+fReE4pJz1Ab69Vq5ZoIc3hiRlBvzvKHME6ntVwkQu9Im4E9myYNJyo2P3fLVXWJEhA+ZzeY/M=
Received: by 10.65.159.17 with SMTP id l17mr650708qbo;
        Wed, 31 May 2006 12:13:04 -0700 (PDT)
Received: by 10.64.250.4 with HTTP; Wed, 31 May 2006 12:13:03 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vac8yypxc.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21076>

On 5/31/06, Junio C Hamano <junkio@cox.net> wrote:
> "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com> writes:
>
> > paolo@Italia:~$ cd git/
> > paolo@Italia:~/git$ git --version
> > git version 1.3.GIT
> > paolo@Italia:~/git$ make >/dev/null
> > paolo@Italia:~/git$ sudo make install >/dev/null
> > Password:
> > GIT_VERSION = 1.3.GIT
>
> Unfortunate is we cannot see what this "sudo" did -- does it
> successfully run (installed) git to check the "full" version and
> manage to store it in ./GIT-VERSION-FILE?

Just the few last lines:

install git-checkout-index git-clone-pack git-convert-objects
git-fetch-pack git-fsck-objects git-hash-object git-index-pack
git-local-fetch git-mailinfo git-merge-base git-merge-index git-mktag
git-mktree git-pack-objects git-patch-id git-peek-remote
git-prune-packed git-receive-pack git-rev-parse git-send-pack
git-shell git-show-index git-ssh-fetch git-ssh-upload git-unpack-file
git-unpack-objects git-update-index git-update-server-info
git-upload-pack git-verify-pack git-write-tree git-update-ref
git-symbolic-ref git-name-rev git-pack-redundant git-repo-config
git-var git-describe git-merge-tree git-blame git-imap-send
git-ssh-pull git-ssh-push git-http-fetch git-http-push
git-get-tar-commit-id git-mailsplit git-stripspace git-daemon
git-bisect git-branch git-checkout git-cherry git-clean git-clone
git-commit git-fetch git-ls-remote git-merge-one-file git-parse-remote
git-prune git-pull git-rebase git-repack git-request-pull git-reset
git-resolve git-revert git-sh-setup git-tag git-verify-tag
git-applymbox git-applypatch git-am git-merge git-merge-stupid
git-merge-octopus git-merge-resolve git-merge-ours git-lost-found
git-quiltimport git-archimport git-cvsimport git-relink git-shortlog
git-fmt-merge-msg git-rerere git-annotate git-cvsserver git-svnimport
git-mv git-cvsexportcommit git-send-email git-merge-recursive
git-cherry-pick git-status '/home/paolo/bin'
install git gitk '/home/paolo/bin'
make -C templates install
make[1]: Entering directory `/home/paolo/git/templates'
: no custom templates yet
install -d -m755 '/home/paolo/share/git-core/templates/'
(cd blt && tar cf - .) | \
        (cd '/home/paolo/share/git-core/templates/' && tar xf -)
make[1]: Leaving directory `/home/paolo/git/templates'
install -d -m755 '/home/paolo/share/git-core/python'
install gitMergeCommon.py '/home/paolo/share/git-core/python'
if test 'z/home/paolo/bin' != 'z/home/paolo/bin'; \
        then \
                ln -f '/home/paolo/bin/git' \
                        '/home/paolo/bin/git' || \
                cp '/home/paolo/bin/git' \
                        '/home/paolo/bin/git'; \
        fi
rm -f '/home/paolo/bin/git-log' && ln '/home/paolo/bin/git'
'/home/paolo/bin/git-log' ;  rm -f '/home/paolo/bin/git-whatchanged'
&& ln '/home/paolo/bin/git' '/home/paolo/bin/git-whatchanged' ;  rm -f
'/home/paolo/bin/git-show' && ln '/home/paolo/bin/git'
'/home/paolo/bin/git-show' ;  rm -f
'/home/paolo/bin/git-count-objects' && ln '/home/paolo/bin/git'
'/home/paolo/bin/git-count-objects' ;  rm -f
'/home/paolo/bin/git-diff' && ln '/home/paolo/bin/git'
'/home/paolo/bin/git-diff' ;  rm -f '/home/paolo/bin/git-push' && ln
'/home/paolo/bin/git' '/home/paolo/bin/git-push' ;  rm -f
'/home/paolo/bin/git-grep' && ln '/home/paolo/bin/git'
'/home/paolo/bin/git-grep' ;  rm -f '/home/paolo/bin/git-add' && ln
'/home/paolo/bin/git' '/home/paolo/bin/git-add' ;  rm -f
'/home/paolo/bin/git-rm' && ln '/home/paolo/bin/git'
'/home/paolo/bin/git-rm' ;  rm -f '/home/paolo/bin/git-rev-list' && ln
'/home/paolo/bin/git' '/home/paolo/bin/git-rev-list' ; rm -f
'/home/paolo/bin/git-check-ref-format' && ln '/home/paolo/bin/git'
'/home/paolo/bin/git-check-ref-format' ;  rm -f
'/home/paolo/bin/git-init-db' && ln '/home/paolo/bin/git'
'/home/paolo/bin/git-init-db' ;  rm -f '/home/paolo/bin/git-tar-tree'
&& ln '/home/paolo/bin/git' '/home/paolo/bin/git-tar-tree' ;  rm -f
'/home/paolo/bin/git-upload-tar' && ln '/home/paolo/bin/git'
'/home/paolo/bin/git-upload-tar' ;  rm -f
'/home/paolo/bin/git-format-patch' && ln '/home/paolo/bin/git'
'/home/paolo/bin/git-format-patch' ;  rm -f
'/home/paolo/bin/git-ls-files' && ln '/home/paolo/bin/git'
'/home/paolo/bin/git-ls-files' ;  rm -f '/home/paolo/bin/git-ls-tree'
&& ln '/home/paolo/bin/git' '/home/paolo/bin/git-ls-tree' ;  rm -f
'/home/paolo/bin/git-read-tree' && ln '/home/paolo/bin/git'
'/home/paolo/bin/git-read-tree' ;  rm -f
'/home/paolo/bin/git-commit-tree' && ln '/home/paolo/bin/git'
'/home/paolo/bin/git-commit-tree' ;  rm -f '/home/paolo/bin/git-apply'
&& ln '/home/paolo/bin/git' '/home/paolo/bin/git-apply' ;  rm -f
'/home/paolo/bin/git-show-branch' && ln '/home/paolo/bin/git'
'/home/paolo/bin/git-show-branch' ;  rm -f
'/home/paolo/bin/git-diff-files' && ln '/home/paolo/bin/git'
'/home/paolo/bin/git-diff-files' ;  rm -f
'/home/paolo/bin/git-diff-index' && ln '/home/paolo/bin/git'
'/home/paolo/bin/git-diff-index' ;  rm -f
'/home/paolo/bin/git-diff-stages' && ln '/home/paolo/bin/git'
'/home/paolo/bin/git-diff-stages' ;  rm -f
'/home/paolo/bin/git-diff-tree' && ln '/home/paolo/bin/git'
'/home/paolo/bin/git-diff-tree' ;  rm -f
'/home/paolo/bin/git-cat-file' && ln '/home/paolo/bin/git'
'/home/paolo/bin/git-cat-file' ;
paolo@Italia:~/git$ git --version

So yes, it's correctly installed (I pull, compile and install almost
daily always without any problem).

Ciao and thanks!

-- 
Paolo
http://paolociarrocchi.googlepages.com
