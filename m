From: Sylvain Rabot <sylvain@abstraction.fr>
Subject: Re: Make Gitweb behave like Apache mod_userdir
Date: Tue, 17 Nov 2009 16:51:26 +0100
Message-ID: <7fce93be0911170751r6d51ae7bn20fd593741b3eba6@mail.gmail.com>
References: <7fce93be0911150204h259b7424md251c54186d05b7d@mail.gmail.com>
	 <7vskcffqkn.fsf@alter.siamese.dyndns.org>
	 <200911171458.56047.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Petr Baudis <pasky@suse.cz>,
	Luben Tuikov <ltuikov@yahoo.com>, "J.H." <warthog9@kernel.org>,
	git <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 17 16:57:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAQRB-0003TE-Nc
	for gcvg-git-2@lo.gmane.org; Tue, 17 Nov 2009 16:57:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754644AbZKQP5k convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Nov 2009 10:57:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754065AbZKQP5j
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Nov 2009 10:57:39 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:62512 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753697AbZKQP5i convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Nov 2009 10:57:38 -0500
Received: by yxe17 with SMTP id 17so122276yxe.33
        for <git@vger.kernel.org>; Tue, 17 Nov 2009 07:57:44 -0800 (PST)
Received: by 10.101.2.10 with SMTP id e10mr1582553ani.91.1258473086978; Tue, 
	17 Nov 2009 07:51:26 -0800 (PST)
X-Originating-IP: [80.13.22.90]
In-Reply-To: <200911171458.56047.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133091>

On Tue, Nov 17, 2009 at 14:58, Jakub Narebski <jnareb@gmail.com> wrote:
> On Sun, 15 Nov 2009, Junio C Hamano wrote:
>> Sylvain Rabot <sylvain@abstraction.fr> writes:
>>
>> > I made gitweb behave a bit like UserDir module will in apache.
>> > In fact it's only configuration but I think it could be useful to =
others.
>>
>> Thanks. =A0Any comment from gitweb gangs?
>
> I would respond earlier if it was submitted with patch inline in mail
> body, and not attached. =A0If it needs to be attached (because of MUA=
/MTA
> linewrapping or encoding issues), it should use 8bit and not base64
> content transfer encoding, have 'text/plain' and not
> 'application/octet-stream' content type, and "inline" and not "attach=
ement"
> in content disposition.

Sorry about that but I'm new in the git world and it is the first time
I submit a patch.

> It also lacks proper commit message (although email describes it quit=
e
> well) and signoff, as per Documentation/SubmittingPatches.
>
> I like this patch. =A0More examples in gitweb/README are always good =
idea.
>
>> > Basicly it allows users of your server who use git to be able to u=
se
>
> "Basically"

Oops

>
>> > gitweb to browse their own root project. E.G. :
>
> "For example"
>
>> >
>> > Alice's private repos :
>> >
>> > /home/alice/git/product_a.git (cloned from /var/git/product_a.git)
>> > /home/alice/git/product_b.git (cloned from /var/git/product_b.git)
>> > /home/alice/git/product_c.git (cloned from /var/git/product_c.git)
>> >
>> > Alice's links to her repos which she wants to be able to browse wi=
th gitweb :
>
> "Alice links", or "Alice creates symbolic links"
>
>> >
>> > /home/alice/gitweb/product_a -> /home/alice/git/product_a.git/.git
>> > /home/alice/gitweb/product_c -> /home/alice/git/product_c.git/.git
>> >
>> > Bare repos :
>> >
>> > /var/git/product_a.git
>> > /var/git/product_b.git
>> > /var/git/product_c.git
>> > /var/git/product_d.git
>
> The description is a bit lacking. =A0Where user should put theirs git
> repositories, or symbolic links to git repositories?

As I said It's only configuration so It depends of your server
architecture. If admin of the server decides he allows users to browse
via gitweb their private/public repos which are linked in
/home/*/.gitweb or anything else he has to modify the environmental
variable in the rewrite rule according to his wish.

> How it would look like in gitweb?

What do you mean ?

> --
> Jakub Narebski
> Poland
