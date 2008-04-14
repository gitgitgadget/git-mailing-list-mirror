From: Eric Hanchrow <offby1@blarg.net>
Subject: Re: git repository size vs. subversion repository size
Date: Mon, 14 Apr 2008 08:28:47 -0700
Message-ID: <87y77ga21c.fsf@offby1.atm01.sea.blarg.net>
References: <1086fb5f0804041502s7ab12202y3b0ec3640425eff@mail.gmail.com> <20080404221728.GA30728@atjola.homenet> <p06240810c41c6e0993c1@[63.138.152.125]> <20080405000141.GA23633@dervierte>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 14 17:54:36 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlQlp-0004K6-9A
	for gcvg-git-2@gmane.org; Mon, 14 Apr 2008 17:39:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752588AbYDNPiQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Apr 2008 11:38:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752521AbYDNPiQ
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Apr 2008 11:38:16 -0400
Received: from main.gmane.org ([80.91.229.2]:38533 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752148AbYDNPiP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Apr 2008 11:38:15 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JlQl0-0004Dq-9K
	for git@vger.kernel.org; Mon, 14 Apr 2008 15:38:10 +0000
Received: from q-static-138-125.avvanta.com ([206.124.138.125])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 14 Apr 2008 15:38:10 +0000
Received: from offby1 by q-static-138-125.avvanta.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 14 Apr 2008 15:38:10 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: q-static-138-125.avvanta.com
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Cancel-Lock: sha1:wKKk5QK9qJGaczhjwn1PTMAAV40=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79510>

>>>>> "Steven" == Steven Walter <stevenrwalter@gmail.com> writes:

    Steven> git-gc is such an important step in importing a repository
    Steven> from svn.  Why doesn't git-svn take this vital step
    Steven> automatically?

Mine did:
    git-svn version 1.5.5 (svn 1.3.2)
    git-svn init file://$HOME/svn-repos
    git-svn fetch
...

            M	trunk/home/local/bin/spam/print-subjects.ss
    r5480 = b3edab03f5bacda1db025bd2cca769abbe007f23 (git-svn)
    Auto packing your repository for optimum performance. You may also
    run "git gc" manually. See "git help gc" for more information.
    Counting objects: 11182, done.
    Compressing objects: 100% (11021/11021), done.
    Writing objects: 100% (11182/11182), done.
    Total 11182 (delta 9378), reused 0 (delta 0)
    Checked out HEAD:
      file:///home/erich/svn-repos r5480

    $ du -sh /tmp/ya/.git/ ~/svn-repos/
    23M	/tmp/ya/.git/
    88M	/home/erich/svn-repos/
-- 
The old graybeards in the Smalltalk world may not seem
relevant, but if you ask them a question about ORM, they have been
thinking about it for 20 years.
        -- Avi Bryant
