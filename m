X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git-show --stat on first commit
Date: Tue, 21 Nov 2006 21:03:18 +0100
Organization: At home
Message-ID: <ejvlv9$781$1@sea.gmane.org>
References: <200611211341.48862.andyparkins@gmail.com> <8aa486160611210609h1c2d229ekf0b5e8aeb4f21f11@mail.gmail.com> <slrnem694k.4lm.Peter.B.Baumann@xp.machine.xx> <Pine.LNX.4.64.0611210820100.3338@woody.osdl.org> <20061121180643.GC7201@pasky.or.cz> <ejvfng$cj6$1@sea.gmane.org> <20061121182135.GD7201@pasky.or.cz> <7v64d8y4tu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Tue, 21 Nov 2006 20:03:31 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 26
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32031>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gmbpu-0005jf-9R for gcvg-git@gmane.org; Tue, 21 Nov
 2006 21:03:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031372AbWKUUDK (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 21 Nov 2006
 15:03:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031373AbWKUUDK
 (ORCPT <rfc822;git-outgoing>); Tue, 21 Nov 2006 15:03:10 -0500
Received: from main.gmane.org ([80.91.229.2]:4266 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1031351AbWKUUDJ (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 21 Nov 2006 15:03:09 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gmbou-0005P2-Ge for git@vger.kernel.org; Tue, 21 Nov 2006 21:02:16 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Tue, 21 Nov 2006 21:02:16 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Tue, 21 Nov 2006
 21:02:16 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote:

> Petr Baudis <pasky@suse.cz> writes:
> 
>> On Tue, Nov 21, 2006 at 07:16:44PM CET, Jakub Narebski wrote:
>>..
>>> git repo-config show.difftree --root
>>> git repo-config whatchanged.difftree --root
>>
>> That means extra pointless setup and is besides the point anyway, I was
>> asking about empty commits, not default command settings.
> 
> I agree with you.  Personally, I think:
> 
>  - show is where the user is asking for _that_ particular
>    commit, so it can safely default to --root, always.  No
>    option is needed.

We don't show patch for merges by default in git-show, so I don't
see why we would want to show root commit diff in git-show by default:
those two are very similar.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

