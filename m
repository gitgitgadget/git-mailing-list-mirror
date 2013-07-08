From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: [BUG] git svn geotrust certificate problem
Date: Mon, 8 Jul 2013 21:46:04 +0200
Message-ID: <20130708194604.GA7038@paksenarrion.iveqy.com>
References: <CAOfgeSaRmqRj3gCGy0q9ehr=znzyPONa-Ze03hTo69QLHMuQjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Ilya Holinov <holinov@netvoxlab.ru>
X-From: git-owner@vger.kernel.org Mon Jul 08 21:45:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwHNM-0006gk-Fb
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jul 2013 21:45:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752912Ab3GHTp2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Jul 2013 15:45:28 -0400
Received: from mail-lb0-f169.google.com ([209.85.217.169]:42135 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752833Ab3GHTp1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jul 2013 15:45:27 -0400
Received: by mail-lb0-f169.google.com with SMTP id d10so4101428lbj.0
        for <git@vger.kernel.org>; Mon, 08 Jul 2013 12:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=okQmDumeS7ZKft1MrY+DP9OLfTNgnoRpaY9HR1kTIus=;
        b=JNqRmEB/d7PC7/c3R2pVRA0IUgWyNYvWT30xt6yWXG0801qhkmSVaJjvyVSFgOFYiR
         udVfJ0F8ZmRbPJDG2r8bt8ZV+HAb/O09us170AXEvgbIsRo8Q/e8F/4aTkG/LaWt+6XX
         LNE6O97u3BvaeujSSutNpWjQ/N+C4OhYXEv5j2dwqP1NwbC1FTqXkBTTTznKfwhCko9t
         lW4Chk04m08SxVeVkb+OdJy9W+5mDSBRWx5XbqgsTQr57cWcsSxvybwdSXxgLEn4/izj
         xgxakl47S1S2qRmuaLOT0jicRIrL1UJRlvjYV6vUn6mabDpXkUjrGVrsdsyhk/m3av8B
         GseQ==
X-Received: by 10.112.157.226 with SMTP id wp2mr11292968lbb.65.1373312725108;
        Mon, 08 Jul 2013 12:45:25 -0700 (PDT)
Received: from paksenarrion.iveqy.com (c83-250-233-181.bredband.comhem.se. [83.250.233.181])
        by mx.google.com with ESMTPSA id n3sm8081273lag.9.2013.07.08.12.45.23
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 08 Jul 2013 12:45:24 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1UwHNs-00043p-2l; Mon, 08 Jul 2013 21:46:04 +0200
Content-Disposition: inline
In-Reply-To: <CAOfgeSaRmqRj3gCGy0q9ehr=znzyPONa-Ze03hTo69QLHMuQjA@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229889>

On Fri, Jul 05, 2013 at 07:16:01PM +0400, Ilya Holinov wrote:
> I have svn repository on https singed with GeoTrust issued certificat=
e.
> Every time i try to access this repository i have message :
>=20
> $ git svn rebase
> Error validating server certificate for 'https://svn.egspace.ru:443':
>  - The certificate is not issued by a trusted authority. Use the
>    fingerprint to validate the certificate manually!
> Certificate information:
>  - Hostname: *.egspace.ru
>  - Valid: from Apr 28 01:38:17 2013 GMT until Apr 30 12:00:40 2014 GM=
T
>  - Issuer: GeoTrust, Inc., US
>  - Fingerprint: b2:8d:f8:3b:7c:d2:a2:36:e2:1d:c3:5c:56:ec:87:6f:22:3e=
:4b:a8
> Certificate problem.
> (R)eject, accept (t)emporarily or accept (p)ermanently? p
> Authentication realm: <https://svn.egspace.ru:443> VisualSVN Server
> Username: holinov
> Password for 'holinov':
>=20
> Even if i choose permanently every next attempt to access in i have
> same issue. And this happens on svn rebase on every commit. I mean if
> i have 10 commits in local repository i will be asked about cert and
> user login\passwor for every one of them (and that's is verry
> annoying).
> But if i use TortoiseSVN i have no problem with checking that cert.
>=20
> P.S.: I'm using Windows 8 x64.
> P.P.S: I like git very much but in this case it makes me impossible t=
o
> work in this way.

This isn't really my thing to answer, I don't know windows well enough.
However since you still haven't got an answer I'll give it a try.

Please see the following link:
https://confluence.atlassian.com/display/SOURCETREEKB/Resolving+SSL+Sel=
f-Signed+Certificate+Errors

--=20
Med v=E4nliga h=E4lsningar
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com
