From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Can I enforce required approval on some files
Date: Wed, 21 Jul 2010 09:51:22 +0200
Message-ID: <201007210951.25150.jnareb@gmail.com>
References: <AANLkTinQI9eBnwjzPhYHMM8XZ0ODfHJ1qiZJrNWQWUno@mail.gmail.com> <m36309n75a.fsf@localhost.localdomain> <AANLkTilWzSU9Uh0QT5CcauXiiBKtkG37To57s6zUxzDK@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Dominik Gront <dgront@gmail.com>, git@vger.kernel.org
To: =?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
	<avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 21 09:51:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ObU5g-0004WC-2H
	for gcvg-git-2@lo.gmane.org; Wed, 21 Jul 2010 09:51:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762783Ab0GUHvi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Jul 2010 03:51:38 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:34577 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755065Ab0GUHvh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jul 2010 03:51:37 -0400
Received: by fxm14 with SMTP id 14so3311291fxm.19
        for <git@vger.kernel.org>; Wed, 21 Jul 2010 00:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=d266pGMLED9Lw+QoI8sLH/wJh/BRbTtVMwBJFqBnXTk=;
        b=biN5nKxreC4MMau/qy1XsxaeCUuWLQkVcJ52lIw/G4Rwnv5bjXn0441HOvvv5ULIqr
         nhAFpQiDsDXVVcE3FJDRG1z1exTz0BpNokcK4/YrPc5waG6WNoK0KD6sMavR28YnBc6A
         lUaCFmnjqtHoiFiH/dHqbLtnlRSX9aAFLcC9U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=rM4twD0Of3rmmEpAcu/CREWq7iF/l8ZHCgqnz1FMWn+9vE8xk3GC8tPyH91eVb3GWu
         MZAOhpckEfGzfPBNud7Jc4Dort6gL5051jkTQoyGcvxFcDi6+2t6xKP7tflwe0O1xBGM
         vJuWljMc8vrp2vl4sWY0d6FdgJsMGOrywH6io=
Received: by 10.86.70.16 with SMTP id s16mr4866818fga.26.1279698696574;
        Wed, 21 Jul 2010 00:51:36 -0700 (PDT)
Received: from [192.168.1.13] (aeho173.neoplus.adsl.tpnet.pl [79.186.196.173])
        by mx.google.com with ESMTPS id r8sm2784711faq.34.2010.07.21.00.51.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 21 Jul 2010 00:51:35 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <AANLkTilWzSU9Uh0QT5CcauXiiBKtkG37To57s6zUxzDK@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151391>

On Wed, 21 Jul 2010, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Tue, Jul 20, 2010 at 22:03, Jakub Narebski <jnareb@gmail.com> wrot=
e:
>=20
> > Besides solution mentioned by others, namely integration repository
> > with moderator, you can also use patch/commit code review tool such=
 as
> > Gerrit (http://code.google.com/p/gerrit/), equivalent of Rietveld f=
or
> > Subversion, or Mondrian for Perforce.
>=20
> There's also the low-tech solution of just telling people to submit
> again until their patches don't suck, it works for git.git, and is
> attainable when you're not doing a centralized tool.

That's what I meant by "besides [...] integration repository with
moderator", moderator who reviews patches or pull requests, and accepts
into integration repository or rejects them.

--=20
Jakub Narebski
Poland
