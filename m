X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: index manipulation quickref
Date: Tue, 12 Dec 2006 12:16:58 +0100
Organization: At home
Message-ID: <elm2ur$3ib$1@sea.gmane.org>
References: <fcaeb9bf0612120257p35dc9483ob65eea9ae21b5f7b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Tue, 12 Dec 2006 11:15:29 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 41
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-25-107.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34080>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gu5bX-0007F9-Lg for gcvg-git@gmane.org; Tue, 12 Dec
 2006 12:15:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932202AbWLLLPH (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 12 Dec 2006
 06:15:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932203AbWLLLPH
 (ORCPT <rfc822;git-outgoing>); Tue, 12 Dec 2006 06:15:07 -0500
Received: from main.gmane.org ([80.91.229.2]:44963 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S932202AbWLLLPF
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 12 Dec 2006 06:15:05 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gu5b8-0002IT-54 for git@vger.kernel.org; Tue, 12 Dec 2006 12:14:58 +0100
Received: from host-81-190-25-107.torun.mm.pl ([81.190.25.107]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Tue, 12 Dec 2006 12:14:58 +0100
Received: from jnareb by host-81-190-25-107.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Tue, 12 Dec 2006
 12:14:58 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Nguyen Thai Ngoc Duy wrote:

> I'm trying to collect all operations related to index from user
> perspective and corresponding commands. The list may be put to git
> wiki if people think it can help newbies:
> 
> update file content to index: git update-index file
Or "git add file" woth new git.

> add a file to index: git add file
> delete a file from index: git update-index --remove --force-remove
> (or remove that file in workdir and do git update-index --remove)
Or "git rm file" (old version did remove only from index, new version
is to remove also from working directory if it matches HEAD)

> read a tree to index: git read-tree treeish, git reset treeish
> read a file from a tree to index: git ls-tree <tree-ish> file|git
> update-index --index-info --stdin
> copy a file from index to workdir: git checkout-index file
Or just "git checkout -- file"

> refresh index: git update-index --refresh
> copy entire index to workdir: git checkout-index
Or just "git checkout"

> output a file from index to stdout: ?? (is there a command for this?)
"git cat-file -p ::<filename>"

> list files in index: git ls-files
> compare index and workdir file listing: 
>    git ls-files (with lots of options here) 
> diff between workdir and index: git diff
> diff between index and a tree: git diff --cached <tree-ish>

diff between workdir and tree: git diff <tree-ish> 

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

