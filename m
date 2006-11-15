X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Cleaning up git user-interface warts
Date: Wed, 15 Nov 2006 11:28:27 +0100
Organization: At home
Message-ID: <ejeq20$5hn$1@sea.gmane.org>
References: <87k61yt1x2.wl%cworth@cworth.org> <455A1137.8030301@shadowen.org> <87hcx1u934.wl%cworth@cworth.org> <20061114194707.GH7201@pasky.or.cz> <87d57pu4qa.wl%cworth@cworth.org> <7v3b8lv9c9.fsf@assigned-by-dhcp.cox.net> <20061115040852.GL7201@pasky.or.cz> <7vd57ps51c.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0611142342160.2591@xanadu.home> <ejeotu$vrj$3@sea.gmane.org> <8aa486160611150215n64bb01e6o49aeaf243ad8f817@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Wed, 15 Nov 2006 10:27:33 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 20
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31433>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkHzO-0002BA-7a for gcvg-git@gmane.org; Wed, 15 Nov
 2006 11:27:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966747AbWKOK11 convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006 05:27:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966748AbWKOK11
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 05:27:27 -0500
Received: from main.gmane.org ([80.91.229.2]:37597 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S966747AbWKOK10 (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 05:27:26 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GkHzI-0002AB-8N for git@vger.kernel.org; Wed, 15 Nov 2006 11:27:24 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Wed, 15 Nov 2006 11:27:24 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Wed, 15 Nov 2006
 11:27:24 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Santi B=E9jar wrote:

> On 11/15/06, Jakub Narebski <jnareb@gmail.com> wrote:

>> You mean
>>
>>       git merge git://repo.com/time_machine.git#branch
>>
>> don't you (perhaps with 'master' as default branch)?
>=20
> perhaps with remote 'HEAD' as default branch?

No! HEAD might change without your notice, and you want to know
which branch you merge. With remotes the default could be first
branch in the pull/fetch list, but with bare URL...
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

