X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git-show --stat on first commit
Date: Tue, 21 Nov 2006 19:16:44 +0100
Organization: At home
Message-ID: <ejvfng$cj6$1@sea.gmane.org>
References: <200611211341.48862.andyparkins@gmail.com> <8aa486160611210609h1c2d229ekf0b5e8aeb4f21f11@mail.gmail.com> <slrnem694k.4lm.Peter.B.Baumann@xp.machine.xx> <Pine.LNX.4.64.0611210820100.3338@woody.osdl.org> <20061121180643.GC7201@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Tue, 21 Nov 2006 18:15:59 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 29
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32012>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gma9d-0006RQ-8A for gcvg-git@gmane.org; Tue, 21 Nov
 2006 19:15:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031179AbWKUSPa (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 21 Nov 2006
 13:15:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031259AbWKUSPa
 (ORCPT <rfc822;git-outgoing>); Tue, 21 Nov 2006 13:15:30 -0500
Received: from main.gmane.org ([80.91.229.2]:12744 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1031179AbWKUSP3 (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 21 Nov 2006 13:15:29 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gma9U-0006OG-Mc for git@vger.kernel.org; Tue, 21 Nov 2006 19:15:24 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Tue, 21 Nov 2006 19:15:24 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Tue, 21 Nov 2006
 19:15:24 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Petr Baudis wrote:

> On Tue, Nov 21, 2006 at 05:31:30PM CET, Linus Torvalds wrote:
>> git didn't end up doing that (and I'm personally pretty happy about it), 
>> but it was one of the things I was kind of thinking about: a "git import" 
>> kind of thing would have created an initial commit which was pre-populated 
>> with the thing to import, and a "git init-db" would have created an 
>> initial root commit that was empty.
>> 
>> That would have made the current "don't show the root diff" behaviour very 
>> natural (and you'd still have gotten the initial diff for a new project), 
>> but on the other hand, it would have had that annoying unnecessary "init" 
>> commit, and you'd _still_ have wanted to have something like "--root" in 
>> order to show the import commit as a patch (which you _sometimes_ want to 
>> do).
> 
> It's being asked by users time by time (first in April last year ;) and
> I'm not sure about any good answer I should tell them, so is the reason
> for not doing the implicit empty commit that it would be "annoying" I
> suppose in the log output?

git repo-config show.difftree --root
git repo-config whatchanged.difftree --root

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

