X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] document the <tree ish> <file> blob reference syntax
Date: Wed, 25 Oct 2006 22:04:05 +0200
Organization: At home
Message-ID: <ehofuh$sod$1@sea.gmane.org>
References: <38fafea491402334df335c486270ebe9@pinky> <7vwt6ob5zc.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Wed, 25 Oct 2006 20:04:24 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 21
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-23-110.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30098>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gcoyo-0004F7-Pd for gcvg-git@gmane.org; Wed, 25 Oct
 2006 22:04:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965170AbWJYUEA convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Wed, 25 Oct 2006 16:04:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965206AbWJYUD7
 (ORCPT <rfc822;git-outgoing>); Wed, 25 Oct 2006 16:03:59 -0400
Received: from main.gmane.org ([80.91.229.2]:61417 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S965170AbWJYUD7 (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 25 Oct 2006 16:03:59 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GcoyZ-0004CS-51 for git@vger.kernel.org; Wed, 25 Oct 2006 22:03:48 +0200
Received: from host-81-190-23-110.torun.mm.pl ([81.190.23.110]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Wed, 25 Oct 2006 22:03:47 +0200
Received: from jnareb by host-81-190-23-110.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Wed, 25 Oct 2006
 22:03:47 +0200
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote:

> Andy Whitcroft <apw@shadowen.org> writes:
>=20
>> It is possible to specify a specific file within a tree-ish
>> symbolically. =A0For example you can find the contents of
>> a specific file in a specific commit as below:
>>
>> =A0=A0=A0=A0=A0=A0git cat-file -p v1.2.4:git-prune.sh
>=20
> Didn't we document this elsewhere recently in git-rev-parse?
> How about this instead?

Redundancy in documentation is (usually) good idea. Perhaps
both?

P.S. "recently" as in "Thu Oct 19 10:04:55 2006 +0700" in 'master',
commit v1.4.3-g6b09c78
--=20
Jakub Narebski
Poland
