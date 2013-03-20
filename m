From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH v2 0/6] Support triangular workflows
Date: Wed, 20 Mar 2013 23:04:01 -0000
Organization: OPDS
Message-ID: <26A2BE0824FE4C999592D392FCBEF988@PhilipOakley>
References: <1363783501-27981-1-git-send-email-artagnon@gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, "Jeff King" <peff@peff.net>,
	"Eric Sunshine" <sunshine@sunshineco.com>,
	"Jonathan Nieder" <jrnieder@gmail.com>
To: "Ramkumar Ramachandra" <artagnon@gmail.com>,
	"Git List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 21 00:04:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIS3V-0007GY-H5
	for gcvg-git-2@plane.gmane.org; Thu, 21 Mar 2013 00:04:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754729Ab3CTXD6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Mar 2013 19:03:58 -0400
Received: from out1.ip05ir2.opaltelecom.net ([62.24.128.241]:51439 "EHLO
	out1.ip05ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752632Ab3CTXD5 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Mar 2013 19:03:57 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Al8JAKU/SlFOl3xZ/2dsb2JhbABDjVi3VAQBgVEXdIIfBQEBBAEIAQEuHgEBIQUGAgMFAgEDDgcBCyUUAQQIEgYHFwYBEggCAQIDAYdxAwkKCLhmDYlbjEeBOBZ7gmZhA4g/hW2GVIJ/ikmFGoEvgVs8
X-IronPort-AV: E=Sophos;i="4.84,880,1355097600"; 
   d="scan'208";a="412777118"
Received: from host-78-151-124-89.as13285.net (HELO PhilipOakley) ([78.151.124.89])
  by out1.ip05ir2.opaltelecom.net with SMTP; 20 Mar 2013 23:03:55 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218686>

From: "Ramkumar Ramachandra" <artagnon@gmail.com>
Sent: Wednesday, March 20, 2013 12:44 PM
> This follows-up [1], with three important differences:
>
> 1. pushremote_get() and remote_get() share code better.  Thanks Jeff.
>
> 2. All spelling mistakes have been corrected.  Thanks Eric.
>
> 3. One new test for each of the new configuration variables.  The
> extra two parts [2/6] and [3/6] preprare the file for introducing
> tests.  However, I've not gone overboard in this preparation; I don't
> replicate the work done by Jonathan in [2].
>
> Thanks for reading.
>
> [1]: http://thread.gmane.org/gmane.comp.version-control.git/218410
> [2]: 
> http://thread.gmane.org/gmane.comp.version-control.git/218451/focus=218465
>
> Ramkumar Ramachandra (6):
>  remote.c: simplify a bit of code using git_config_string()
>  t5516 (fetch-push): update test description
>  t5516 (fetch-push): introduce mk_test_with_name()
>  remote.c: introduce a way to have different remotes for fetch/push
>  remote.c: introduce remote.pushdefault
>  remote.c: introduce branch.<name>.pushremote
>
> Documentation/config.txt | 23 +++++++++++++++---

Shouldn't Documentation/gitworkflows.txt also be updated with the 
triangular workflow and its configuration?

> builtin/push.c           |  2 +-
> remote.c                 | 36 +++++++++++++++++++++------
> remote.h                 |  1 +
> t/t5516-fetch-push.sh    | 63 
> ++++++++++++++++++++++++++++++++++++++++--------
> 5 files changed, 104 insertions(+), 21 deletions(-)
>
> -- 
> 1.8.2
>
