X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git and bzr
Date: Thu, 30 Nov 2006 12:58:53 +0100
Organization: At home
Message-ID: <ekmgud$oss$1@sea.gmane.org>
References: <45357CC3.4040507@utoronto.ca> <456CB197.2030201@onlinehome.de> <Pine.LNX.4.64.0611281413310.4244@woody.osdl.org> <Pine.LNX.4.63.0611291149440.30004@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.64.0611290922410.3513@woody.osdl.org> <456DD76C.4010902@gmx.net> <Pine.LNX.4.64.0611291235590.3513@woody.osdl.org> <87bqmpvlxf.wl%cworth@cworth.org> <456E8147.9070304@gmx.net> <Pine.LNX.4.63.0611301111310.30004@wbgn013.biozentrum.uni-wuerzburg.de> <fcaeb9bf0611300325r3a3fa8av141359c69d2377b5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Thu, 30 Nov 2006 11:58:02 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 31
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32724>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpkXz-0004U0-N9 for gcvg-git@gmane.org; Thu, 30 Nov
 2006 12:57:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936230AbWK3L5o (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 06:57:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936234AbWK3L5o
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 06:57:44 -0500
Received: from main.gmane.org ([80.91.229.2]:40328 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S936230AbWK3L5n (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006 06:57:43 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GpkXl-0004R1-Vo for git@vger.kernel.org; Thu, 30 Nov 2006 12:57:33 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Thu, 30 Nov 2006 12:57:33 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Thu, 30 Nov 2006
 12:57:33 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Nguyen Thai Ngoc Duy wrote:

> On 11/30/06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>> But here's an idea: tell the user that she has to tell git-commit which
>> files she wants committed. Yes! That's it. Just tell it the friggin'
>> files. And if you are a lazy bum, and want to commit _all_ modified
>> files, git has a nice shortcut for ya: "-a".
> 
> It reminds me Microsoft Office Assistant :-) Let's make "git assistant
> mode" that tries hard to guess user's desires and give them guidance.
> Once they get used to git, they can disable that mode and back to
> "plain git".

The 'givor' (pun on Vi 'vigor') or 'gitor', or 'gator'.

$ git commit
[...]
nothing to commit
$ givor
$ git commit
Givor: You haven't marked any file for commit using "git-update-index <file>"
Givor: and you didn't provide files to commit with "git commit <file>"
Givor: so I assume that you wanted to commit all changed files
Givor: You can use "git commit -a" for that (-a is for --all)

;-)
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

