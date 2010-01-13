From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH v2 3/3] commit: show interesting ident information in summary
Date: Wed, 13 Jan 2010 19:39:47 +0100
Message-ID: <1DDB570B-350A-40A0-B6E4-ADBDF4BE6BD2@wincent.com>
References: <20100113173408.GA16652@coredump.intra.peff.net> <20100113173951.GC16786@coredump.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v1076)
Content-Type: text/plain; charset=iso-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Adam Megacz <adam@megacz.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 13 19:49:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NV8HD-0001Wc-6K
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 19:49:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752085Ab0AMStB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Jan 2010 13:49:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751328Ab0AMStB
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 13:49:01 -0500
Received: from outmail137145.authsmtp.co.uk ([62.13.137.145]:58188 "EHLO
	outmail137145.authsmtp.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751118Ab0AMStA convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 13:49:00 -0500
X-Greylist: delayed 467 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Jan 2010 13:49:00 EST
Received: from mail-c187.authsmtp.com (mail-c187.authsmtp.com [62.13.128.33])
	by punt9.authsmtp.com (8.14.2/8.14.2/Kp) with ESMTP id o0DIdsi5098268;
	Wed, 13 Jan 2010 18:39:54 GMT
Received: from wincent1.inetu.net (wincent1.inetu.net [209.235.192.161])
	(authenticated bits=128)
	by mail.authsmtp.com (8.14.2/8.14.2/Kp) with ESMTP id o0DIdqmP084099
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 13 Jan 2010 18:39:54 GMT
Received: from [192.168.1.2] (133.Red-88-5-247.dynamicIP.rima-tde.net [88.5.247.133])
	(authenticated bits=0)
	by wincent1.inetu.net (8.13.8/8.13.8) with ESMTP id o0DIdmRe032652
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Wed, 13 Jan 2010 13:39:50 -0500
In-Reply-To: <20100113173951.GC16786@coredump.intra.peff.net>
X-Mailer: Apple Mail (2.1076)
X-Server-Quench: 0a876009-0073-11df-ab46-001185d377ca
X-Report-Spam: If SPAM / abuse - report it at: http://www.authsmtp.com/abuse
X-AuthRoute: OCd3ZggRAFZKTQIy FSICByJGVUMuIRha BAIHMQpCJFdJCUVH ax0dDFNVdwdEHAkR Am4BWF1eVVk/W2N8 dQhSaBtca0hQXgNr T0pMXVMcSwUceEhA W34eWh1yfgwIeX54 YEYsXiFTW0J6dU9g Qk5TFnAHZDM2dTFN VEZFdwNVcQtPKhxC bQMuGhFYa3VsBgsE NC97IWp5ZnIEHWxe RQQILE5ACV0LGSF0 RhYeEC8iBlEEQSp7 LhArLEJUHUAfNV83 OEcgXlRQMhlaERBb GkhXEUdx
X-Authentic-SMTP: 61633436303433.1000:706/Kp
X-AuthFastPath: 255
X-Virus-Status: No virus detected - but ensure you scan with your own anti-virus system.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136856>

El 13/01/2010, a las 18:39, Jeff King escribi=F3:

>  $ git config --global --unset user.name
>  $ git config --global --unset user.email
>  $ git commit -m foo
>  [master 7c2a927] foo
>   Committer: Jeff King <peff@c-71-185-130-222.hsd1.va.comcast.net>
>  Your name and email address were configured automatically based
>  on your username and hostname. Please check that they are accurate.
>  You can suppress this message by setting them explicitly:
>
>      git config --global user.name Your Name
>      git config --global user.email you@example.com
>
>  If the identity used for this commit is wrong, you can fix it with:
>
>      git commit --amend --author=3D'Your Name <you@example.com>'
>
>   1 files changed, 1 insertions(+), 0 deletions(-)

I'll never see this message myself, but I think you could (and perhaps =
=20
should) replace almost all of that with:

   Your name and email address were configured automatically.
   See "git config help" for information on setting them explicitly
   or "git commit help" if you wish to amend this commit.

But like I said, seeing as I won't see the message its verbosity won't =
=20
directly affect me.

Cheers,
Wincent