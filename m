X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Submodules in GIT
Date: Sat, 16 Dec 2006 02:34:29 +0100
Organization: At home
Message-ID: <elviac$63t$1@sea.gmane.org>
References: <20061130170625.GH18810@admingilde.org> <200612150007.44331.Josef.Weidendorfer@gmx.de> <e7bda7770612150943j71a7362bmb509cea3b7756003@mail.gmail.com> <200612152242.50472.Josef.Weidendorfer@gmx.de> <e7bda7770612151543o39c9d233q91ea643a134196d3@mail.gmail.com> <e7bda7770612151713k418434e6gd8d565e49a766477@mail.gmail.com> <e7bda7770612151720w2e65fe83s9942e1ec1f7092a2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Sat, 16 Dec 2006 01:32:40 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 46
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-25-107.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34584>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvOPh-00040T-CY for gcvg-git@gmane.org; Sat, 16 Dec
 2006 02:32:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030532AbWLPBca (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 15 Dec 2006
 20:32:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030534AbWLPBca
 (ORCPT <rfc822;git-outgoing>); Fri, 15 Dec 2006 20:32:30 -0500
Received: from main.gmane.org ([80.91.229.2]:51953 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1030532AbWLPBca
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 15 Dec 2006 20:32:30 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GvOPP-0007od-Is for git@vger.kernel.org; Sat, 16 Dec 2006 02:32:15 +0100
Received: from host-81-190-25-107.torun.mm.pl ([81.190.25.107]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Sat, 16 Dec 2006 02:32:15 +0100
Received: from jnareb by host-81-190-25-107.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Sat, 16 Dec 2006
 02:32:15 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Torgil Svensson wrote:

> On 12/16/06, Torgil Svensson <torgil.svensson@gmail.com> wrote:
>>
>> example tree object:
>>
>> 100644 blob <sha1 of blob>    README
>> 100644 blob <sha1 of blob>    REPORTING-BUGS
>> 100644 link <sha1 of blob>     <sha1 of commit>
>> 040000 tree <sha1 of tree>    arch
>> 040000 tree <sha1 of tree>    block
>> 040000 link <sha1 of tree>     <sha1 of commit>
>>
> 
> Sorry, I was sloppy and forgot the names:
> 
> 100644 blob <sha1 of blob>    README
> 100644 blob <sha1 of blob>    REPORTING-BUGS
> 100644 link <sha1 of blob>     <sha1 of commit>   AUTHORS
> 040000 tree <sha1 of tree>    arch
> 040000 tree <sha1 of tree>    block
> 040000 link <sha1 of tree>     <sha1 of commit>   misc
> 
> Now it doesn't looks like trees/blobs anymore so maybe a link object
> is handy: 
> 
> 100644 blob <sha1 of blob>    README
> 100644 blob <sha1 of blob>    REPORTING-BUGS
> 100644 link <sha1 of link>      AUTHORS
> 040000 tree <sha1 of tree>    arch
> 040000 tree <sha1 of tree>    block
> 040000 link <sha1 of link>     misc
> 
> link-object:
> <sha1 of commit>
> <sha1 of tree/blob>

What do you need <sha1 of tree/blob> for in link-object? Wouldn't you
use usually the sha1 of top tree of a commit, which is uniquely defined
by commit object, so you need only <ahs1 of commit>?

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

