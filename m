From: bill lam <cbill.lam@gmail.com>
Subject: Re: Replacing a Remote Branch
Date: Sat, 24 Jul 2010 09:17:52 +0800
Message-ID: <20100724011752.GA3333@debian.b2j>
References: <4C49F83B.4060903@cybersprocket.com>
 <201007232248.49520.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric@cybersprocket.com, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sat Jul 24 03:18:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcTNU-0002G0-Sc
	for gcvg-git-2@lo.gmane.org; Sat, 24 Jul 2010 03:18:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757190Ab0GXBSH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Jul 2010 21:18:07 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:51532 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757117Ab0GXBSE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Jul 2010 21:18:04 -0400
Received: by pvc7 with SMTP id 7so3736525pvc.19
        for <git@vger.kernel.org>; Fri, 23 Jul 2010 18:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=jHgnIYAdiFHzrlMXol6ZeJdAVVhSBHjSYwu+nbRxaDI=;
        b=BHps3yuYCSehZj9Ri6lKSkdk5tNBpxIGK4x139P036h+R1lvl37zyJyt8l2OuOCwqq
         M/SVD6xCZOV4/u0lUm2Dp9vyDQg5gusqNXi/sn7yPn8oeiztfvAW5tu+aNcu4c5SkIO+
         /uVOeyZtZuBFG6NxbInPDl50ZOTSgU7ZVWPyc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=fZJ///W2qotxNYq4PsH3DtdNWEohHT1LVdefxUb+rDHk7WaOmMPrOPO0JjCsBbm/vG
         5F2RQxOSAv7Byn9J3ZaUC8fukA0p24pytbyPNPnscKFPl07ysd2f8hKvH+2B3IOQYzjE
         kAZ4FFyuFHoCkup4ZH0DmTp0X7c71lQAs7tRU=
Received: by 10.142.156.14 with SMTP id d14mr5090186wfe.86.1279934284029;
        Fri, 23 Jul 2010 18:18:04 -0700 (PDT)
Received: from localhost (n11649174145.netvigator.com [116.49.174.145])
        by mx.google.com with ESMTPS id k25sm937008rvb.4.2010.07.23.18.18.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 23 Jul 2010 18:18:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201007232248.49520.trast@student.ethz.ch>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151594>

=D0=9F=D1=82=D0=BD, 23 =D0=98=D1=8E=D0=BB 2010, Thomas Rast =D0=BF=D0=B8=
=D1=81=D0=B0=D0=BB(=D0=B0):
> Since + overrides the non-ff check, this means that the remote side
> has receive.denyNonFastForwards (see man git-config) enabled (or a
> hook to the same effect).  Deleting and pushing the new branch merely

I also scratched my head why push --force failed to push an
amend/rebase branch to assembla.  IMO it would be nice to mention this
receive.denyNonFastForwards inside man git-push.

--=20
regards,
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
GPG key 1024D/4434BAB3 2008-08-24
gpg --keyserver subkeys.pgp.net --recv-keys 4434BAB3
