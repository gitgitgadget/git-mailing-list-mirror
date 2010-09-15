From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 2/2] Add Swedish translation.
Date: Wed, 15 Sep 2010 22:38:49 +0000
Message-ID: <AANLkTi=PcKXNN-3LzbkJa5qDgjfnA=Jhd4ECXL0hYvCX@mail.gmail.com>
References: <20100912202111.B11522FC00@perkele>
	<AANLkTikg1vD33f6Rj4UEzsbrUemta6NbRWWH22h2Y0-B@mail.gmail.com>
	<alpine.DEB.2.00.1009130810580.31516@ds9.cixit.se>
	<AANLkTinhmBHQzkdEY88Oa-XsZQ4VAUz0Tci+gOt=fXmE@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Bruno Haible <bruno@clisp.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Thu Sep 16 00:38:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ow0cx-0006jt-Lf
	for gcvg-git-2@lo.gmane.org; Thu, 16 Sep 2010 00:38:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754445Ab0IOWiu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Sep 2010 18:38:50 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:46937 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753940Ab0IOWit convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Sep 2010 18:38:49 -0400
Received: by iwn5 with SMTP id 5so462856iwn.19
        for <git@vger.kernel.org>; Wed, 15 Sep 2010 15:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=qWXY7uZ1CiLfOpd8myq2nN2PNVEZh/LZjsTAw4GH7is=;
        b=dr2bNpTHmZ+g2+Di1j7uKD/zwzJ73McpxfCNVWpZCC5d3vU7mVhejibdBDBF39h2Q3
         xXWfn6iSS6EuQxGWGq48QmMhg0Xa2zuZbt22qJ6MMNjFWJf0V5RDwEPJeWj3wBgKq9CA
         8C5hV6gir4/0UQagAiUzeXyYGpOOuVxWy6Ohw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=I/SKBXQuKO57w9UvwrJFQls18fAY76yO4sVy0gEj11XOS8F3/FKGTjhl9IOn7acje0
         Wkhrs/yKgoSCVJvZWeS3rCDaEW3LJLARL2KWSgA7FKAiPZz0amolStAObVfzHx6zQoiO
         wMIlQnELaXVDMf8qnfw8OkQQFGJwr7MzJEvZQ=
Received: by 10.231.174.144 with SMTP id t16mr2401579ibz.118.1284590329455;
 Wed, 15 Sep 2010 15:38:49 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Wed, 15 Sep 2010 15:38:49 -0700 (PDT)
In-Reply-To: <AANLkTinhmBHQzkdEY88Oa-XsZQ4VAUz0Tci+gOt=fXmE@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156264>

On Mon, Sep 13, 2010 at 13:35, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <=
avarab@gmail.com> wrote:
>>> =C2=A0 =C2=A0 =C2=A0 -#: wt-status.c:56
>>
>> These context lines are invaluable when figuring out how to translat=
e stuff,
>> and to track back strings after the fact. I do not like the idea of =
removing
>> them.
>
> Yes they're useful while translating. But as documented in po/README'=
s
> "Updating a .po file" you can use them while doing that without
> submitting them to git.git.
>
> If they're included the majority of any po/*.po update will be update=
s
> to auto-generated line number comments.

After doing some msgmerge on is.po I think omitting these line numbers
might be the wrong move.

msgmerge can get very confused, and mark translations fuzzy across
unrelated files, presumably that wouldn't happen if they were there. I
haven't tested it though.

CC-ing the gettext maintainer, maybe he has some insights. The gettext
manual doesn't discuss this as far as I can see.
