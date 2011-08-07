From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: test z$foo = zbar (and Re: [PATCH 1/3] bisect: relax requirement
 for a working tree.)
Date: Sun, 7 Aug 2011 22:51:10 +1000
Message-ID: <CAH3Anrr=foOSWumaAhT+NKoipPd-r-sCup=5-HH5_XmGxnkJ4Q@mail.gmail.com>
References: <1312714240-23647-1-git-send-email-jon.seymour@gmail.com>
	<1312714240-23647-2-git-send-email-jon.seymour@gmail.com>
	<20110807124150.GA20046@elie.gateway.2wire.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com, chriscool@tuxfamily.org,
	j6t@kdbg.org, jnareb@gmail.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 07 14:55:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qq2tG-00071l-6n
	for gcvg-git-2@lo.gmane.org; Sun, 07 Aug 2011 14:55:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752723Ab1HGMvM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Aug 2011 08:51:12 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:34918 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752430Ab1HGMvL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Aug 2011 08:51:11 -0400
Received: by vxi9 with SMTP id 9so1908126vxi.19
        for <git@vger.kernel.org>; Sun, 07 Aug 2011 05:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=R6D6yS0hgbcu29/BelIrHDHhUPTQ0q/ySwa1gZfWfhw=;
        b=Ha65VPrZ5zZOffxhQXqxaTxSwF0Z0lnW2Vm2LB+qnkFItSg0Mpi2zIKM5vuOQgc33/
         iKHU8t9LbmlDnr3axgD+RpVlA7DO9Ri8UmRsVBCQVaFeUby8YbrX38EJbytDsVmhTD3f
         ogi2pIaAz/i8ixQLEP7pZGIUHNugR+ub1gKxo=
Received: by 10.52.67.235 with SMTP id q11mr3755040vdt.332.1312721470811; Sun,
 07 Aug 2011 05:51:10 -0700 (PDT)
Received: by 10.52.183.134 with HTTP; Sun, 7 Aug 2011 05:51:10 -0700 (PDT)
In-Reply-To: <20110807124150.GA20046@elie.gateway.2wire.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178909>

On Sun, Aug 7, 2011 at 10:41 PM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Jon Seymour wrote:
+ =C2=A0 =C2=A0 fi
>
> Am I the only one who finds this
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test "z$foo" =3D "zbar"
>

Yeah, I do too.

The only reason I did it this way was because this is how it is done
in git-sh-setup.

jon.
