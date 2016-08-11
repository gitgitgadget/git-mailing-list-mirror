X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Getting new branches from remote repo.
Date: Mon, 13 Nov 2006 19:40:51 +0100
Organization: At home
Message-ID: <ejae5a$5qb$1@sea.gmane.org>
References: <6e1787fe0611122033p49671e13xf5b7f95beeba8b06@mail.gmail.com> <7v8xigar36.fsf@assigned-by-dhcp.cox.net> <20061113091736.GA31693@diana.vm.bytemark.co.uk> <7vr6w78b4x.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Mon, 13 Nov 2006 18:44:37 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 14
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31310>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gjgls-0002O1-7k for gcvg-git@gmane.org; Mon, 13 Nov
 2006 19:43:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932722AbWKMSm7 convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Mon, 13 Nov 2006 13:42:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755320AbWKMSm7
 (ORCPT <rfc822;git-outgoing>); Mon, 13 Nov 2006 13:42:59 -0500
Received: from main.gmane.org ([80.91.229.2]:47281 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1755319AbWKMSm6 (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 13 Nov 2006 13:42:58 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gjgki-000257-W1 for git@vger.kernel.org; Mon, 13 Nov 2006 19:41:52 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Mon, 13 Nov 2006 19:41:52 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Mon, 13 Nov 2006
 19:41:52 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote:

> =A0- We need to remember old branches that the user is not
> =A0 =A0interested in, so that we do not even ask to add it only
> =A0 =A0because it does not have a local tracking branch.

Wouldn't it be easier just to add --all flag to git-fetch,
which would fetch _all_ the branches, and --save to write remotes
file... or rather appropriate config entry?
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

