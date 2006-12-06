X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: Re: git patch
Date: Wed, 06 Dec 2006 10:55:09 +0100
Message-ID: <4576937D.1070402@xs4all.nl>
References: <4574AC9E.3040506@gmail.com> <4574BF70.8070100@lilypond.org> <45760545.2010801@gmail.com> <Pine.LNX.4.63.0612060053400.28348@wbgn013.biozentrum.uni-wuerzburg.de> <45761451.8020006@gmail.com> <Pine.LNX.4.63.0612060157020.28348@wbgn013.biozentrum.uni-wuerzburg.de>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 6 Dec 2006 09:55:38 +0000 (UTC)
Cc: lily-devel <lilypond-devel@gnu.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 28
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 82-171-213-190.dsl.ip.tiscali.nl
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
In-Reply-To: <Pine.LNX.4.63.0612060157020.28348@wbgn013.biozentrum.uni-wuerzburg.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33413>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrtUz-0007Gy-K0 for gcvg-git@gmane.org; Wed, 06 Dec
 2006 10:55:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1760402AbWLFJzb (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 04:55:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760396AbWLFJzb
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 04:55:31 -0500
Received: from main.gmane.org ([80.91.229.2]:44035 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1760402AbWLFJza
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec 2006 04:55:30 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GrtUf-0007pd-If for git@vger.kernel.org; Wed, 06 Dec 2006 10:55:13 +0100
Received: from 82-171-213-190.dsl.ip.tiscali.nl ([82.171.213.190]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Wed, 06 Dec 2006 10:55:13 +0100
Received: from hanwen by 82-171-213-190.dsl.ip.tiscali.nl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Wed, 06 Dec 2006
 10:55:13 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Johannes Schindelin escreveu:
> The nice thing for me about Git: you never lose anything. Unless you say 
> "git prune" (in which case you really should know what you are doing), you 
> do not lose (committed) data.
> 
> Now, I promised to tell you what to do if all the files seem modified. Did 
> you look through "git -p diff"? (BTW with recent Git you only need "git 
> diff" and it will pipe the result into your pager automatically.)

This actually bothers me as well from a UI point of view.  Git-diff is
used both for generating diffs between versions that come from git and
the working tree/index.

I think it would be more logical to show those diffs as part of
git-status and perhaps git-commit, eg.

  git-commit --dry-run <commitoptions>

shows the diff of what would be committed

  git-status --diff

shows diffs of modified files in the working tree.

This makes it more clear what each diff means.

-- 
 Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
