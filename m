From: =?ISO-8859-1?Q?J=E9r=E9mie_NIKAES?= <jeremie.nikaes@gmail.com>
Subject: Re: Git fast-import : Warning duplicated ref: refs/remotes/origin/master
Date: Mon, 30 May 2011 17:07:26 +0200
Message-ID: <BANLkTinRscvPLHbob55pxhXSTKqm+eSF6g@mail.gmail.com>
References: <BANLkTinTuEppMGO16z2sMkjV8FveCbrwEQ@mail.gmail.com>
 <20110529232405.GA8369@elie> <BANLkTinhH7ksP8EZV+Sd4ryCT1_bhVhgaw@mail.gmail.com>
 <20110530145203.GA10879@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Sylvain Boulme <Sylvain.Boulme@imag.fr>,
	Mike Hommey <mh@glandium.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 30 17:08:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QR44O-0005e4-CF
	for gcvg-git-2@lo.gmane.org; Mon, 30 May 2011 17:07:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752391Ab1E3PHr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 May 2011 11:07:47 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:33887 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751753Ab1E3PHr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 May 2011 11:07:47 -0400
Received: by pzk9 with SMTP id 9so1641786pzk.19
        for <git@vger.kernel.org>; Mon, 30 May 2011 08:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=VJuRls03Ahc0iv7uITm6iIslKUqJ10i9/wQKmC6Sv80=;
        b=d0bHIqKVYzsC/uokyuDYyX646rttvZkjFzJ5/9HkQ9UqeFsBlWEMwwNwDlC7RkLvyW
         3CZ33S5X1DfTjD5DSfkJMHElxRaiFVghY7kmVWKpuZ3tAJSqgekRqQgJu7IjJUKtUe/Q
         RKouSwYyk+k3K7S2n/jO9gzE6XhygxaKWPJjc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=tVOBrU8rm5tTzkEI48NW+sBfuECaNe8BgnhUOsGpeNK4OFmkN4H31PzdHQxuPye81B
         CzlmW+Kgm8kzVr+Tv1S/xP+ZFo+hRGkEif5Y/KR3XTjrk1Ret6i4AJTAPDkzBStX8V28
         hMGQ5GlVIjx4Mp46X5S7CPoe5tZtaDIBmzGRw=
Received: by 10.142.43.15 with SMTP id q15mr695815wfq.348.1306768066348; Mon,
 30 May 2011 08:07:46 -0700 (PDT)
Received: by 10.142.13.11 with HTTP; Mon, 30 May 2011 08:07:26 -0700 (PDT)
In-Reply-To: <20110530145203.GA10879@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174754>

>
> Could you push a branch exhibiting the problem? =A0The reason I ask
> is that searching with
>
> =A0 =A0 =A0 =A0git grep -F -e 'duplicated ref' origin/master
>
> in git.git yields no hits for me, so I wanted to reproduce this to ge=
t
> the exact error message or figure out which program is printing it.
>
> Thanks.
>

Ok I just committed my changes to the master branch, feel free to pull
and try it out.

Thanks for your help
--=20
J=E9r=E9mie Nikaes
