X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Two conceptually distinct commit commands
Date: Tue, 05 Dec 2006 02:19:50 +0100
Organization: At home
Message-ID: <el2hbm$oi0$1@sea.gmane.org>
References: <cworth@cworth.org> <200612050052.kB50qcn2026534@laptop13.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Tue, 5 Dec 2006 01:18:52 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 47
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33281>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrOxH-0006DF-PH for gcvg-git@gmane.org; Tue, 05 Dec
 2006 02:18:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967959AbWLEBSl (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006
 20:18:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967960AbWLEBSl
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 20:18:41 -0500
Received: from main.gmane.org ([80.91.229.2]:43673 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S967959AbWLEBSk
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 4 Dec 2006 20:18:40 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GrOwp-00042P-65 for git@vger.kernel.org; Tue, 05 Dec 2006 02:18:15 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Tue, 05 Dec 2006 02:18:15 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Tue, 05 Dec 2006
 02:18:15 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Horst H. von Brand wrote:

> Carl Worth <cworth@cworth.org> wrote:
> 
> [...]
> 
>> Proposal
>> -------
>> Here are the two commit commands I would like to see in git:
>> 
>>   commit-index-content [paths...]
>> 
>>     Commits the content of the index for the given paths, (or all
>>     paths in the index). The index content can be manipulated with
>>     "git add", "git rm", "git mv", and "git update-index".
>> 
>>   commit-working-tree-content [paths...]
>> 
>>     Commits the content of the working tree for the given paths, (or
>>     all tracked paths). Untracked files can be committed for the first
>>     time by specifying their names on the command-line or by using
>>     "git add" to add them just prior to the commit. Any rename or
>>     removal of a tracked file will be detected and committed
>>     automatically.
> 
> Edit somefile with, e.g, emacs: Get backup called somefile~
> Realize that somefile is nonsense, delete it(s edited version)
> commit-working-tree-contents: Now you have the undesirable somefile~ saved

No, you don't, assuming that you have *~ in .gitignore or .git/info/exclude

> Edit somefile, utterly changing it: Get backup called somefile~
> mv somefile newfile
> commit-working-tree-contents: somefile~ saved, newfile lost

No, assuming that you use git-mv as you should.

> Edit somefile a bit, move it to newfile. Make sure no backups left over.
> commit-working-tree-contents: somefile deleted, newfile lost

No, as above.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

