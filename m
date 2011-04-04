From: Jonathan Michalon <johndescs@gmail.com>
Subject: Re: Better big file support & GSoC
Date: Mon, 4 Apr 2011 18:53:35 +0200
Message-ID: <20110404185335.2daa5a6a@RunningPinguin.chalmion.homelinux.net>
References: <20110402164051.1f263aa0@RunningPinguin.chalmion.homelinux.net>
 <20110402153008.GA5921@centaur.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Mon Apr 04 18:53:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6n2A-0003ge-6W
	for gcvg-git-2@lo.gmane.org; Mon, 04 Apr 2011 18:53:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754725Ab1DDQxl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Apr 2011 12:53:41 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:49253 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754669Ab1DDQxk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Apr 2011 12:53:40 -0400
Received: by wya21 with SMTP id 21so4839519wya.19
        for <git@vger.kernel.org>; Mon, 04 Apr 2011 09:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:cc:subject:message-id:in-reply-to
         :references:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=wS7DD7Ykr2UtyFvVL3Zc6bHJqa8vUyP6HYjji3HpwNI=;
        b=ObANTahxhOLjqlI85RzTYUPyuCd3+qd0JkvAYb5Tx0S2CeL4u8YjILr0XhEMoO7RUy
         hoWFwonvur5kwFzp9NV571YnjxWy3PKyVY6H/xWvBa9XYldvV9lZsfJtT97/Xdlu2fSw
         iIODw+icS81zrignwxa6tsezkmpO2vvYJFBs8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=jMf7tNPW+LC1InoyH+/3WEiLpykO0HKdm0+Xr3ztT1o9RY/ZMbr2Z8iZBxH1c+gBpF
         AYqbjLkqpqinviJQ9T9WNcqf5kNaY5QRga+vE1jBJC/swftP2WdNFGACpm+E90NxTSZF
         m/4RHbmhXXv8F/X6bvEguX712iP92Yiq/zl+Q=
Received: by 10.216.87.8 with SMTP id x8mr4779554wee.46.1301936018736;
        Mon, 04 Apr 2011 09:53:38 -0700 (PDT)
Received: from RunningPinguin.chalmion.homelinux.net (AStrasbourg-251-1-20-21.w82-126.abo.wanadoo.fr [82.126.210.21])
        by mx.google.com with ESMTPS id h39sm2346166wes.5.2011.04.04.09.53.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 04 Apr 2011 09:53:38 -0700 (PDT)
In-Reply-To: <20110402153008.GA5921@centaur.lab.cmartin.tk>
X-Mailer: Claws Mail 3.7.4 (GTK+ 2.20.1; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170824>

Le Sat, 2 Apr 2011 17:30:15 +0200,
Carlos Mart=EDn Nieto <cmn@elego.de> a =E9crit :
> On Sat, Apr 02, 2011 at 04:40:51PM +0200, Jonathan Michalon wrote:
> > What I personally would like as a feature is the ability to store t=
he main
> > repo with sources etc. into a conventional repo but put the data el=
sewhere
> > on a storage location. This would allow to develop programs which n=
eed data
> > to run (like textures in games etc.) without making the repo slow, =
big or
> > just messy.
>=20
>  This sounds a lot like like what git-annex [0] does. Maybe
>  integrating its functionality with mainline git could be a good
>  start.
>=20
> [0] http://git-annex.branchable.com/
>=20
>    cmn

Edit:
Hum I just failed to reply correcly... did only to the original poster,=
 not the
whole list. My apologies.

Message:
Yes, for sure. I will try to reuse as much code as possible, and diggin=
g into
some which does almost the job will help. But in fact I doubt that it w=
ill be
very comparable both as separate software and integrated code.
In addition Eric Montellese dug already into the code but was not compl=
etely
satisfied. See: http://article.gmane.org/gmane.comp.version-control.git=
/165395

I would like to have the opinion of the community before going in the w=
rong
direction.

--
Jonathan Michalon
