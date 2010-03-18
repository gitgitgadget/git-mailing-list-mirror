From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] Prompt for a username when an HTTP request 401s
Date: Fri, 19 Mar 2010 00:53:32 +0100
Message-ID: <4BA2BCFC.9070600@lsrfire.ath.cx>
References: <d411cc4a1003181157o79f1a1e1qcdea05322d76b812@mail.gmail.com> <20100318190309.GC10981@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Scott Chacon <schacon@gmail.com>, git list <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Mar 19 00:53:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsPXG-0006b6-NB
	for gcvg-git-2@lo.gmane.org; Fri, 19 Mar 2010 00:53:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752172Ab0CRXxu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Mar 2010 19:53:50 -0400
Received: from india601.server4you.de ([85.25.151.105]:33607 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751153Ab0CRXxt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Mar 2010 19:53:49 -0400
Received: from [10.0.1.100] (p57B7FECE.dip.t-dialin.net [87.183.254.206])
	by india601.server4you.de (Postfix) with ESMTPSA id 3CBB92F803E;
	Fri, 19 Mar 2010 00:53:48 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.1.8) Gecko/20100227 Thunderbird/3.0.3
In-Reply-To: <20100318190309.GC10981@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142541>

Am 18.03.2010 20:03, schrieb Shawn O. Pearce:
> Scott Chacon <schacon@gmail.com> wrote:
>> +static void get_http_user_name()
>> +{
>> +	user_name =3D xstrdup(getpass("Username: "));
>=20
> Why are we getting the username via a password prompt where echo
> has been disabled?  Traditionally a username field is obtained as
> echoed input.
>=20
> Also, this method shouldn't be named get_*() if its returning void.
> Sounds far to funny.  init_http_user_name()?  prompt_for_user_name()?

Or inline the one-liner at its single call-site?

Ren=E9
