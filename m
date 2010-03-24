From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: What's in a name? Let's use a (uuid,name,email) triplet
Date: Wed, 24 Mar 2010 20:18:35 +0100
Message-ID: <40aa078e1003241218s753c1986r3dde7281c513de07@mail.gmail.com>
References: <4ba2293f.c5c2f10a.5e9c.5c4a@mx.google.com>
	 <4BA338C1.7030803@alum.mit.edu>
	 <b4087cc51003190439x3c9ff269g35d11432bd2a3d60@mail.gmail.com>
	 <alpine.DEB.2.00.1003190441530.3821@asgard.lang.hm>
	 <20100319115445.GA12986@glandium.org>
	 <b4087cc51003190509y6ce7ad9dy992254cfe6ac2fb3@mail.gmail.com>
	 <20100322120649.GA28003@sirena.org.uk>
	 <4ba780dc.5744f10a.5517.4c2d@mx.google.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mark Brown <broonie@sirena.org.uk>, Mike Hommey <mh@glandium.org>,
	david@lang.hm, git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 24 20:18:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NuW6G-0006BH-0M
	for gcvg-git-2@lo.gmane.org; Wed, 24 Mar 2010 20:18:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756762Ab0CXTSi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Mar 2010 15:18:38 -0400
Received: from mail-ew0-f216.google.com ([209.85.219.216]:60249 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754788Ab0CXTSh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Mar 2010 15:18:37 -0400
Received: by ewy8 with SMTP id 8so17691ewy.28
        for <git@vger.kernel.org>; Wed, 24 Mar 2010 12:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=XRqFMjyFzVlG0NNHwf6AJJsXEaJuMXj1jcX7xoRBRT4=;
        b=PP0CB5tiZtef5kXemAzrxhc0f6e+PM53UGYz03ibW4HfV/cyWdM8SogZ4Jgc0sTTF5
         w1S47IuBKRcGD0SJUMejekuK0yqkc0fHptq7OcWTwEMiWqhN++AH/LYMq6Pqz1o4swko
         3ENnDV7FlizKLRp8P0r6vnjJYsGTN8nNQL41c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=PcW0AMyemP7nX0bJyobZSzJUI/+kikA2CTU0zB8Y3XvzooS39YSLM9Dyw7QVB7urhv
         dW/YRLZQJcyz0Bcv7c938Mxdfgzo73zOXqfBep9AI4Ti1fnTM0EwDSa/b2aAjdUgiHKa
         oBTGqceeJ9JuCH85IrdOaF63W4dD/D34iR0mY=
Received: by 10.216.163.207 with SMTP id a57mr2511434wel.220.1269458316044; 
	Wed, 24 Mar 2010 12:18:36 -0700 (PDT)
In-Reply-To: <4ba780dc.5744f10a.5517.4c2d@mx.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143107>

On Mon, Mar 22, 2010 at 3:38 PM, Michael Witten <mfwitten@gmail.com> wr=
ote:
> =A0 =A0 However, it's still the case that Michael Haggerty
> =A0 =A0 is essentially stuck with "mhagger@MIT.EDU" for
> =A0 =A0 his identification---a problem that my proposal
> =A0 =A0 essentially fixes, as described now:]
>
> =A0 =A0I'm proposing ALLOWING him to say:
>
> =A0 =A0 =A0 =A0[user]
> =A0 =A0 =A0 =A0 =A0 =A0uuid =A0=3D Michael Haggerty <mhagger@MIT.EDU>
> =A0 =A0 =A0 =A0 =A0 =A0name =A0=3D Michael Haggerty
> =A0 =A0 =A0 =A0 =A0 =A0email =3D mhagger@ALUM.mit.edu
>

=2E..which is the exact same situation as above, where he's "stuck"
using "mhagger@MIT.EDU" for identification. I don't see how this
changes anything (except allowing to distribute an updated
contact-email... But let's face it, git-repos aren't Facebook)

--=20
Erik "kusma" Faye-Lund
