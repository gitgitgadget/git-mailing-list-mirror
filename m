From: =?iso-8859-1?Q?David_K=E5gedal?= <davidk@lysator.liu.se>
Subject: Re: [PATCH] Teach applymbox to keep the Subject: line.
Date: Thu, 18 Aug 2005 12:32:57 +0200
Message-ID: <u5tbr3vy1pi.fsf@lysator.liu.se>
References: <20050816214707.6842.qmail@web26302.mail.ukl.yahoo.com>
	<7vek8t7bva.fsf@assigned-by-dhcp.cox.net>
	<7vk6il2jz8.fsf_-_@assigned-by-dhcp.cox.net>
	<430375B3.3050307@pobox.com>
	<Pine.LNX.4.58.0508171253190.3553@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Thu Aug 18 12:36:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5hjV-0000eM-Mc
	for gcvg-git@gmane.org; Thu, 18 Aug 2005 12:34:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750846AbVHRKel convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 18 Aug 2005 06:34:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932135AbVHRKel
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Aug 2005 06:34:41 -0400
Received: from main.gmane.org ([80.91.229.2]:56773 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750846AbVHRKek (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Aug 2005 06:34:40 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1E5hhx-0000AJ-VT
	for git@vger.kernel.org; Thu, 18 Aug 2005 12:33:13 +0200
Received: from 212214120186-virtutech-ab.host.songnetworks.se ([212.214.120.186])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 18 Aug 2005 12:33:13 +0200
Received: from davidk by 212214120186-virtutech-ab.host.songnetworks.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 18 Aug 2005 12:33:13 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 212214120186-virtutech-ab.host.songnetworks.se
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Cancel-Lock: sha1:E2WfARmkpmg88Sz3MrKmvVbc7+E=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> On Wed, 17 Aug 2005, Jeff Garzik wrote:
>>=20
>> 1) Fix applymbox such that it understands RFC822-valid Subject lines=
=20
>> which wrap across multiple text lines.
>
> It already should do this.
>
>> 2) Teach it to understand MIME, and not treat the MIME headers like =
part=20
>> of the message.
>
> But this one I really realyl disagree with.
>
> The fact is, anybody who doesn't edit the emails that come in is BROK=
EN.=20
> There are two kinds of emails:
>
>  - the nicely formatted ones where the author follows all the rules
>
>    This kind of email doesn't need MIME decoding anyway.

Unless they want to write something that doesn't fit in ASCII, as
discussed in another thread here.

But maybe you are only talking about MIME attachments, and not about
MIME content encodings?  We probably need to separate the two.

Note that I'm not really talking about your patch handling for Linux;
you are free to disallow my name in Linux patches if you want to.  But
I'd like to see a way to get rid of that limitation for other uses of
git.

--=20
David K=E5gedal
