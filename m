From: Yann Droneaud <ydroneaud@opteya.com>
Subject: Re: [PATCH] git-tag(1): we tag HEAD by default
Date: Wed, 03 Apr 2013 17:18:09 +0200
Organization: OPTEYA
Message-ID: <3b24bc742b9738531d707932a9775c98@meuh.org>
References: <137ebfa428b16497287c55e552372df1087f1588.1364999181.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Apr 03 17:18:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNPST-0007EO-GX
	for gcvg-git-2@plane.gmane.org; Wed, 03 Apr 2013 17:18:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760280Ab3DCPSM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Apr 2013 11:18:12 -0400
Received: from mx-out.ocsa-data.net ([194.36.166.37]:58410 "EHLO
	mx-out.ocsa-data.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759871Ab3DCPSM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Apr 2013 11:18:12 -0400
Received: from [192.168.111.12] (helo=rc.ouvaton.coop)
	by mx-out.ocsa-data.net with esmtpa (Exim - FreeBSD Rulez)
	id 1UNPRx-000JHS-7L; Wed, 03 Apr 2013 17:18:09 +0200
In-Reply-To: <137ebfa428b16497287c55e552372df1087f1588.1364999181.git.trast@inf.ethz.ch>
X-Sender: ydroneaud@opteya.com
User-Agent: Roundcube Webmail/0.8.4
X-abuse-contact: abuse@ocsa-data.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219948>

Hi,

Le 03.04.2013 16:27, Thomas Rast a =C3=A9crit=C2=A0:
> The <commit>|<object> argument is actually not explained anywhere
> (except implicitly in the description of an unannotated tag).  Write=20
> a
> little explanation, in particular to cover the default.

> +<commit>, <object>::
> +	The object that the new tag will refer to, usually a commit.
> +	Defaults to HEAD.
> +
> +

This puzzled me a lot, so I try various configuration:
- I was able to create an annotated tag on an annotated tag (this can=20
be recursively)

   git tag -a -m "tagged a tag" test_tag_tag v1.8.2
   git show test_tag_tag

- I was able to tag a file

   git tag -a -m "tagged a file" test_tag_file `git ls-tree HEAD | awk=20
'{ print $3; exit; }'`
   git show test_tag_file
   git show -p test_tag_file


Is there any other kind of object that can be tagged ... and what is=20
the purpose of this ?


Regards.

--=20
Yann Droneaud
OPTEYA
