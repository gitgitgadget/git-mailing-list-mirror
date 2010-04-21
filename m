From: Aghiles <aghilesk@gmail.com>
Subject: Re: git pull behavior changed?
Date: Wed, 21 Apr 2010 19:57:17 -0400
Message-ID: <u2n3abd05a91004211657v3dcdaf40j3608f3d8f59c4c1b@mail.gmail.com>
References: <u2z3abd05a91004211413rcd2440fdq7946ef4764b24362@mail.gmail.com> 
	<v2hfabb9a1e1004211422ybbf47ef0gd5dfd1791eb03c16@mail.gmail.com> 
	<y2p3abd05a91004211455r30d13932t92dfbedff581b9a1@mail.gmail.com> 
	<vpqsk6omppf.fsf@bauges.imag.fr> <h2o3abd05a91004211504pfc2de8b7sa37c9c0a4dd14f57@mail.gmail.com> 
	<86tyr4v12n.fsf@red.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	git list <git@vger.kernel.org>
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
X-From: git-owner@vger.kernel.org Thu Apr 22 01:57:50 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4jnd-0007Cl-Bm
	for gcvg-git-2@lo.gmane.org; Thu, 22 Apr 2010 01:57:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754731Ab0DUX5k convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Apr 2010 19:57:40 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:61234 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752607Ab0DUX5j convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Apr 2010 19:57:39 -0400
Received: by wyb39 with SMTP id 39so4430121wyb.19
        for <git@vger.kernel.org>; Wed, 21 Apr 2010 16:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=ipDsecj5TDovUBobN03Ox9qrcClrkmodLVYZNxW+iy0=;
        b=RjRcF+D5UenZ+ubSBJg2fO/XJt1cMsKTcdbif0BOyiYZEJHp7LiSckw7i0KH+i+rb1
         wiiA0E6Gz52fPOz1p5b+x52OH+t2MP4wW03awGufevv4NBVN95PgH910M37HGXg2yttb
         Yge1jmfRLqV29kZV837txs9NRIvTSxBj9k2wo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=FvZfnWfYU/ES6DMhfygcQrKssZyAxMLkMNNbaBzMcsZKkKSrouxFH9/5aklRnP6hTE
         FpqqNqc0d+B6+LRYyPsBtd+U2AQSm5M/OS5snU00a68hnCmGUMZs/cTZr6kht7xEXCQ2
         tzBNlX4Q164j537tJmr6GBCn0IunDwTjH56zE=
Received: by 10.216.157.212 with HTTP; Wed, 21 Apr 2010 16:57:17 -0700 (PDT)
In-Reply-To: <86tyr4v12n.fsf@red.stonehenge.com>
Received: by 10.216.156.203 with SMTP id m53mr285842wek.209.1271894257172; 
	Wed, 21 Apr 2010 16:57:37 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145477>

On Wed, Apr 21, 2010, Randal L. Schwartz  wrote:
> =A0 =A0git checkout -b test origin/test
> =A0 =A0...
> =A0 =A0git pull
>
> And it seems to work. =A0It even announces that my test is tracking o=
rigin/test.

Yes that syntax works too (although I use origin/master since I am trac=
king
the main branch and not the remote "test" branch). Thank you very much.

The message announcing the tracked branch is a nice touch.

  -- aghiles
