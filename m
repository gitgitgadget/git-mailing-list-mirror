From: =?iso-8859-1?Q?David_K=E5gedal?= <davidk@lysator.liu.se>
Subject: Re: [PATCH] Fixed two bugs in git-cvsimport-script.
Date: Wed, 17 Aug 2005 12:07:32 +0200
Message-ID: <u5t64u427x7.fsf@lysator.liu.se>
References: <u5tacjjdpxq.fsf@lysator.liu.se> <u5tiry50ywy.fsf@lysator.liu.se>
	<7v3bp829zj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Wed Aug 17 12:11:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5KsF-0008W8-1M
	for gcvg-git@gmane.org; Wed, 17 Aug 2005 12:10:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751044AbVHQKKD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 17 Aug 2005 06:10:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751048AbVHQKKD
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Aug 2005 06:10:03 -0400
Received: from main.gmane.org ([80.91.229.2]:40885 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751044AbVHQKKB (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Aug 2005 06:10:01 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1E5KqQ-00083H-7f
	for git@vger.kernel.org; Wed, 17 Aug 2005 12:08:26 +0200
Received: from 212214120186-virtutech-ab.host.songnetworks.se ([212.214.120.186])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 17 Aug 2005 12:08:26 +0200
Received: from davidk by 212214120186-virtutech-ab.host.songnetworks.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 17 Aug 2005 12:08:26 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 212214120186-virtutech-ab.host.songnetworks.se
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Cancel-Lock: sha1:EB+5K/O3vsQRuxqAvkuGGAugJvU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <junkio@cox.net> writes:

>> Apparently, my mail was encoded as QP, which is not very popular
>> around here.  But it seems that the diff part was decoded properly
>> before applying.  Was that done manually?
>
> Yes, the patch had some context conflicts with some other patch
> so the patch application was done by hand, and I did a quick and
> dirty cut & paste of the commit message from "cat mbox" output.
>
> I will probably drop future patches encoded in QP.

Ok, but do you have an answer to my real question?  What is the
character encoding for commit objects in your git repository?

It is obviously one that is compatible with ASCII, which probably
leaves you with the alternatives ASCII, Latin1, and UTF-8.  And plain
ASCII obviously doesn't work very well for me.

--=20
David K=E5gedal
