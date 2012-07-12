From: Alexander Strasser <eclipse7@gmx.net>
Subject: Re: [PATCH 3/6] t4012: Actually quote the sed script
Date: Fri, 13 Jul 2012 00:26:52 +0200
Message-ID: <20120712222652.GB2782@akuma>
References: <20120711221241.GA21342@akuma>
 <4FFEBFE2.5030206@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Fri Jul 13 00:27:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SpRqj-0006WG-Ig
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jul 2012 00:27:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755684Ab2GLW07 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Jul 2012 18:26:59 -0400
Received: from mailout-de.gmx.net ([213.165.64.23]:35416 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752323Ab2GLW07 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2012 18:26:59 -0400
Received: (qmail invoked by alias); 12 Jul 2012 22:26:56 -0000
Received: from p5DC37306.dip.t-dialin.net (EHLO gmx.net) [93.195.115.6]
  by mail.gmx.net (mp039) with SMTP; 13 Jul 2012 00:26:56 +0200
X-Authenticated: #8251126
X-Provags-ID: V01U2FsdGVkX18eW1YPz2QeX7IPmq/KkLl5OtJ8KZ9Wf9I02UCjph
	/BnK/mkXNLMGPL
Received: by gmx.net (sSMTP sendmail emulation); Fri, 13 Jul 2012 00:26:52 +0200
Content-Disposition: inline
In-Reply-To: <4FFEBFE2.5030206@in.waw.pl>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201388>

Hi Zbigniew,

Zbigniew J=C4=99drzejewski-Szmek wrote:
> On 07/12/2012 12:12 AM, Alexander Strasser wrote:
[...]
> I have some spelling corrections (minor, but since you intend to re-r=
oll
> anyway, I'll post them), and one more thing which could be corrected
> (below).
>=20
> 3/6: s/Never the less/Nevertheless/
> 4/6: s/masquerading/masking/     (masquerade means to "mask oneself")
[...]
> >  	 if git apply --stat --summary broken 2>detected
> >  	 then
> >  		echo unhappy - should have detected an error
> I think this can be changed to:
>    test_must_fail git apply --stat --summary broken 2>detected

  Thank you for your sharp feedback. I will implement the requested
changes for the re-roll.

  Alexander
