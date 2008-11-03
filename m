From: Brian Foster <brian.foster@innova-card.com>
Subject: Re: [Q] Abbreviated history graph?
Date: Mon, 3 Nov 2008 16:46:20 +0100
Message-ID: <200811031646.20404.brian.foster@innova-card.com>
References: <200811031439.12111.brian.foster@innova-card.com> <adf1fd3d0811030620x1bc53db3y2afb26242e9906ac@mail.gmail.com>
Reply-To: Brian Foster <brian.foster@innova-card.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Santi =?utf-8?q?B=C3=A9jar?=" <santi@agolina.net>
X-From: git-owner@vger.kernel.org Mon Nov 03 16:47:55 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kx1ea-0004q3-5s
	for gcvg-git-2@gmane.org; Mon, 03 Nov 2008 16:47:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754829AbYKCPq3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Nov 2008 10:46:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755252AbYKCPq3
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 10:46:29 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:62862 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754439AbYKCPq2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Nov 2008 10:46:28 -0500
Received: by ug-out-1314.google.com with SMTP id 39so1752387ugf.37
        for <git@vger.kernel.org>; Mon, 03 Nov 2008 07:46:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:reply-to:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id:sender;
        bh=KeNK9/oO5fLnQ5m0+WaM8X6qoPAncQ1auNsLQYKlViY=;
        b=Y76efcCNfXm36UqoSiS4X6EKOfD9mMMbDI6oh/EfJ9GZUvfDF3gHyggUkVb5uLYL0Y
         +hlP/a/9FxkopWRPLpybEeWBwu4z80UlBJzND9GrATqn0en/mWTaiuyhZbN7EKAEslW0
         PoTypyuJWR71daG5natAiiSXyfp489dXRdo3E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:reply-to:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id:sender;
        b=tTCsgj5JCtAikQKzoYE7YbOHWIOWZrkkDxyQLsh/d/q02c6UsPLSGCJjogsaC3MVsx
         1HVDzN+pjFjdmEu5SOi5LCYE8F3jsVP/T3QHPdLrJBe/DFEVaBMIvrq25sxz7uTTFwRi
         iQJCLljL3xO/Gq1N2A2vquTnOP2y85zqsUMoU=
Received: by 10.86.54.3 with SMTP id c3mr264649fga.33.1225727186520;
        Mon, 03 Nov 2008 07:46:26 -0800 (PST)
Received: from innova-card.com (1-61.252-81.static-ip.oleane.fr [81.252.61.1])
        by mx.google.com with ESMTPS id l19sm8684344fgb.7.2008.11.03.07.46.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 03 Nov 2008 07:46:24 -0800 (PST)
User-Agent: KMail/1.9.6 (enterprise 0.20070907.709405)
In-Reply-To: <adf1fd3d0811030620x1bc53db3y2afb26242e9906ac@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99954>

On Monday 03 November 2008 15:20:30 Santi B=C3=A9jar wrote:
>[ ... ]
> >  Is there some way of doing something similar [ the example ]
> >  (git v1.6.0.2)?  In addition to 'gitk', we also (rather
> >  quickly!) tried both 'qgit' and 'giggle', but without
> >  any apparent success.
>=20
> Not in git.git but you can use the script at the bottom [ ... ].

Santi,

   Thanks.  Unfortunately, neither I nor my colleague can try
  it at the moment:  It uses  `git log --pretty=3Dformat:%d'
  which is very new (added c.9-Sept) and not in the versions
  of git we are currently using.  End result is the tempfile
  is always empty, and hence `gitk' shows everything.

cheers!
	-blf-

--=20
=E2=80=9CHow many surrealists does it take to   | Brian Foster
 change a lightbulb? Three. One calms   | somewhere in south of France
 the warthog, and two fill the bathtub  |   Stop E$$o (ExxonMobil)!
 with brightly-coloured machine tools.=E2=80=9D |      http://www.stope=
sso.com
