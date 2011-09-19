From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: upgrading GIT from version 1.7.0.4 to 1.7.6.1.
Date: Mon, 19 Sep 2011 05:55:02 -0700 (PDT)
Message-ID: <m3d3ewsnei.fsf@localhost.localdomain>
References: <1316435430491-6808156.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?iso-8859-15?q?Mika=EBl?= <mikael.donini@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 19 14:55:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5dNU-0001Qh-J9
	for gcvg-git-2@lo.gmane.org; Mon, 19 Sep 2011 14:55:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756096Ab1ISMzI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Sep 2011 08:55:08 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:62065 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755959Ab1ISMzH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Sep 2011 08:55:07 -0400
Received: by fxe4 with SMTP id 4so3867088fxe.19
        for <git@vger.kernel.org>; Mon, 19 Sep 2011 05:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=UO5yx5O4YmKH+Gby+WXr2q94ELCGttxBb/suaA0JcNQ=;
        b=CCUbkFpro0cmzZS/M1dJftdbD/qq8dS97vNAGgwDFK4zEiHAplKorLWS7d4lCdw7A/
         WtsUkraPehBYmm1JxKT77n95EhW6ZT/5NQiDO7aJSap2mSIwDYmwv33pMy5LhziGzh5p
         IdexHjIcUHAnZ3lnbYkvzPa5Ry9eAi3hd4J+k=
Received: by 10.223.44.89 with SMTP id z25mr4027773fae.42.1316436905875;
        Mon, 19 Sep 2011 05:55:05 -0700 (PDT)
Received: from localhost.localdomain (abvo48.neoplus.adsl.tpnet.pl. [83.8.212.48])
        by mx.google.com with ESMTPS id n12sm18256083fan.9.2011.09.19.05.55.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 19 Sep 2011 05:55:02 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p8JCsftM009898;
	Mon, 19 Sep 2011 14:54:51 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p8JCsUIk009894;
	Mon, 19 Sep 2011 14:54:30 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1316435430491-6808156.post@n2.nabble.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181678>

Mika=EBl <mikael.donini@gmail.com> writes:

> Today, it is the time for us to upgrade from version 1.7.0.4 to
> 1.7.6.1 (the latest stable).  It is important for us to work with
> the latest version since it corrects defects that are very impacting
> for us.
>=20
> The difficulty of this migration is that we can't afford migrations p=
roblems
> (in order to maintain productivity and work).
>=20
> That is the reason why I have a couple of questions:
>=20
> 1- Is it possible to have two GIT installations pointing on the same
> repositories?=20
>=20
> One of this installation would be GIT 1.7.6.1 used by a restricted nu=
mber of
> people (these people could be called 'beta-testers' of the new GIT ve=
rsion).
> The other installation would be GIT 1.7.0.4 used by the other users (=
the
> majority of users) with no impact on their productivity.
>=20
> Once the beta-tests will be finished and successful, all the users wi=
ll move
> to GIT 1.7.6.1.

Git is forward and backward compatibile, meaning that old clients can
connect to new servers (perhaps not using new features), and new
clients can connect to old servers.

The exceptions are few (submodules, packed refs), are always announced
long in advance, with a long transition period: first a configuration
variable is added to switch to new incompatibile behavior defaulting
to old behavior, only after a time there is switch to new improved
incompatibile version.

--=20
Jakub Nar=EAbski
