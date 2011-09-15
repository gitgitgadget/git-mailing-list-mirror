From: Jean-Baptiste Quenot <jbq@caraldi.com>
Subject: Re: [tig] Feeding specific revisions to tig
Date: Thu, 15 Sep 2011 17:10:09 +0200
Message-ID: <CAK6bCawiae55q_+E4pWDs_v6V0RLhU97zrw9P1N5j-eCrVSh9w@mail.gmail.com>
References: <ae63f8b50806041152v11a2997y9411c5ea3ebc9598@mail.gmail.com>
 <20080604192916.GB17327@sigill.intra.peff.net> <ae63f8b50806041304i20de789ej492681f4b9306934@mail.gmail.com>
 <20080604230858.GA27136@sigill.intra.peff.net> <2c6b72b30808060406u10d7b332g22ea28fe5470ddb1@mail.gmail.com>
 <20080808211916.GA30583@sigill.intra.peff.net> <2c6b72b30808100216j2c719bf2yb7dfba651db901e3@mail.gmail.com>
 <ae63f8b50904230755p12170753qf3fc273b48afe4d4@mail.gmail.com> <2c6b72b30904270321t3d73e2c5o5e3ac8d4b627e5ab@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jonas Fonseca <jonas.fonseca@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 15 17:11:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R4Dac-0001yz-Ix
	for gcvg-git-2@lo.gmane.org; Thu, 15 Sep 2011 17:10:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756362Ab1IOPKw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Sep 2011 11:10:52 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:48376 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753389Ab1IOPKv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Sep 2011 11:10:51 -0400
Received: by wwf22 with SMTP id 22so3810016wwf.1
        for <git@vger.kernel.org>; Thu, 15 Sep 2011 08:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=z0Ctbw1yeFuEOd6i31vnGpyPAcLPPQI0d716jwt3pUc=;
        b=AvZiXlj/w6g+mtVEBnOS6Q0Nn9QKZIr1jrcIHlx/rdrW5KahmhGijJ7kmXCHktKnQh
         uqL9LbD+y7eNhzpbhhuR1GlW2LOrsOb0HbE2UrxrUyNdc9Rdm+5YlPMdN5YLcKWXcANQ
         zI9lUgbWYIMNNoeUKkjPalSRlcRawnL2re/mM=
Received: by 10.227.145.139 with SMTP id d11mr197321wbv.60.1316099450069; Thu,
 15 Sep 2011 08:10:50 -0700 (PDT)
Received: by 10.180.96.9 with HTTP; Thu, 15 Sep 2011 08:10:09 -0700 (PDT)
In-Reply-To: <2c6b72b30904270321t3d73e2c5o5e3ac8d4b627e5ab@mail.gmail.com>
X-Google-Sender-Auth: AGDrDcV3WSeUjuivG8ETEOix5mY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181470>

2009/4/27 Jonas Fonseca <jonas.fonseca@gmail.com>:
> Sorry for the slow reply ...
>
> On Thu, Apr 23, 2009 at 16:55, Jean-Baptiste Quenot <jbq@caraldi.com>=
 wrote:
>> Restarting this old thread again. =A0Starting from 0.13 the
>> *tignowalk()* hack does not work anymore. =A0What's the preferred wa=
y to
>> feed specific revisions using stdin now?
>
> I don't know if it is preferred, but it works. First add a git alias:
>
> [alias]
> =A0 =A0 =A0 =A0tignowalk-helper =3D !git rev-list --pretty=3Draw --no=
-walk --stdin<
>
> Then modify tignowalk by replacing the line calling tig to say:
>
> TIG_MAIN_CMD=3D"git tignowalk-helper $tmp" tig </dev/tty
>
> ... and it should work. Maybe more git alias functionality can
> simplify the hack.

Restarting this thread again... it seems like every new version of tig
breaks this usecase :-)

Any idea how to feed specific revisions to tig 0.18?  The trick does
not work anymore, as support for TIG_MAIN_CMD was dropped.
--=20
Jean-Baptiste Quenot
