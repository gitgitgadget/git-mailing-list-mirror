From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH/RFC] http: pass http.cookiefile using CURLOPT_COOKIEFILE
Date: Thu, 2 Jun 2011 17:01:19 -0700
Message-ID: <BANLkTi=3cQx9L4rrkniBhqFfL1TuNgu0doaSpdV8ajgsWJvw1Q@mail.gmail.com>
References: <20110602203125.0E04C734F12@antares.phy.syr.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, skoranda@gravity.phys.uwm.edu
To: Duncan Brown <dabrown@physics.syr.edu>, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jun 03 02:01:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QSHph-0005Hd-71
	for gcvg-git-2@lo.gmane.org; Fri, 03 Jun 2011 02:01:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753899Ab1FCABk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Jun 2011 20:01:40 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:54593 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753703Ab1FCABk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Jun 2011 20:01:40 -0400
Received: by gwaa18 with SMTP id a18so563867gwa.19
        for <git@vger.kernel.org>; Thu, 02 Jun 2011 17:01:39 -0700 (PDT)
Received: by 10.236.76.69 with SMTP id a45mr32921yhe.56.1307059299113; Thu, 02
 Jun 2011 17:01:39 -0700 (PDT)
Received: by 10.146.82.5 with HTTP; Thu, 2 Jun 2011 17:01:19 -0700 (PDT)
In-Reply-To: <20110602203125.0E04C734F12@antares.phy.syr.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174989>

On Thu, Jun 2, 2011 at 13:31, Duncan Brown <dabrown@physics.syr.edu> wr=
ote:
> If the config option http.cookiefile is set, pass this file to libCUR=
L using
> the CURLOPT_COOKIEFILE option. This is similar to calling curl with t=
he -b
> option. =A0This allows git http authorization with authentication mec=
hanisms
> that use cookies, such as SAML Enhanced Client or Proxy (ECP) used by
> Shibboleth.

Wow, the patch was this simple?

Thanks Duncan!

> ---
> =A0Documentation/config.txt | =A0 =A08 ++++++++
> =A0http.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A05 +++++
> =A02 files changed, 13 insertions(+), 0 deletions(-)

Junio, I didn't test this myself, but the code looks good to me. I
don't see any obvious issues with it.

--=20
Shawn.
