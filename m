X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: tracking separate branches with RSS
Date: Tue, 14 Nov 2006 01:44:36 +0100
Message-ID: <ejb3hh$nvr$1@sea.gmane.org>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 14 Nov 2006 00:44:52 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 31
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: muurbloem.xs4all.nl
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31329>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GjmPw-0001Dm-LP for gcvg-git@gmane.org; Tue, 14 Nov
 2006 01:44:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933276AbWKNAop (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 13 Nov 2006
 19:44:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933278AbWKNAop
 (ORCPT <rfc822;git-outgoing>); Mon, 13 Nov 2006 19:44:45 -0500
Received: from main.gmane.org ([80.91.229.2]:40589 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S933277AbWKNAoo (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 13 Nov 2006 19:44:44 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GjmPo-0001CL-C5 for git@vger.kernel.org; Tue, 14 Nov 2006 01:44:40 +0100
Received: from muurbloem.xs4all.nl ([213.84.26.127]) by main.gmane.org with
 esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>;
 Tue, 14 Nov 2006 01:44:40 +0100
Received: from hanwen by muurbloem.xs4all.nl with local (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Tue, 14 Nov 2006 01:44:40
 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org


Hello,

I think that the shortlog / RSS support in gitweb is really neat. 
However, it seems to track only the master branch.

In our repository (http://git.sv.gnu.org/gitweb/?p=lilypond.git;a=summary),
we track two completely disparate branches in one repository: we have 
both the project and the website for the project in branches

   master

and

   web/master

Unfortunately,  I don't seem to get any updates in my RSS reader when I 
push something  to web/master. Would it be possible have a separate feed 
for each branch?  I tried looking at the gitweb script, but my perl-fu 
is too weak to figure out how to pass an argument from the URL into a 
git_rss() to replace  the

   git_get_head_hash($project)

call.

A second possibility -less desirable, but better than nothing- is to 
have commits from all branches show up in the shortlog and the RSS feed.

-- 
  Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
