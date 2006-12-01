X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andreas Ericsson <ae@op5.se>
Subject: Re: git and bzr
Date: Fri, 01 Dec 2006 10:55:28 +0100
Message-ID: <456FFC10.7060703@op5.se>
References: <ekhtnt$rkk$1@sea.gmane.org> <456C9DFF.1040407@onlinehome.de> <456CA981.4010808@onlinehome.de> <Pine.LNX.4.64.0611281346490.4244@woody.osdl.org> <456CB197.2030201@onlinehome.de> <Pine.LNX.4.64.0611281413310.4244@woody.osdl.org> <Pine.LNX.4.63.0611291149440.30004@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.64.0611290922410.3513@woody.osdl.org> <456DD76C.4010902@gmx.net> <456ECDAF.4050102@op5.se> <20061130200122.GD10999@thunk.org> <ekndmb$7e9$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 1 Dec 2006 09:56:00 +0000 (UTC)
Cc: git@vger.kernel.org, bazaar-ng@lists.canonical.com
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
In-Reply-To: <ekndmb$7e9$1@sea.gmane.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32882>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gq57L-0002fI-Bq for gcvg-git@gmane.org; Fri, 01 Dec
 2006 10:55:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1759299AbWLAJzf (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 04:55:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759297AbWLAJzf
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 04:55:35 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:60554 "EHLO
 smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1759299AbWLAJze (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006 04:55:34 -0500
Received: from [192.168.1.20] (unknown [213.88.215.14]) by smtp-gw1.op5.se
 (Postfix) with ESMTP id 6D9506BCC2; Fri,  1 Dec 2006 10:55:30 +0100 (CET)
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Jakub Narebski wrote:
> Theodore Tso wrote:
> 
>>        * When no <ent> is given, the working tree and the index file
>>           is compared, using git-diff-files.
> 
>  *  When no <tree-ish> is given, the working tree and  the  index  file  are
>     compared, using git-diff-files.
> 
> Use more modern git.

More modern git (pull'ed 10 minutes ago) has this, at least when cut 
from Documentation/git-diff.txt:
---%<---%<---%<---
SYNOPSIS
--------
'git-diff' [ --diff-options ] <tree-ish>{0,2} [<path>...]

DESCRIPTION
-----------
Show changes between two trees, a tree and the working tree, a
tree and the index file, or the index file and the working tree.
The combination of what is compared with what is determined by
the number of trees given to the command.

* When no <tree-ish> is given, the working tree and the index
   file are compared, using `git-diff-files`.

* When one <tree-ish> is given, the working tree and the named
   tree are compared, using `git-diff-index`.  The option
   `--index` can be given to compare the index file and
   the named tree.
   `--cached` is a deprecated alias for `--index`. It's use is
   discouraged.

* When two <tree-ish>s are given, these two trees are compared
   using `git-diff-tree`.
---%<---%<---%<---

This needs an update, I think. I'll look into it on sunday if no-one's 
beaten me to it.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
