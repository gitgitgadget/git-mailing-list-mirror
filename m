From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH 0/2] branch: improve verbose option
Date: Sat, 31 Aug 2013 15:41:02 +0100
Organization: OPDS
Message-ID: <CD323DA08A0540A89D9BFB28F541AFB4@PhilipOakley>
References: <1377903583-3550-1-git-send-email-felipe.contreras@gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
	<pclouds@gmail.com>, "Jeff King" <peff@peff.net>,
	"Michael J Gruber" <git@drmicha.warpmail.net>
To: "Felipe Contreras" <felipe.contreras@gmail.com>,
	<git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Aug 31 16:40:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFmM5-0001U4-Bc
	for gcvg-git-2@plane.gmane.org; Sat, 31 Aug 2013 16:40:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753533Ab3HaOkp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Aug 2013 10:40:45 -0400
Received: from out1.ip05ir2.opaltelecom.net ([62.24.128.241]:58555 "EHLO
	out1.ip05ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753043Ab3HaOko (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 31 Aug 2013 10:40:44 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AhcMACH/IVJOl3GZ/2dsb2JhbABagwc1g3iFPrd8BAQBgR0XdIIfBQEBBAEIAQEZFR4BASEFBgIDBQIBAxUBBAIFIQICFAEECBIGBxcGARIIAgECAwGHXwMJCginT4gXDYlogSmLZoJwgnA0gQADjw+GfYMYiwiFL4MhOw
X-IPAS-Result: AhcMACH/IVJOl3GZ/2dsb2JhbABagwc1g3iFPrd8BAQBgR0XdIIfBQEBBAEIAQEZFR4BASEFBgIDBQIBAxUBBAIFIQICFAEECBIGBxcGARIIAgECAwGHXwMJCginT4gXDYlogSmLZoJwgnA0gQADjw+GfYMYiwiFL4MhOw
X-IronPort-AV: E=Sophos;i="4.89,997,1367967600"; 
   d="scan'208";a="430484200"
Received: from host-78-151-113-153.as13285.net (HELO PhilipOakley) ([78.151.113.153])
  by out1.ip05ir2.opaltelecom.net with SMTP; 31 Aug 2013 15:40:41 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233518>

From: "Felipe Contreras" <felipe.contreras@gmail.com>
Sent: Friday, August 30, 2013 11:59 PM
> Hi,
>
> This has been discussed before:
>
> http://thread.gmane.org/gmane.comp.version-control.git/224489
>
> but in the spirit of the perfect being the enemy of the good, nothing 
> got done.
>
> This series makes 'git branch -v' much faster, and gives us the most 
> important
> information; the configured upstream tracking branch.

Yes, It's someting I often want reminding of (which origin server, which 
master?, ..etc.) always appear to start here.

>        Showing ahead/behind is
> not as important,

I still find this useful - if it's up to date I don't need reminding of 
which remote / upstream tracking branch it's configured against ;-)

These two bits of information, while related are separate. If anything I 
think I'd prefer both, but then again optimisations are still good.

Bikeshedding ends.

Philip

>    specially considering that currently 'git branch -v' doesn't
> show the branch we are comparing the ahead/behind to.
>
> Strictly speaking it's a regression, but nobody would complain, and if 
> somebody
> does, it should be easy to revert if needed.
>
> Felipe Contreras (2):
>  branch: trivial cleanup
>  branch: reorganize verbose options
>
> builtin/branch.c         | 33 +++++++++++++++------------------
> t/t6040-tracking-info.sh |  8 ++++----
> 2 files changed, 19 insertions(+), 22 deletions(-)
>
> -- 
