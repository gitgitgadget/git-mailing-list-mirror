X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Dan Nicholson" <dbn.lists@gmail.com>
Subject: Re: Can git be tweaked to work cross-platform, on FAT32?
Date: Tue, 19 Dec 2006 15:55:03 -0800
Message-ID: <91705d080612191555k3dc6a473n4b1e4df2d22880bf@mail.gmail.com>
References: <0MKwpI-1GuWVF2znk-0006fC@mrelayeu.kundenserver.de>
	 <46a038f90612132155rc987a9cs6a4fa33dd4c882c6@mail.gmail.com>
	 <0ML25U-1GvWC81sjR-0001UB@mrelayeu.kundenserver.de>
	 <Pine.LNX.4.63.0612161227510.3635@wbgn013.biozentrum.uni-wuerzburg.de>
	 <46a038f90612170221u4c3b5c2asef378d3d4e159ba7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 19 Dec 2006 23:55:15 +0000 (UTC)
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Florian v. Savigny" <lorian@fsavigny.de>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LMBeTcEfn9OttKry8SuV36cM9ul4Sw03041XKA7BCUs9Ki5SJVuHNGOgf/nGAaWnAJcGuylCZQ7nXwGxmIZnVPiHKVT/L0cwP5rmcZ0o5NMo+XIOK1IhatK21xqxhIEAICgPCY4jDgJ2BiRpP0G60MnOb8Dn7my2tWqN29I9P1Y=
In-Reply-To: <46a038f90612170221u4c3b5c2asef378d3d4e159ba7@mail.gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34865>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gwonf-00054Y-2Q for gcvg-git@gmane.org; Wed, 20 Dec
 2006 00:55:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752420AbWLSXzG (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 19 Dec 2006
 18:55:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752874AbWLSXzF
 (ORCPT <rfc822;git-outgoing>); Tue, 19 Dec 2006 18:55:05 -0500
Received: from an-out-0708.google.com ([209.85.132.251]:8192 "EHLO
 an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1752420AbWLSXzD (ORCPT <rfc822;git@vger.kernel.org>); Tue, 19 Dec
 2006 18:55:03 -0500
Received: by an-out-0708.google.com with SMTP id b33so621215ana for
 <git@vger.kernel.org>; Tue, 19 Dec 2006 15:55:03 -0800 (PST)
Received: by 10.100.125.5 with SMTP id x5mr5017877anc.1166572503106; Tue, 19
 Dec 2006 15:55:03 -0800 (PST)
Received: by 10.100.96.18 with HTTP; Tue, 19 Dec 2006 15:55:03 -0800 (PST)
To: "Martin Langhoff" <martin.langhoff@gmail.com>
Sender: git-owner@vger.kernel.org

On 12/17/06, Martin Langhoff <martin.langhoff@gmail.com> wrote:
>
> Note that under windows you can use ext2 -- haven't used it, and don't
> know how cygwin behaves with it, but it may be *just* what you need to
> avoid case sensitivity problems and have symlink support.
>
>     http://sourceforge.net/projects/ext2fsd
>
>     http://www.fs-driver.org/

I've used both of these guys, but not the most recent versions. Both
were previously read-only, but now it appears both have write support
from looking at the release notes. Both were a bit heavy handed to get
setup, but a decently computer literate person could probably handle
it. Ext2IFS in particular looks dramatically improved from when I last
used it.

Both worked fine through Cygwin for simple usage. I never did anything
with serious disk usage on either of them, so I can't say how it
stacks up to FAT32 on Linux in terms of really hammering the disk.

A little more reading says ext2ifs can't handle permissions or symbolic links.

http://www.fs-driver.org/faq.html

I don't recall the details of ext2fsd, but I think symbolic links
worked. I'd like to look at this again, but I spend all my time in
Linux at home.

--
