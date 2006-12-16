X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] Submodules in GIT
Date: Sat, 16 Dec 2006 02:25:53 -0800
Message-ID: <7vac1oi1ce.fsf@assigned-by-dhcp.cox.net>
References: <20061130170625.GH18810@admingilde.org>
	<200612150007.44331.Josef.Weidendorfer@gmx.de>
	<e7bda7770612150943j71a7362bmb509cea3b7756003@mail.gmail.com>
	<200612152242.50472.Josef.Weidendorfer@gmx.de>
	<e7bda7770612151543o39c9d233q91ea643a134196d3@mail.gmail.com>
	<e7bda7770612151713k418434e6gd8d565e49a766477@mail.gmail.com>
	<e7bda7770612151720w2e65fe83s9942e1ec1f7092a2@mail.gmail.com>
	<elviac$63t$1@sea.gmane.org>
	<e7bda7770612160040v1a769153p909a8cd40e5ea991@mail.gmail.com>
	<em0fpq$45b$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 16 Dec 2006 10:26:12 +0000 (UTC)
Cc: "Torgil Svensson" <torgil.svensson@gmail.com>,
	"Josef Weidendorfer" <Josef.Weidendorfer@gmx.de>,
	"R. Steve McKown" <rsmckown@yahoo.com>, git@vger.kernel.org,
	"Linus Torvalds" <torvalds@osdl.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <em0fpq$45b$1@sea.gmane.org> (Jakub Narebski's message of "Sat,
	16 Dec 2006 10:57:36 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34604>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvWk3-00062h-J7 for gcvg-git@gmane.org; Sat, 16 Dec
 2006 11:26:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965404AbWLPKZz (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 16 Dec 2006
 05:25:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965411AbWLPKZz
 (ORCPT <rfc822;git-outgoing>); Sat, 16 Dec 2006 05:25:55 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:48515 "EHLO
 fed1rmmtao03.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S965404AbWLPKZy (ORCPT <rfc822;git@vger.kernel.org>); Sat, 16 Dec 2006
 05:25:54 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao03.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061216102554.DGMO29122.fed1rmmtao03.cox.net@fed1rmimpo01.cox.net>; Sat, 16
 Dec 2006 05:25:54 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id zNRD1V0071kojtg0000000; Sat, 16 Dec 2006
 05:25:14 -0500
To: jnareb@gmail.com
Sender: git-owner@vger.kernel.org

[jc: adding back people on CC list while feeling sick of having
to do so...]

Jakub Narebski <jnareb@gmail.com> writes:

>>>> Now it doesn't looks like trees/blobs anymore so maybe a link object
>>>> is handy:
>>>>  README
>>>> 100644 blob <sha1 of blob>    REPORTING-BUGS
>>>> 100644 link <sha1 of link>      AUTHORS
>>>> 040000 tree <sha1 of tree>    arch
>>>> 040000 tree <sha1 of tree>    block
>>>> 040000 link <sha1 of link>     misc
>
> This would be (using the submodule original proposal)
>
>     140000 link <sha1 of link>     misc

If I recall correctly, the original original proposal used
160000 because that is not a bitpattern used in stat.h, and a
link behaves like a directory and a symbolic link at the same
time.
