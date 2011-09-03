From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Special characters in file name
Date: Sat, 03 Sep 2011 12:57:07 -0700 (PDT)
Message-ID: <m3aaal4cyj.fsf@localhost.localdomain>
References: <4E60C6D0.7090609@intland.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: =?iso-8859-15?q?Tajti_=C1kos?= <akos.tajti@intland.com>
X-From: git-owner@vger.kernel.org Sat Sep 03 21:57:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QzwLD-0006Jb-1q
	for gcvg-git-2@lo.gmane.org; Sat, 03 Sep 2011 21:57:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751907Ab1ICT5L convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 3 Sep 2011 15:57:11 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:40547 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751846Ab1ICT5J convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 Sep 2011 15:57:09 -0400
Received: by fxh19 with SMTP id 19so2667978fxh.19
        for <git@vger.kernel.org>; Sat, 03 Sep 2011 12:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=uICfoHCzBRU3P1FlcPTFtWb0qT+RcMdma4tCtBOvEVU=;
        b=nk8KpkAbSSqonoOQIO22f83gcPHHT+86W1uFfBOw7SMUSpEwjg7OmRzEQNpIyuqOFX
         Yl0lnGiObiV/Fo2z5OgLaI806NOSfg13K2Ruw2fVGDHb9fb8iHtvLcSIRApq25wcQklx
         Yq8QMMfKRN2nZ1OlfNdqPnCP4XlreTReGw+dA=
Received: by 10.223.46.201 with SMTP id k9mr613319faf.1.1315079828124;
        Sat, 03 Sep 2011 12:57:08 -0700 (PDT)
Received: from localhost.localdomain (abwp177.neoplus.adsl.tpnet.pl [83.8.239.177])
        by mx.google.com with ESMTPS id d23sm1795178fam.4.2011.09.03.12.57.06
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 03 Sep 2011 12:57:07 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p83Jub4E008957;
	Sat, 3 Sep 2011 21:56:47 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p83JuL3i008942;
	Sat, 3 Sep 2011 21:56:21 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <4E60C6D0.7090609@intland.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180663>

Tajti =C1kos <akos.tajti@intland.com> writes:

> I have a file named "=E1rv=EDz.txt" in my repository. When modify tha=
t
> file and execute git diff, the first line looks like this:
> diff --git "a/\303\241rv\303\255z.txt" "b/\303\241rv\303\255z.txt"
>=20
> Is there an option that (if specified) will get git to print
> "=E1rv=EDz.txt" instead of this escaped string?

Yes, there is, namely `core.quotepath`.

This probably should make it into FAQ on Git Wiki, and into git-diff
manpage...
--=20
Jakub Nar=EAbski
