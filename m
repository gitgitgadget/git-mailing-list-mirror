From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: organizing multiple repositories with dependencies
Date: Mon, 16 Apr 2012 07:30:17 -0700 (PDT)
Message-ID: <m3hawjagw9.fsf@localhost.localdomain>
References: <1334568432.53977.YahooMailNeo@web65906.mail.ac4.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Namit Bhalla <namitbhalla@yahoo.com>
X-From: git-owner@vger.kernel.org Mon Apr 16 16:30:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJmwi-0006th-Np
	for gcvg-git-2@plane.gmane.org; Mon, 16 Apr 2012 16:30:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753989Ab2DPOaU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Apr 2012 10:30:20 -0400
Received: from mail-wg0-f42.google.com ([74.125.82.42]:46678 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753512Ab2DPOaT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Apr 2012 10:30:19 -0400
Received: by wgbds11 with SMTP id ds11so7756462wgb.1
        for <git@vger.kernel.org>; Mon, 16 Apr 2012 07:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=uZVEzLKJUzNErWpyRBJzPfw2j9A0IYl67qyTNF+hNWs=;
        b=BLtcgjOJDcg9BxqBvM02OCmmgHnjq+9kRCl+zjSd+ibWaccKzi8JmQrtAXsN8uDBoy
         2oBnD+/iIPvYlQvnDpPZkS2sg3a28o+jssbdos9DHLSNz2GCUBoyNYp06yAQFo9X0d1L
         xgwSOfR5G4LGgqmDBQASua98DkphW6Cz+EBGv0+pEMxMwh6Yioxtr230eMP1lTwxz1GJ
         AzehCXOsq9h8cywTPYHg+J/fp/dxEG7Bp/jJ1LpMMWu6/swoIFLEc7C8wy1h7SBdp2NR
         66hALxxPVBZCmY8lJqnOV42DxZu1Gg85v7/9dYrvBBdbntAkoP7oRROuNyJgavfB9uA7
         hGnw==
Received: by 10.180.104.230 with SMTP id gh6mr19137397wib.22.1334586618428;
        Mon, 16 Apr 2012 07:30:18 -0700 (PDT)
Received: from localhost.localdomain (aedx242.neoplus.adsl.tpnet.pl. [79.186.101.242])
        by mx.google.com with ESMTPS id k6sm20007670wiy.7.2012.04.16.07.30.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 16 Apr 2012 07:30:17 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id q3GEUFQZ021948;
	Mon, 16 Apr 2012 16:30:16 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id q3GEUFKk021945;
	Mon, 16 Apr 2012 16:30:15 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1334568432.53977.YahooMailNeo@web65906.mail.ac4.yahoo.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195637>

Namit Bhalla <namitbhalla@yahoo.com> writes:

> I am looking to track some projects using Git with each project as a=20
> separate repository.
> Even after reading the documentation, I am still wondering if there i=
s a=20
> way to organize things as described below.
>=20
> Consider 2 projects, Project-a and Project-b, which are housed in=20
> repositories Repo-a and Repo-b respectively.=A0
> Project-a develops reusable libraries which are needed by Project-b=20
> (otherwise Project-b will not compile).
> When a new stable version of Project-a libraries has to be delivered,=
 they=20
> are "checked into" a path in Repo-a.
> Now, I would like to setup Repo-b so that when someone starts working=
 on=20
> Project-b, he should be able to retrieve the code from Repo-b as well=
 as the libraries from Repo-a. Is there any way to achieve that in=20
> Git?

Put reusable library in its own repository, and use submodules to link
it up to project-a and project-b repositories.

HTH
--=20
Jakub Narebski
