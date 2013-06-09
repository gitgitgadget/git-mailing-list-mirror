From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: [PATCH v4 09/45] sequencer: remove useless indentation
Date: Sun, 9 Jun 2013 21:48:50 +0200
Message-ID: <20130609194850.GD12122@paksenarrion.iveqy.com>
References: <1370796057-25312-1-git-send-email-felipe.contreras@gmail.com>
 <1370796057-25312-10-git-send-email-felipe.contreras@gmail.com>
 <20130609181724.GA11516@paksenarrion.iveqy.com>
 <CAMP44s3VL-uDPcsUyaYX3ESFbdj7h0XGuVZD+y8J_KewHcPC5g@mail.gmail.com>
 <20130609190814.GA12122@paksenarrion.iveqy.com>
 <CAMP44s0dNM2L7u=XPP82DnKFXmgC-kC6yeJYAgCPLeMEgJaH3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Fredrik Gustafsson <iveqy@iveqy.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 09 21:46:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UllZA-0004SK-3d
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 21:46:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752545Ab3FITqM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jun 2013 15:46:12 -0400
Received: from mail-la0-f42.google.com ([209.85.215.42]:43462 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751260Ab3FITqL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 15:46:11 -0400
Received: by mail-la0-f42.google.com with SMTP id eb20so5157612lab.15
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 12:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=GTs0HA2ni153R/QvsindlX3X0BlDDeT0QK8Xw5hiVpY=;
        b=CVLB0SZ39gMDN+0+218MfWw5Qp5E5i+4cFBgBUBFiQfS2cVfCEaW+Tz0EhrDZqmq3/
         +GhljgC+FDrS1lnHEPvFsLoGXZZ/5rVnV86+4ib/9gcZK2Y8CCUBAr4mR/JNB5eRksGd
         DkS1Cm3KGjGjYiwUczgtpPSqEFAeuGO2GF3uF+XkdcN0qEW3uS4IqpVK7qiPBEPcTMpk
         VLMn9YAARzQ7DPl5L2O+hrBhdpAw173+wlAtmOEiKsqmksy9a0UCTHu39LCwfTBo4WZU
         77XruxxTNxsmHAVCsfKvOMFd8VLOiRfQPq1oqUugyCvbcONywVdpSrNBLQTF2HE1pba1
         DVyg==
X-Received: by 10.112.204.167 with SMTP id kz7mr5095964lbc.94.1370807169327;
        Sun, 09 Jun 2013 12:46:09 -0700 (PDT)
Received: from paksenarrion.iveqy.com (c83-250-233-181.bredband.comhem.se. [83.250.233.181])
        by mx.google.com with ESMTPSA id zo6sm4491995lbb.9.2013.06.09.12.46.08
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 09 Jun 2013 12:46:08 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1Ullbe-0003MH-Ud; Sun, 09 Jun 2013 21:48:50 +0200
Content-Disposition: inline
In-Reply-To: <CAMP44s0dNM2L7u=XPP82DnKFXmgC-kC6yeJYAgCPLeMEgJaH3A@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227156>

On Sun, Jun 09, 2013 at 02:16:29PM -0500, Felipe Contreras wrote:
> On Sun, Jun 9, 2013 at 2:08 PM, Fredrik Gustafsson <iveqy@iveqy.com> =
wrote:
> > On Sun, Jun 09, 2013 at 01:19:03PM -0500, Felipe Contreras wrote:
> >> The explains what the patch is doing, but not why. Why is more imp=
ortant.
> >
> > You're right. Why are the indentation useless? It doesn't seem to b=
e
> > useless until you added goto. So why is your goto solution better t=
han
> > the previous existing solution?
>=20
> Because it removes useless indentation :)
>=20
> This is what they do in the Linux kernel, you tell me which looks bet=
ter:
>=20
> a)
>=20
> 	if (function1())
> 		goto leave;
> 	if (function2())
> 		goto leave;
> 	if (function3())
> 		goto leave;
> 	if (function4())
> 		goto leave;
> 	good_stuff();
> leave:
> 	final_stuff();
>=20
> or b)
>=20
> 	if (!function1()) {
> 		if (!function2()) {
> 			if (!function3()) {
> 				if (!function4()) {
> 					good_stuff();
> 				}
> 			}
> 		}
> 	}
> 	final_stuff();
>=20
> --=20
> Felipe Contreras

Oh, so this is purely a "this code style is better than the current
code style"-patch? I won't argue with that. I simply trust Junio in suc=
h
cases, I had such discussions with him before.

I thought it was partly to increase cleanup capabilities to. For
example, why isn't msg and defmsg freed when "return allow"?

Still wonder about introducing a new label name for cleanup.

--=20
Med v=E4nliga h=E4lsningar
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com
