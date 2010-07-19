From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: Re: Merge commit subjects git.git
Date: Mon, 19 Jul 2010 16:10:57 +0200
Message-ID: <20100719141057.GA13051@vidovic>
References: <AANLkTikavL0DH8FgFxBw7hbGLtj2tqxnP-BT77zo5FJT@mail.gmail.com>
 <201007181733.59704.trast@student.ethz.ch>
 <AANLkTinTOMxWVM9kwhIfcG44SqOjpexY-Xy6kZYkemU9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@student.ethz.ch>,
	Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	git <git@vger.kernel.org>,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 19 16:11:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oar3o-00070W-LT
	for gcvg-git-2@lo.gmane.org; Mon, 19 Jul 2010 16:11:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934163Ab0GSOLI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Jul 2010 10:11:08 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:45510 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933763Ab0GSOLD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jul 2010 10:11:03 -0400
Received: by wyb42 with SMTP id 42so4420526wyb.19
        for <git@vger.kernel.org>; Mon, 19 Jul 2010 07:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=mquSgpxPVJ2o/rKSEro4IPXmGPlcbSM7S9k3gcxIeL4=;
        b=xW59b2P8wHbcjbGCsKUUzXPc1bjyQhuRi9not8MVghXRaSQ4Us5J8FGBjeAPKbadn/
         3yIfav38sAglWzY/JDZLSMLXS09kJBhE10JLOCEM7azl9alCA6pk6y3W3EmZEzRUvHGy
         Tl+74e2fXGSnOfnJ12/ry34ITwWG3/j3scDVk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=kPvHpYP3cCdydlySXP5ZTJJSt7skRFfLPR5v0l6YAW3J7G+zFZ9Wvrrh+Ua07B3Anp
         JI1HpUuAnzqalv9J9gYj6u0fxXxD/N2OCi0Vl4D9BBvhFtyYJtT9eImM+SPfBryH/SvH
         J3sDTKzGug/vruklQN9JGfySR3Q2xsmik4ovE=
Received: by 10.227.134.202 with SMTP id k10mr4137661wbt.17.1279548660931;
        Mon, 19 Jul 2010 07:11:00 -0700 (PDT)
Received: from vidovic (aqu33-8-83-155-187-36.fbx.proxad.net [83.155.187.36])
        by mx.google.com with ESMTPS id l6sm2294407wed.25.2010.07.19.07.10.59
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 19 Jul 2010 07:11:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTinTOMxWVM9kwhIfcG44SqOjpexY-Xy6kZYkemU9@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151249>

The 18/07/10, Sverre Rabbelier wrote:
> On Sun, Jul 18, 2010 at 10:33, Thomas Rast <trast@student.ethz.ch> wr=
ote:
> > =A0 =A0 =A0 =A0if (!strcmp("master", current_branch))
>=20
> Wow, I thought the only place where we gave "master" any special
> meaning was in that we create it as the default branch. Can't we fix
> this to be less hard-coded?

To talk about pros and cons I wonder what would be the benefits of
changing this. I guess most projects probably best keeping the history
consistent for all the merge commit messages.

I think this is more sensible than giving the same behaviour /across/
different repositories (for only which not following the "master"
convention).

--=20
Nicolas Sebrecht
