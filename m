From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Question about scm security holes
Date: Thu, 4 Mar 2010 22:28:38 -0500
Message-ID: <32541b131003041928m50aee3d0jcde58f3f4ff63a8b@mail.gmail.com>
References: <hmp427$d6h$1@dough.gmane.org> <32541b131003041803q9abf6baq4cf9ffcca990b51c@mail.gmail.com> 
	<4B907884.5080501@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: walt <w41ter@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 05 04:29:19 2010
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NnOE0-0006em-RB
	for gcvg-git-2@lo.gmane.org; Fri, 05 Mar 2010 04:29:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752953Ab0CED3A convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Mar 2010 22:29:00 -0500
Received: from mail-yx0-f185.google.com ([209.85.210.185]:50649 "EHLO
	mail-yx0-f185.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751146Ab0CED27 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Mar 2010 22:28:59 -0500
Received: by yxe15 with SMTP id 15so1834147yxe.25
        for <git@vger.kernel.org>; Thu, 04 Mar 2010 19:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=NRANphGvdPZFu5E2pd0sabNbwOm9zpr+QNtklG6IMgs=;
        b=dRVipoDPcYNBhvqmXZWmUQ37pXx4Ev/4RZ0sHUbmGET5k5iRaFMNZ3TQfwcyjZiLtS
         xAqbFOc0OHIs91ixrvH2z2ShDy0lBylbNhGHh318dzNDLV9wGIobEyFo5PsFn8VqK8PM
         pB7uZbimDnCfT5iYQF9fUVGS9x32rSAGJ1FZo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=OFo8b1nrVbCoirb4Pu/UZHAWmQ7/8BRN0NWPDicbFxVuZ3D5Ge33XqSVUOCSsDE/Pz
         guyGvhiaKQSfXYQU7U4C5iqyvfDUTyKopWz5odJ7+I7cdx80HabkLjWpww8doWq45JVt
         8Fd24MIXvFS/K3mIq7A/8Pqb+P3CoWAMLtTDI=
Received: by 10.150.46.30 with SMTP id t30mr505722ybt.286.1267759738199; Thu, 
	04 Mar 2010 19:28:58 -0800 (PST)
In-Reply-To: <4B907884.5080501@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141559>

On Thu, Mar 4, 2010 at 10:20 PM, walt <w41ter@gmail.com> wrote:
> On 03/04/2010 06:03 PM, Avery Pennarun wrote:
>> ...you can create a commit with
>> whatever committer/author names you want and then push them in.
>> Commits aren't GPG-signed, only tags are, so there are lots of ways =
to
>> forge a commit from someone else and mess up the audit log...
>
> Thanks, that's the kind of reply I was hoping for. =A0Do you think th=
ere
> should be a way to sign the commits themselves, at least as an option=
?
>
> I certainly wouldn't bother, but OTOH nobody wants to steal my code :=
-/

The whole thing is a bit overblown.  One of my friends once took me on
a tour of Microsoft on a weekend.  The place was mostly deserted, but
tons of developers left their workstations unlocked overnight, and
everyone had a private office.  And with tens of thousands of
developers on the campus, nobody would know if you're supposed to be
there or not.

It would have been easy to walk off with the source code to Windows
from one of those workstations.  The fact is, nobody really *wants*
the source code to Windows, except probably to look at it and be
horrified.

What would you do if you stole the source code to Adobe's flash
player?  It's illegal (in the U.S. anyway) to reverse engineer it and
it's illegal to steal it, so you're on the wrong side of the law no
matter how you pretend you managed to figure out a way around their
DRM or whatever.

People describe source code as a company's "crown jewels," but that's
a bit of a joke.  I can barely get our interns to figure out how to
compile and understand our code.  Expecting a thief to do it, with
nothing but a raw repo and hundreds of gigabytes of crap, is pure
paranoia.

Sneaking in patches?  Yeah, watch out for that.  But you should be
reviewing patch changelogs anyway.  At least git prevents people from
*retroactively* changing stuff; they can only add patches on top, so
it's easy to review after a break-in.

Have fun,

Avery
