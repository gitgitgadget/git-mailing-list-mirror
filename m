From: "Geoff Russell" <geoffrey.russell@gmail.com>
Subject: Re: tags and patches
Date: Wed, 13 Jun 2007 21:34:34 +0930
Message-ID: <93c3eada0706130504g7f405b8ercd093b585b364eb5@mail.gmail.com>
References: <93c3eada0706130352h3ad6857eie01e1171fdda3991@mail.gmail.com>
	 <20070613110401.GG21684@artemis.intersec.eu>
Reply-To: geoffrey.russell@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 13 14:05:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyRax-0006NJ-RX
	for gcvg-git@gmane.org; Wed, 13 Jun 2007 14:05:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757905AbXFMMEh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 13 Jun 2007 08:04:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757826AbXFMMEg
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 08:04:36 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:32017 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757546AbXFMMEf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Jun 2007 08:04:35 -0400
Received: by ug-out-1314.google.com with SMTP id j3so392160ugf
        for <git@vger.kernel.org>; Wed, 13 Jun 2007 05:04:34 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FFK2D3yDCKuDP9mGzkkjfQ+XUB87hO0D/a9KJzsq832uN4F0pbmoq4kRw/CgGmesF+8nASr6x0Ig1msWmQmFP/OVeTLN9gJeQIXHusxwmNjWsir+aOtqj+ZWWNbyeKvsuzrr+Lv6JikQJe0tEpjcdX8NRBh3mP5h9zNXivqKJOU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DS1XsnLYUYnXy8WaPC+QbfADAW/qPRZP9h99Ze8d4HYm6Mw/pwq06VFdTfhpwVMVptNunE1HgRRnPc5yAdrgpVFWo4zavLtfpReltx5SU892coKIP/Ben/uWZ+v4nRaX1qzpz58PcdwPG+McDad6v1vu/8zCvsBBl7DzdEH/+HI=
Received: by 10.82.170.2 with SMTP id s2mr984670bue.1181736274377;
        Wed, 13 Jun 2007 05:04:34 -0700 (PDT)
Received: by 10.82.141.14 with HTTP; Wed, 13 Jun 2007 05:04:34 -0700 (PDT)
In-Reply-To: <20070613110401.GG21684@artemis.intersec.eu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50049>

On 6/13/07, Pierre Habouzit <madcoder@debian.org> wrote:
> On Wed, Jun 13, 2007 at 08:22:23PM +0930, Geoff Russell wrote:
> > Dear gits,
> >
> > (I'm on 1.5.0.5)
> >
> > The last tag made seems to be missing from a patch ... eg.
> >
> >        cd ~ ; mkdir myrepo ; cd myrepo
> >        git init-db ; echo STUFF > xxx ; git add xxx
> >        # work, work, work on xxx
> >        git commit -a
> >        git tag v1.0
> >        # work work work on xxx
> >        # then I clone this repository
> >        cd /tmp ; git clone ~/myrepo newmyrepo
> >        # go back and work some more
> >        cd ~/myrepo
> >        echo YYY >>xxx
> >        git commit -a
> >        git tag v1.1
> >        # is git commit -a required to commit the tag???
> >        git format-patch v1.0
> >        cd /tmp/newmyrepo
> >        git am ~/myrepo/THEPATCHNAME
> >        git tag ls
>
>   git tag ls is not the proper way to list tags. Afaict there isn't a=
ny
> yet, except: ls .git/refs/tags/
>
>   git tag ls just tagged your HEAD with the name 'ls' which is obviou=
sly
> not what you meant :)

Ooops. Yes, I meant "git tag -l" as the last command, which lists the t=
ags,
but doesn't list v1.1.

Geoff.

>
> --
> =B7O=B7  Pierre Habouzit
> =B7=B7O                                                madcoder@debia=
n.org
> OOO                                                http://www.madism.=
org
>
>
