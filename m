X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Salikh Zakirov <Salikh.Zakirov@Intel.com>
Subject: Re: [PATCH] Make git-clone --use-separate-remote the default
Date: Fri, 24 Nov 2006 12:58:47 +0300
Message-ID: <ek6for$ti5$1@sea.gmane.org>
References: <20061123225835.30071.99265.stgit@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 24 Nov 2006 09:59:28 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 12
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: msfwpr01.ims.intel.com
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
In-Reply-To: <20061123225835.30071.99265.stgit@machine.or.cz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32206>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GnXq3-0004nR-8i for gcvg-git@gmane.org; Fri, 24 Nov
 2006 10:59:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S934530AbWKXJ7Q (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 24 Nov 2006
 04:59:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934528AbWKXJ7Q
 (ORCPT <rfc822;git-outgoing>); Fri, 24 Nov 2006 04:59:16 -0500
Received: from main.gmane.org ([80.91.229.2]:43145 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S934530AbWKXJ7O (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 24 Nov 2006 04:59:14 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GnXpr-0004kj-1P for git@vger.kernel.org; Fri, 24 Nov 2006 10:59:07 +0100
Received: from msfwpr01.ims.intel.com ([62.118.80.132]) by main.gmane.org
 with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Fri, 24 Nov 2006 10:59:07 +0100
Received: from Salikh.Zakirov by msfwpr01.ims.intel.com with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Fri, 24 Nov 2006
 10:59:07 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Petr Baudis wrote:
> --- a/Documentation/git-clone.txt
> +++ b/Documentation/git-clone.txt
> ...
>  --use-separate-remote::
>  	Save remotes heads under `$GIT_DIR/remotes/origin/` instead
> -	of `$GIT_DIR/refs/heads/`.  Only the master branch is saved
> -	in the latter.

This description does not apply to repositories which do not have 'master' branch.
Maybe "only the HEAD branch of remote repository, where
HEAD is the branch designated as main branch in repository".
