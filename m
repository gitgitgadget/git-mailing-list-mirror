X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/n] gitweb: Use '&iquot;' instead of '?' in esc_path
Date: Sat, 04 Nov 2006 00:35:11 +0100
Organization: At home
Message-ID: <eigjmh$ql$1@sea.gmane.org>
References: <200610301953.01875.jnareb@gmail.com> <200611031719.13073.jnareb@gmail.com> <7virhw5hoi.fsf@assigned-by-dhcp.cox.net> <200611032333.49794.jnareb@gmail.com> <7vwt6c40bj.fsf@assigned-by-dhcp.cox.net> <20061103225041.GQ20017@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Fri, 3 Nov 2006 23:35:14 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 26
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-18-116.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30898>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gg8Z2-0004JH-S8 for gcvg-git@gmane.org; Sat, 04 Nov
 2006 00:35:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932486AbWKCXfF (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 3 Nov 2006
 18:35:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932501AbWKCXfE
 (ORCPT <rfc822;git-outgoing>); Fri, 3 Nov 2006 18:35:04 -0500
Received: from main.gmane.org ([80.91.229.2]:7087 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S932486AbWKCXfD (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 3 Nov 2006 18:35:03 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gg8Yo-0004Go-Ii for git@vger.kernel.org; Sat, 04 Nov 2006 00:34:54 +0100
Received: from host-81-190-18-116.torun.mm.pl ([81.190.18.116]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Sat, 04 Nov 2006 00:34:54 +0100
Received: from jnareb by host-81-190-18-116.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Sat, 04 Nov 2006
 00:34:54 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Petr Baudis wrote:

> Dear diary, on Fri, Nov 03, 2006 at 11:44:48PM CET, I got a letter
> where Junio C Hamano <junkio@cox.net> said that...
>> Jakub Narebski <jnareb@gmail.com> writes:
>> > Which solution do you think it's best?
>> 
>> Sorry, if it was not clear in my message, I wanted to say that I
>> kinda liked those "control pictures" in U+2400 range.
> 
> In principle, right now it should be pretty easy for a project that for
> some reason does not use UTF-8 in commits etc. to adjust gitweb to work
> properly, right? Just change the encoding in HTTP headers and you're
> done, I think.
> 
> Is it worth trying to preserve that flexibility?

It should be also quite easy to change to_uft8 subroutine to actually
convert to utf8. But even if we don't use UTF-8 encoding for HTML in
gitweb, numerical character entities (and that's how those "control
pictures" are entered) should work equally well regardless of encoding.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

