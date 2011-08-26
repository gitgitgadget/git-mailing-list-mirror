From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: git diff annoyance / feature request
Date: Fri, 26 Aug 2011 23:16:57 +0200
Message-ID: <4E580D49.1070006@lsrfire.ath.cx>
References: <4E569F10.8060808@panasas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git discussion list <git@vger.kernel.org>
To: Boaz Harrosh <bharrosh@panasas.com>
X-From: git-owner@vger.kernel.org Fri Aug 26 23:18:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qx3ms-0006tm-N9
	for gcvg-git-2@lo.gmane.org; Fri, 26 Aug 2011 23:18:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755430Ab1HZVR6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Aug 2011 17:17:58 -0400
Received: from india601.server4you.de ([85.25.151.105]:47995 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755184Ab1HZVR5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Aug 2011 17:17:57 -0400
Received: from [192.168.2.104] (p4FFDB0BF.dip.t-dialin.net [79.253.176.191])
	by india601.server4you.de (Postfix) with ESMTPSA id E14012F8034;
	Fri, 26 Aug 2011 23:17:55 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:6.0) Gecko/20110812 Thunderbird/6.0
In-Reply-To: <4E569F10.8060808@panasas.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180201>

Am 25.08.2011 21:14, schrieb Boaz Harrosh:
>=20
> git diff has this very annoying miss-fixture where it will state
> as hunk header the closest label instead of the function name.
>=20
> So I get:
> @@ -675,9 +670,23 @@ try_again:
>  	}
> =20
>  	if (flag) {
> -		foo();
> +		bazz();
>  	}
> =20
> =20
> Instead of what I'd like:
> @@ -563,12 +563,7 @@ static int write_exec(struct page_collect *pcol)
>  	}
> =20
>  	if (flag) {
> -		foo();
> +		bazz();
>  	}

Cheap trick: change your coding style to place a single space before
labels instead of having them start right at the beginning of a line.

Ren=C3=A9
