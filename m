From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's in git.git
Date: Mon, 18 Sep 2006 08:07:21 +0200
Organization: At home
Message-ID: <eeld1a$830$2@sea.gmane.org>
References: <7vk64bnnxl.fsf@assigned-by-dhcp.cox.net> <7vu035u4c3.fsf@assigned-by-dhcp.cox.net> <eelbd2$56s$1@sea.gmane.org> <7vlkohu3j1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Mon Sep 18 08:06:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GPCHM-0000kH-U3
	for gcvg-git@gmane.org; Mon, 18 Sep 2006 08:06:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965446AbWIRGGs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 18 Sep 2006 02:06:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965447AbWIRGGs
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Sep 2006 02:06:48 -0400
Received: from main.gmane.org ([80.91.229.2]:46728 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S965446AbWIRGGr (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Sep 2006 02:06:47 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GPCHB-0000ig-PF
	for git@vger.kernel.org; Mon, 18 Sep 2006 08:06:41 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 18 Sep 2006 08:06:41 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 18 Sep 2006 08:06:41 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27232>

Junio C Hamano wrote:

> Jakub Narebski <jnareb@gmail.com> writes:
>=20
>> Junio C Hamano wrote:
>>
>>> =A0 - An experimental git-for-each-ref command to help language
>>> =A0 =A0 bindings to get information on many refs at once. =A0Hopefu=
lly
>>> =A0 =A0 Jakub can teach gitweb to use it to speed things up.
>>
>> I use 'origin' (or 'next') version of gitweb, while using _released_
>> version of git (git-core-1.4.2.1-1.i386.rpm). So at least for now=20
>> I wouldn't be able to _test_ the git-for-each-ref.
>=20
> That's not a good excuse, though.  It means you cannot propose
> new core-side support that only gitweb would benefit from
> initially, since we will not add new stuff to the core that does
> not have real users, and new stuff in the core must be cooked in
> "next" before it is proven to be useful and correct.
=20
But this also means that if I were for example to use git-for-each-ref
in gitweb, I couldn't _test_ if it works. Ah, well, if you can live wit=
h
PATCH/RFC... But I'd rather wait for git-for-each-ref in _released_ ver=
sion
of git.=20

On the other side as you said the true test for new core stuff is to us=
e
it. Perhaps someone who runs 'master' or 'next' version of git...
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
