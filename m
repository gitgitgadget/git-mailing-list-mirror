X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Documentation: clarify refname disambiguation rules.
Date: Thu, 26 Oct 2006 10:40:45 +0200
Organization: At home
Message-ID: <ehps96$5b2$1@sea.gmane.org>
References: <E1Gck2K-0003H4-00@dvr.360vision.com> <7v1wowm46j.fsf@assigned-by-dhcp.cox.net> <7vwt6okpgr.fsf@assigned-by-dhcp.cox.net> <200610260814.05957.andyparkins@gmail.com> <7vhcxrqynx.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Thu, 26 Oct 2006 08:40:54 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 17
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-23-110.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30152>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gd0mz-0001pJ-8u for gcvg-git@gmane.org; Thu, 26 Oct
 2006 10:40:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965251AbWJZIkb convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006 04:40:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965246AbWJZIka
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 04:40:30 -0400
Received: from main.gmane.org ([80.91.229.2]:23985 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S965251AbWJZIk3 (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006 04:40:29 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gd0md-0001je-Ib for git@vger.kernel.org; Thu, 26 Oct 2006 10:40:15 +0200
Received: from host-81-190-23-110.torun.mm.pl ([81.190.23.110]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Thu, 26 Oct 2006 10:40:15 +0200
Received: from jnareb by host-81-190-23-110.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Thu, 26 Oct 2006
 10:40:15 +0200
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote:

> -* A suffix '@' followed by a date specification enclosed in a brace
[...]
> +* A ref followed by the suffix '@' with a date specification
> + =A0enclosed in a brace
> =A0 =A0pair (e.g. '\{yesterday\}', '\{1 month 2 weeks 3 days 1 hour 1

This introduces strange line breaking. Is it only in source?

Here diff didn't produce optimal for review patch, separating changed f=
rom
part and changed to part with large block of added code.
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

