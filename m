X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: master and origin
Date: Sun, 29 Oct 2006 22:01:03 +0100
Organization: At home
Message-ID: <ei34qd$emn$1@sea.gmane.org>
References: <4d8e3fd30610291253s2d8000dfx942e0fa20e0057f6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Sun, 29 Oct 2006 21:01:30 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 29
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-18-116.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30460>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GeHmP-0004Cz-Mj for gcvg-git@gmane.org; Sun, 29 Oct
 2006 22:01:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030247AbWJ2VBO (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 29 Oct 2006
 16:01:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030254AbWJ2VBO
 (ORCPT <rfc822;git-outgoing>); Sun, 29 Oct 2006 16:01:14 -0500
Received: from main.gmane.org ([80.91.229.2]:17550 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1030247AbWJ2VBM (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 29 Oct 2006 16:01:12 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GeHmF-0004Ab-DX for git@vger.kernel.org; Sun, 29 Oct 2006 22:01:07 +0100
Received: from host-81-190-18-116.torun.mm.pl ([81.190.18.116]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Sun, 29 Oct 2006 22:01:07 +0100
Received: from jnareb by host-81-190-18-116.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Sun, 29 Oct 2006
 22:01:07 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Paolo Ciarrocchi wrote:

> I went trough the docs I found on the web but I still don't fully
> understand why if I clone a remote repository my local copy has two
> branches, origin (that is always a exact copy of the remote
> repository) and master which is... what? The branch supposed to be
> used for local development?
> 
> I'm used to just checkout to a new branch, do my own development and
> then diff against origin so I'm missing why I see the master branch.
> 
> I'm sure I'm missing something very fundamental but I cannot figure
> out what is it :-)

Nothing very fundamental. The 'master' branch is (as name indicates)
default branch on which you do your own development. The 'origin' branch
is used to track 'master' branch in the repository you cloned from.
If you don't do your development on 'master', but use other branches,
the 'master'/'origin' is unnecessary; you could fetch 'master' into
'master'...

By the way, if you clone with --use-separate-remote you would get
separate namespace for tracking branches; additionally they would
be treated read-only (can't commit to).
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

