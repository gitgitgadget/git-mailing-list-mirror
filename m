From: Sylvain Rabot <sylvain@abstraction.fr>
Subject: Re: Make Gitweb behave like Apache mod_userdir
Date: Tue, 17 Nov 2009 20:56:11 +0100
Message-ID: <7fce93be0911171156h3af4c7e6i93407db5bcab7059@mail.gmail.com>
References: <7fce93be0911150204h259b7424md251c54186d05b7d@mail.gmail.com>
	 <200911171458.56047.jnareb@gmail.com>
	 <7fce93be0911170751r6d51ae7bn20fd593741b3eba6@mail.gmail.com>
	 <200911171912.40658.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Petr Baudis <pasky@suse.cz>,
	Luben Tuikov <ltuikov@yahoo.com>, "J.H." <warthog9@kernel.org>,
	git <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 17 20:56:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAUA6-0004MI-Et
	for gcvg-git-2@lo.gmane.org; Tue, 17 Nov 2009 20:56:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756153AbZKQT4H convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Nov 2009 14:56:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755583AbZKQT4H
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Nov 2009 14:56:07 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:63216 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755571AbZKQT4G convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Nov 2009 14:56:06 -0500
Received: by yxe17 with SMTP id 17so369792yxe.33
        for <git@vger.kernel.org>; Tue, 17 Nov 2009 11:56:11 -0800 (PST)
Received: by 10.101.106.24 with SMTP id i24mr2148435anm.102.1258487771111; 
	Tue, 17 Nov 2009 11:56:11 -0800 (PST)
X-Originating-IP: [80.13.22.90]
In-Reply-To: <200911171912.40658.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133099>

On Tue, Nov 17, 2009 at 19:12, Jakub Narebski <jnareb@gmail.com> wrote:
> On Tue, 17 Nov 2009, Sylvain Rabot wrote:
>> On Tue, Nov 17, 2009 at 14:58, Jakub Narebski <jnareb@gmail.com> wro=
te:
>
>> > The description is a bit lacking. =A0Where user should put theirs =
git
>> > repositories, or symbolic links to git repositories?
>>
>> As I said It's only configuration so It depends of your server
>> architecture. If admin of the server decides he allows users to brow=
se
>> via gitweb their private/public repos which are linked in
>> /home/*/.gitweb or anything else he has to modify the environmental
>> variable in the rewrite rule according to his wish.
>
> So in described configuration, to make repository visible user would =
have
> to put repository, or symbolic link to repository (or .git/ directory=
 of
> the repository) in ~/gitweb/ directory (just like one would need to p=
ut
> HTML files in ~/public_html/ or ~/WWW/ to have them visible as web si=
te),
> isn't it?
>

That's right.

>> > How it would look like in gitweb?
>>
>> What do you mean ?
>
> How would example gitweb URL to repository look like?

http://repo.or.cz/ -> list the main GITWEB_PROJECTROOT (e.g.: /pub/scm)
http://repo.or.cz/~user -> list /home/user/gitweb
http://repo.or.cz/~user2 -> list /home/user2/gitweb
=2E..

>
> --
> Jakub Narebski
> Poland
>
