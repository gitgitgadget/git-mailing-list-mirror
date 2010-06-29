From: "Per Cederqvist" <cederp@opera.com>
Subject: Re: Confusing error message from "git pull" when upstream repo no
 longer exists
Date: Tue, 29 Jun 2010 13:14:37 +0200
Organization: Opera Mini
Message-ID: <op.ve16un100i1pst@centurion>
References: <op.ve14xqlq0i1pst@centurion>
 <AANLkTilbqmedF9Wh3dG3n9HYtuZuq4PzTwOp6T8NCjQ8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Santi_B=C3=A9jar?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Tue Jun 29 13:14:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTYmH-0005jR-4k
	for gcvg-git-2@lo.gmane.org; Tue, 29 Jun 2010 13:14:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755563Ab0F2LOu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Jun 2010 07:14:50 -0400
Received: from smtp.opera.com ([213.236.208.81]:51658 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755232Ab0F2LOt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Jun 2010 07:14:49 -0400
Received: from centurion (046-tdc.opera.com [213.236.208.46] (may be forged))
	(authenticated bits=0)
	by smtp.opera.com (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id o5TBEdm7024516
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 29 Jun 2010 11:14:43 GMT
In-Reply-To: <AANLkTilbqmedF9Wh3dG3n9HYtuZuq4PzTwOp6T8NCjQ8@mail.gmail.com>
User-Agent: Opera Mail/10.11 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149899>

On Tue, 29 Jun 2010 12:55:29 +0200, Santi B=C3=A9jar <santi@agolina.net=
> wrote:

> On Tue, Jun 29, 2010 at 12:33 PM, Per Cederqvist <cederp@opera.com> =20
> wrote:
>> When running "git pull", I get this error message:
>>
>>    fatal: /usr/local/libexec/git-core/git-pull cannot be used withou=
t a
>> working tree.
>
> This error message is shown when you try to pull in a bare repository
> (without a working tree). It seems you don't have a working tree, but
> you have a repository, so you can still fetch. (the working tree chec=
k
> is done before the fetch).
>
> HTH,
> Santi

Oh. You are correct. I was in a bare repository, so I guess the message
is good after all. Sorry for my mistaken report.

     /ceder
--=20
Per Cederqvist, cederp@opera.com
