X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: Re: git patch
Date: Wed, 06 Dec 2006 12:27:18 +0100
Message-ID: <4576A916.7090801__8302.57246639139$1165404468$gmane$org@xs4all.nl>
References: <4574AC9E.3040506@gmail.com> <4574BF70.8070100@lilypond.org> <45760545.2010801@gmail.com> <Pine.LNX.4.63.0612060053400.28348@wbgn013.biozentrum.uni-wuerzburg.de> <45761451.8020006@gmail.com> <Pine.LNX.4.63.0612060157020.28348@wbgn013.biozentrum.uni-wuerzburg.de> <4576937D.1070402@xs4all.nl> <Pine.LNX.4.63.0612061105220.28348@wbgn013.biozentrum.uni-wuerzburg.de> <457698E0.80207@lilypond.org> <Pine.LNX.4.63.0612061147540.28348@wbgn013.biozentrum.uni-wuerzburg.de>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 6 Dec 2006 11:27:48 +0000 (UTC)
Cc: lily-devel <lilypond-devel@gnu.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 29
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: muurbloem.xs4all.nl
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
In-Reply-To: <Pine.LNX.4.63.0612061147540.28348@wbgn013.biozentrum.uni-wuerzburg.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33435>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GruwA-0001lT-9I for gcvg-git@gmane.org; Wed, 06 Dec
 2006 12:27:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1760498AbWLFL1d (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 06:27:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760495AbWLFL1d
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 06:27:33 -0500
Received: from main.gmane.org ([80.91.229.2]:43351 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1760499AbWLFL1c
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec 2006 06:27:32 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gruvp-0001ZP-TH for git@vger.kernel.org; Wed, 06 Dec 2006 12:27:21 +0100
Received: from muurbloem.xs4all.nl ([213.84.26.127]) by main.gmane.org with
 esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>;
 Wed, 06 Dec 2006 12:27:21 +0100
Received: from hanwen by muurbloem.xs4all.nl with local (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Wed, 06 Dec 2006 12:27:21
 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Johannes Schindelin escreveu:
>> shows the diff of the change that he just introduced
> 
> Okay. But you mean
> 
> $ git commit --dry file1 file2...
> 
> or
> 
> $ git commit --dry -a


Well, --dry would be usable both with -a and file1, file2.

I agree with Jakub that --diff might be a better name, but it should 
be part of git-commit command, rather than the git-diff.

> Or, you use the script git-hunk-commit.bash which I posted. Which reminds 
> me: I wanted to rewrite it for you so it is more non-brand-new-bash 
> friendly.

:)

that's really nice, but actually recording separate hunks is a bit of
a headache if you have to do it over the command line. Under darcs, I
always use darcsum in emacs. In git, I always use git-status.
  
-- 
 Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
