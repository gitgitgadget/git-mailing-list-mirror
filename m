X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Anand Kumria" <wildfire@progsoc.org>
Subject: Re: how to authenticate with git-svn on a subversion repository
Date: Sun, 19 Nov 2006 00:43:55 +0000 (UTC)
Message-ID: <ejo9cb$2l8$1@sea.gmane.org>
References: <4559D37E.1070703@archlinuxfr.org> <m24pszbede.fsf@ziti.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Sun, 19 Nov 2006 00:44:24 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 19
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 88-110-175-230.dynamic.dsl.as9105.com
User-Agent: pan 0.117 (We'll fly and we'll fall and we'll burn)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31817>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GlanF-0006iT-Sy for gcvg-git@gmane.org; Sun, 19 Nov
 2006 01:44:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755387AbWKSAoH convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Sat, 18 Nov 2006 19:44:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755458AbWKSAoH
 (ORCPT <rfc822;git-outgoing>); Sat, 18 Nov 2006 19:44:07 -0500
Received: from main.gmane.org ([80.91.229.2]:9178 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1755387AbWKSAoE (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 18 Nov 2006 19:44:04 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Glamv-0006fP-I3 for git@vger.kernel.org; Sun, 19 Nov 2006 01:44:01 +0100
Received: from 88-110-175-230.dynamic.dsl.as9105.com ([88.110.175.230]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Sun, 19 Nov 2006 01:44:01 +0100
Received: from wildfire by 88-110-175-230.dynamic.dsl.as9105.com with local
 (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Sun, 19
 Nov 2006 01:44:01 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Thu, 16 Nov 2006 07:27:57 -0800, Seth Falcon wrote:

> Com=C3=A8te <comete@archlinuxfr.org> writes:
>=20
>> hello !
>>
>> i would like to use git-svn to commit some modifications to a
>> Subversion repository but i don't know where i can enter my username
>> and password to commit to the repository ? Is there any special file
>> to put them.
>> For now i get an error:
>=20
> There may be a better way, but if you just use the svn command line
> client to create a small working copy from the repository, you will

Or, even simpler, use: svn info <url> which will cache the credentials =
and
not require a working copy.

Anand
