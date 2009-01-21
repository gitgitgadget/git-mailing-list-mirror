From: bill lam <cbill.lam@gmail.com>
Subject: Re: how to git a read only directory
Date: Wed, 21 Jan 2009 23:48:42 +0800
Message-ID: <20090121154842.GA6966@b2j>
References: <20090121083354.GG6970@b2j> <4976F195.9030908@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>, cbill.lam@gmail.com
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Jan 21 16:50:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPfLV-0001e0-AI
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 16:50:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754098AbZAUPtA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Jan 2009 10:49:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753859AbZAUPtA
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 10:49:00 -0500
Received: from ti-out-0910.google.com ([209.85.142.188]:57657 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753360AbZAUPs7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2009 10:48:59 -0500
Received: by ti-out-0910.google.com with SMTP id b6so2908446tic.23
        for <git@vger.kernel.org>; Wed, 21 Jan 2009 07:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mail-followup-to:references:mime-version:content-type
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=8mI7GiLyePhJUyXX2yU8r0UPXt2JZniHjpI3z3uEp7o=;
        b=M3eEIOgFKk0UAo6rfus0Dd1hG7TqcaYPlzzQoJlRrYSWz5vbmLJEUZwKDiWkx0fKqL
         gddB6kW2v9j8Y7SZX+yZrOdqP/clZhli9sdcbE1l+cNgmGt+Rl4Jm19f1L7uPVUJ7K3N
         v+9v8KOo/u2OHuA8gmcUWyNHTcHqdyksXU2DQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        b=U0ji9rd8d9SrDveaDKtIFVI+nLSNhoz85OWRUvpH3Gw3dJavKjzPBNjJmMI8ATCEF7
         /8+ZzK/An6RgqWZRA1b7fUfD07M4KCjqifQNHiPu9UNYbputTGaGygrv+XxZllkcp5re
         +jkoDzTuj35Ms14aXsRUZgcp3FcN2spH0bs38=
Received: by 10.110.61.16 with SMTP id j16mr12008602tia.24.1232552937424;
        Wed, 21 Jan 2009 07:48:57 -0800 (PST)
Received: from localhost (pcd589144.netvigator.com [218.102.121.144])
        by mx.google.com with ESMTPS id u12sm1415312tia.29.2009.01.21.07.48.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 21 Jan 2009 07:48:45 -0800 (PST)
Mail-Followup-To: Michael J Gruber <git@drmicha.warpmail.net>,
	git <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4976F195.9030908@drmicha.warpmail.net>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106619>

On Wed, 21 Jan 2009, Michael J Gruber wrote:
> You can use the core.worktree config variable in order to specify a
> worktree (/etc) which is not directly above .git. For your git comman=
ds
> to find the .git dir you would need to set GIT_DIR or use the --git-d=
ir
> parameter.

Michael, thanks for pointing out worktree being the trick to use.

--=20
regards,
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
GPG key 1024D/4434BAB3 2008-08-24
gpg --keyserver subkeys.pgp.net --recv-keys 4434BAB3
=E5=94=90=E8=A9=A9267 =E7=8E=8B=E7=BF=B0  =E6=B6=BC=E5=B7=9E=E8=A9=9E
    =E8=91=A1=E8=90=84=E7=BE=8E=E9=85=92=E5=A4=9C=E5=85=89=E6=9D=AF  =E6=
=AC=B2=E9=A3=B2=E7=90=B5=E7=90=B6=E9=A6=AC=E4=B8=8A=E5=82=AC  =E9=86=89=
=E8=87=A5=E6=B2=99=E5=A0=B4=E5=90=9B=E8=8E=AB=E7=AC=91  =E5=8F=A4=E4=BE=
=86=E5=BE=81=E6=88=B0=E5=B9=BE=E4=BA=BA=E5=9B=9E
