From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's cooking in git.git (Dec 2011, #03; Fri, 9)
Date: Fri, 09 Dec 2011 18:16:02 -0800 (PST)
Message-ID: <m3vcppgojy.fsf@localhost.localdomain>
References: <7vk465b834.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-4
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 10 03:16:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZCU1-0001QR-1t
	for gcvg-git-2@lo.gmane.org; Sat, 10 Dec 2011 03:16:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752797Ab1LJCQI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Dec 2011 21:16:08 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:46136 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751166Ab1LJCQG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Dec 2011 21:16:06 -0500
Received: by eekc4 with SMTP id c4so657100eek.19
        for <git@vger.kernel.org>; Fri, 09 Dec 2011 18:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=8wdJqro+00FH/i4/NPLQnaYwskIO5+YJgf+jqpP/4vI=;
        b=vvGQVwVc6AYf4v2q7CAmVkKS5GLUR4/i2fLX2swM/HvVszxnRIHercOadsWBbSAL1I
         RWY6fW8SBtUZPpaQ5Wn78bSVguPVPgm7CYnbpozu3GF+PUPGenvAtJwdAzAL3WFf36JQ
         Icojqpg/VNVsdh04oSE6Nzo1aI+i0VYLcwg0A=
Received: by 10.213.9.136 with SMTP id l8mr477864ebl.62.1323483364209;
        Fri, 09 Dec 2011 18:16:04 -0800 (PST)
Received: from localhost.localdomain (abwc156.neoplus.adsl.tpnet.pl. [83.8.226.156])
        by mx.google.com with ESMTPS id a60sm38997057eeb.4.2011.12.09.18.16.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 09 Dec 2011 18:16:02 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id pBA2FUSR027961;
	Sat, 10 Dec 2011 03:15:41 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id pBA2FDDt027954;
	Sat, 10 Dec 2011 03:15:14 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7vk465b834.fsf@alter.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186718>

Junio C Hamano <gitster@pobox.com> writes:

> --------------------------------------------------
> [Cooking]

> * jn/gitweb-side-by-side-diff (2011-10-31) 8 commits
>  - gitweb: Add navigation to select side-by-side diff
>  - gitweb: Use href(-replay=3D>1,...) for formats links in "commitdif=
f"
>  - t9500: Add basic sanity tests for side-by-side diff in gitweb
>  - t9500: Add test for handling incomplete lines in diff by gitweb
>  - gitweb: Give side-by-side diff extra CSS styling
>  - gitweb: Add a feature to show side-by-side diff
>  - gitweb: Extract formatting of diff chunk header
>  - gitweb: Refactor diff body line classification
>=20
> Replaces a series from Kato Kazuyoshi on the same topic.
> Is this ready for 'next'?

I think it is.

--=20
Jakub Nar=EAbski
