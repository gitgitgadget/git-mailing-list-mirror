X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Whitcroft <apw@shadowen.org>
Subject: Re: How to view an old revision?
Date: Wed, 01 Nov 2006 14:46:02 +0000
Message-ID: <4548B32A.5030803@shadowen.org>
References: <3bbc18d20611010620m11e40402v44334a8c486a4932@mail.gmail.com>	 <4548AFA2.1040606@shadowen.org> <3bbc18d20611010637s6d05aecbt98322b62cf7235e8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 1 Nov 2006 14:46:55 +0000 (UTC)
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.5 (X11/20060812)
In-Reply-To: <3bbc18d20611010637s6d05aecbt98322b62cf7235e8@mail.gmail.com>
X-Enigmail-Version: 0.94.0.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30641>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfHMa-0003K0-Um for gcvg-git@gmane.org; Wed, 01 Nov
 2006 15:46:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S2992461AbWKAOql (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 1 Nov 2006
 09:46:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992527AbWKAOql
 (ORCPT <rfc822;git-outgoing>); Wed, 1 Nov 2006 09:46:41 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:9479 "EHLO
 hellhawk.shadowen.org") by vger.kernel.org with ESMTP id S2992461AbWKAOql
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 1 Nov 2006 09:46:41 -0500
Received: from localhost ([127.0.0.1]) by hellhawk.shadowen.org with esmtp
 (Exim 4.50) id 1GfHLt-0001cu-I2; Wed, 01 Nov 2006 14:46:01 +0000
To: Matt McCutchen <hashproduct+git@gmail.com>
Sender: git-owner@vger.kernel.org

Matt McCutchen wrote:
> On 11/1/06, Andy Whitcroft <apw@shadowen.org> wrote:
>>         git cat-file -p <commit-ish>:<file>
> 
> Nice!  Thanks!  I had guessed "git cat-file -p <commit-ish>/<file>"
> but didn't try a colon as the separator.  The colon syntax ought to be
> mentioned in the git-cat-file man page.

There are some improvements in the documentation in 'next' but nothing
which would make this easier for you to find.

Junio, I wonder if we should be changing the usage for this command
slightly.  Currently, it mearly says <object> as the identifier for the
blob.  Really this is <object-ish> as it supports symbolic naming in
addition to raw sha1's.  I also feel it would be very helpful if
<commit-ish> and family were documented as a glossary section in main
git manpage.

Something like this:

<commit-ish>:: is an sha1 for a commit, or any symbolic name for a
commit (see SPECIFYING REVISIONS in git-rev-parse)

What do people think.  I can do the munging about if its seems like a
sane plan.

