X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: svn versus git
Date: Fri, 15 Dec 2006 13:56:41 +0100
Organization: At home
Message-ID: <elu5tk$g4c$1@sea.gmane.org>
References: <200612132200.41420.andyparkins@gmail.com> <200612142000.54409.arekm@maven.pl> <Pine.LNX.4.63.0612150009230.3635@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Fri, 15 Dec 2006 12:55:29 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 33
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-25-107.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34502>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvCb0-0005AN-82 for gcvg-git@gmane.org; Fri, 15 Dec
 2006 13:55:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752093AbWLOMzR (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 15 Dec 2006
 07:55:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752090AbWLOMzR
 (ORCPT <rfc822;git-outgoing>); Fri, 15 Dec 2006 07:55:17 -0500
Received: from main.gmane.org ([80.91.229.2]:53092 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1752085AbWLOMzP
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 15 Dec 2006 07:55:15 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GvCaO-0000dY-21 for git@vger.kernel.org; Fri, 15 Dec 2006 13:54:48 +0100
Received: from host-81-190-25-107.torun.mm.pl ([81.190.25.107]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Fri, 15 Dec 2006 13:54:48 +0100
Received: from jnareb by host-81-190-25-107.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Fri, 15 Dec 2006
 13:54:48 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Johannes Schindelin wrote:

> On Thu, 14 Dec 2006, Arkadiusz Miskiewicz wrote:
> 
>> ps. I'm blind or there is no documentation about what utilities are 
>> needed to get git fully working? (like sed, coreutils, grep, rcs package 
>> (merge tool afaik needed)...).
> 
> Open the file "INSTALL".

Which doesn't mention 'sed' for example. 


I have checked only commands in POSIX shell script; this list does not
include tests in t/ directory, which uses multitude of other tools.

Git has built-in grep since at least v1.4.0, but 'grep' is used in
generate-cmdlist.sh, git-commit.sh, git-instaweb.sh, git-quiltimport.sh and
git-tag.sh. 

'cut' is used only in git-instaweb.sh; other commands do without it.
'sort' is used in check-builtins.sh, generate-cmdlist.sh, git-ls-remote.sh,
git-tag.sh. Both tools are from coreutils package. And git uses other tools
from coreutils too: uniq, printf, tail,...

Git has built-in diff since at least v1.4.0, but diff is used in
git-merge-one-file.sh

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

