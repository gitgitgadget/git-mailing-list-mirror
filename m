X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Show remote branches on gitweb
Date: Sat, 25 Nov 2006 01:12:55 +0100
Organization: At home
Message-ID: <ek81mv$qd8$1@sea.gmane.org>
References: <loom.20061124T210559-701@post.gmane.org> <ek7jsp$j83$1@sea.gmane.org> <ek7m6m$qqd$1@sea.gmane.org> <20061124235911.GO7201@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Sat, 25 Nov 2006 00:11:36 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 28
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32249>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gnl8o-0007jV-SD for gcvg-git@gmane.org; Sat, 25 Nov
 2006 01:11:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935014AbWKYALb (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 24 Nov 2006
 19:11:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935018AbWKYALb
 (ORCPT <rfc822;git-outgoing>); Fri, 24 Nov 2006 19:11:31 -0500
Received: from main.gmane.org ([80.91.229.2]:37802 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S935014AbWKYALa (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 24 Nov 2006 19:11:30 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gnl8j-0007i3-MV for git@vger.kernel.org; Sat, 25 Nov 2006 01:11:29 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Sat, 25 Nov 2006 01:11:29 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Sat, 25 Nov 2006
 01:11:29 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Petr Baudis wrote:

> On Fri, Nov 24, 2006 at 09:56:29PM CET, Jakub Narebski wrote:
>> Jakub Narebski wrote:
>> 
>>> Pazu wrote:
>>> 
>>>> Is there any way to do it? I'm using git-svn to track a remote subversion
>>>> repository, and it would be very nice to browse the history for a remote branch
>>>> for which I didn't start a local branch yet.
>>> 
>>> Planned, not implemented yet.
>> 
>> The problem is that to implement it _well_ we have to get remotes, both
>> $GIT_DIR/remotes and config remote.xxx, info. And the latter (config
>> remotes info) needs config parsing, something we lack.
> 
> Does that mean we _can_ parse $GIT_DIR/remotes? ;-)

No, but for implementing showing remote branches in gitweb _well_,
but without frills'n'whistles, it is enough to know files in
$GIT_DIR/remotes (Find::find those files), and don't need to parse
remotes/ files.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

