From: =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Subject: Re: What's cooking in git.git (Jul 2015, #05; Mon, 20)
Date: Tue, 21 Jul 2015 20:56:46 +0200
Message-ID: <55AE95EE.1080500@gmail.com>
References: <xmqqwpxuwh8d.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 21 20:57:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHcj8-0003WN-7p
	for gcvg-git-2@plane.gmane.org; Tue, 21 Jul 2015 20:57:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933742AbbGUS5O convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Jul 2015 14:57:14 -0400
Received: from mail-wi0-f179.google.com ([209.85.212.179]:35618 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933262AbbGUS5N (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jul 2015 14:57:13 -0400
Received: by wibxm9 with SMTP id xm9so131574413wib.0
        for <git@vger.kernel.org>; Tue, 21 Jul 2015 11:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-type:content-transfer-encoding;
        bh=r0LX7X6tOTm8jwGMaqgOiT8Rzc1hQnePqbijcv7DJk4=;
        b=OoSApZvb49oYVcJRqaWoBzTEi2SX4RYrnFpQBxZzFZHVRuekGkHjs2ptSaVqF3S/wJ
         g0fkQhDCVFt/kSw8lJjdpS+W+SV8Bg1jtiwBQMFVpVJKpDyJZD/c+WwlIg/XTvzGhKip
         +sBqoII6eUIZJRTTkNTkDuIb6DPdme4SZrpF2EkYEH3ul9bWmsltQVVLOsu+/PwVBN/O
         vEX6fprFLbAKoIxYoffUzK3aoo52Z9g5WgxMCAgu8A9p3ZpHoUHtrHP+Pd0gbSiKZmLC
         NNdaJG3Pz9VDBZ8XqB1Duw4NvPZGbrLMlF0pQtgZL4Py24tGG3Np+l8NqZqjJqZv/IgM
         eo+w==
X-Received: by 10.194.57.232 with SMTP id l8mr22038150wjq.48.1437505032222;
        Tue, 21 Jul 2015 11:57:12 -0700 (PDT)
Received: from [192.168.1.53] (eln240.neoplus.adsl.tpnet.pl. [83.21.207.240])
        by smtp.googlemail.com with ESMTPSA id hn2sm38335400wjc.45.2015.07.21.11.57.10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Jul 2015 11:57:11 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
In-Reply-To: <xmqqwpxuwh8d.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274395>

On 2015-07-21, Junio C Hamano wrote:

> --------------------------------------------------
> [Stalled]
>=20
> * sg/config-name-only (2015-05-28) 3 commits
>  - completion: use new 'git config' options to reliably list variable=
 names
>  - SQUASH
>  - config: add options to list only variable names
>=20
>  "git config --list" output was hard to parse when values consist of
>  multiple lines.  Introduce a way to show only the keys.

Errr... isn't it what we have -z / --null for?

>  Adding a single --name-only option may be a better way to go than
>  adding two new options.

But that is a good idea anyway.

> * tf/gitweb-project-listing (2015-03-19) 5 commits
>  - gitweb: make category headings into links when they are directorie=
s
>  - gitweb: optionally set project category from its pathname
>  - gitweb: add a link under the search box to clear a project filter
>  - gitweb: if the PATH_INFO is incomplete, use it as a project_filter
>  - gitweb: fix typo in man page
>=20
>  Update gitweb to make it more pleasant to deal with a hierarchical
>  forest of repositories.
>=20
>  Any comments from those who use or have their own code in Gitweb?

Sent a reply to wrong (old) thread, sorry.

tl;dr - first can be applied unconditionally, others have slight
issues. Cgit implements something like this, though with limit
(only first directory path), and different UI - it looks useful
on https://git.kernel.org/cgit/
=20
--=20
Jakub Nar=C4=99bski
