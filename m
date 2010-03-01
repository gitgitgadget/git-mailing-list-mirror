From: Tim Visher <tim.visher@gmail.com>
Subject: Re: Thoughts on git-completion
Date: Mon, 1 Mar 2010 15:34:47 -0500
Message-ID: <c115fd3c1003011234m75df37ehed54a59552f681a5@mail.gmail.com>
References: <c115fd3c1003011151n398780fev24d0bd44bb634d83@mail.gmail.com> 
	<20100301195751.GG24776@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Mar 01 21:35:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NmCKv-0001IL-0U
	for gcvg-git-2@lo.gmane.org; Mon, 01 Mar 2010 21:35:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751587Ab0CAUfK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Mar 2010 15:35:10 -0500
Received: from mail-yx0-f182.google.com ([209.85.210.182]:55680 "EHLO
	mail-yx0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751530Ab0CAUfI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Mar 2010 15:35:08 -0500
Received: by yxe12 with SMTP id 12so1365494yxe.33
        for <git@vger.kernel.org>; Mon, 01 Mar 2010 12:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=nhLAUZe68o8hsVMJjaX69YDwj+9p3bxxFAIpzMznr6A=;
        b=OLti9G+MUNodwLprNw0qifXOfJ4K3JLW4YAPTWfZi/p7GZ6W6gcqYfojR6zVNl2u3y
         BtMzpLs8Eshdzxl3BT/7j7041YQVuLrLgfHw7Ik+301vySUw8fXDlaH+MJWE7k/OCogk
         KqY259dstjhcjVo4jMFDMIhXFLzsGJxcItk50=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=wpHgk/2mKFAZ+FJSYcShMnJFFFhMX1jF439ekEbeqRJZE3npOqy4LN2mBjd7jrGdJq
         z8p43YhH8BxMJy7CpzQz6ukfXE9SNqs6OCE3pEqWVnEHiGb9DugErEgvxzSv9dgzdzLX
         kfxZ6Fu9NmA/uL/dTcYnZ7LJ6TfoGI6dZKXDg=
Received: by 10.101.135.10 with SMTP id m10mr3412493ann.26.1267475707168; Mon, 
	01 Mar 2010 12:35:07 -0800 (PST)
In-Reply-To: <20100301195751.GG24776@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141347>

On Mon, Mar 1, 2010 at 2:57 PM, Shawn O. Pearce <spearce@spearce.org> w=
rote:
> Tim Visher <tim.visher@gmail.com> wrote:
>> I `alias g=3Dgit` and `alias gk=3Dgitk` on every machine that I use =
git on
>> and I have to edit the git-completion.bash script in order to get th=
e
>> marvelous completion provided by that script with my aliases. =C2=A0=
Is this
>> something that could be rolled in to the official release or does th=
is
>> rest firmly in the personal customization realm? =C2=A0I'm prepared =
to
>> submit a patch if you'd like.
>
> Does adding to your local script
>
> =C2=A0complete -o bashdefault -o default -o nospace -F _git g 2>/dev/=
null \
> =C2=A0|| complete -o default -o nospace -F _git g
>
> work for you? =C2=A0It seems to me you just need to tell bash to run
> _git or _gitk when doing completion for your alias.

The patch that I use is:

    2290a2291,2295
    > complete -o bashdefault -o default -o nospace -F _git g 2>/dev/nu=
ll \
    >        || complete -o default -o nospace -F _git g
    > complete -o bashdefault -o default -o nospace -F _gitk gk 2>/dev/=
null \
    >        || complete -o default -o nospace -F _gitk gk

--=20

In Christ,

Timmy V.

http://burningones.com/
http://five.sentenc.es/ - Spend less time on e-mail
