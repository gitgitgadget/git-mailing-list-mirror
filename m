From: Ted Zlatanov <tzz@lifelogs.com>
Subject: Re: can Git encrypt/decrypt .gpg on push/fetch?
Date: Fri, 09 Sep 2011 08:27:52 -0500
Organization: =?utf-8?B?0KLQtdC+0LTQvtGAINCX0LvQsNGC0LDQvdC+0LI=?= @
 Cienfuegos
Message-ID: <87ipp1x2uf.fsf@lifelogs.com>
References: <87lityxbg7.fsf@lifelogs.com>
	<CAGhXAGSw3y=cjAHXtwycDifoBPr13AkYtLHRRXejRKue0vkz7A@mail.gmail.com>
Reply-To: git@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 09 15:28:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R217y-0007v8-Af
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 15:28:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933658Ab1IIN2N convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Sep 2011 09:28:13 -0400
Received: from lo.gmane.org ([80.91.229.12]:39975 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933424Ab1IIN2M (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Sep 2011 09:28:12 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1R217p-0007qz-F7
	for git@vger.kernel.org; Fri, 09 Sep 2011 15:28:09 +0200
Received: from 38.98.147.133 ([38.98.147.133])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 09 Sep 2011 15:28:09 +0200
Received: from tzz by 38.98.147.133 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 09 Sep 2011 15:28:09 +0200
X-Injected-Via-Gmane: http://gmane.org/
Mail-Followup-To: git@vger.kernel.org
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 38.98.147.133
X-Face: bd.DQ~'29fIs`T_%O%C\g%6jW)yi[zuz6;d4V0`@y-~$#3P_Ng{@m+e4o<4P'#(_GJQ%TT= D}[Ep*b!\e,fBZ'j_+#"Ps?s2!4H2-Y"sx"
Mail-Copies-To: never
User-Agent: Gnus/5.110018 (No Gnus v0.18) Emacs/24.0.50 (gnu/linux)
Cancel-Lock: sha1:TXiGHwuJ4y5xdqWCNkvWOZM1LHc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181062>

On Fri, 9 Sep 2011 16:20:10 +0530 Aneesh Bhasin <contact.aneesh@gmail.c=
om> wrote:=20

AB> 2011/9/9 Ted Zlatanov <tzz@lifelogs.com>
>>=20
>> I need to store some encrypted files in Git but for some clients wit=
h
>> the right GPG keys, decrypt them on checkout (possibly also encrypt =
them
>> back on commit, but that's not as important).
>>=20
>> diff doesn't have to work, this is just for convenience. =A0Can Git =
do
>> this (matching only .gpg files) or do I need my own command to run a=
fter
>> the checkout/fetch and before commit? =A0It seems pretty out of Git'=
s
>> scope but perhaps others have done this before.
>>=20

AB> Have you looked at git hooks (e.g. here : http://progit.org/book/ch=
7-3.html).

AB> You could do the encryption/decryption in pre-commit and post-check=
out
AB> hooks scripts respectively...

Yes, thank you.  I was wondering if there could be further support so
they are checked out in a binary form on the server side if you don't
have the keys but in text form if you do.  So for instance "git log -p"
will DTRT on a client with the keys but not on a client without them.
This could require deep Git changes so I'm wondering if it's even
theoretically possible.

Thanks
Ted
