X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: multiple branches or  multiple repositories
Date: Fri, 03 Nov 2006 02:51:30 +0100
Message-ID: <eie7ae$ib6$1@sea.gmane.org>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 3 Nov 2006 02:10:43 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 17
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: muurbloem.xs4all.nl
User-Agent: Thunderbird 1.5.0.7 (X11/20061027)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30768>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfoU8-0004OM-66 for gcvg-git@gmane.org; Fri, 03 Nov
 2006 03:08:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752939AbWKCCIM (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 2 Nov 2006
 21:08:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752937AbWKCCIL
 (ORCPT <rfc822;git-outgoing>); Thu, 2 Nov 2006 21:08:11 -0500
Received: from main.gmane.org ([80.91.229.2]:60594 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1752939AbWKCCIK (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 2 Nov 2006 21:08:10 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GfoP0-0002Pk-LE for git@vger.kernel.org; Fri, 03 Nov 2006 03:03:26 +0100
Received: from muurbloem.xs4all.nl ([213.84.26.127]) by main.gmane.org with
 esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>;
 Fri, 03 Nov 2006 03:03:26 +0100
Received: from hanwen by muurbloem.xs4all.nl with local (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Fri, 03 Nov 2006 03:03:26
 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org


We're in the process of converting the LilyPond CVS repository at 
savannah.gnu.org to GIT.  One of the questions we need to deal with, is 
how handle modules.

There seem to be two approaches:

  - for each module, create a separate git repository.  Inside the 
repository, each subproject has its own branching

  - put each module as a separate branch in a shared repository.

I think the first option is the most natural one, but are there any 
issues, besides namespace pollution to the second option?

-- 
  Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
