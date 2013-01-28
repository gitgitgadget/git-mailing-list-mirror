From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH v2 0/4] Auto-generate mergetool lists
Date: Mon, 28 Jan 2013 08:20:32 -0000
Organization: OPDS
Message-ID: <5F78436DB1994B6DA686EC1BFA96B54E@PhilipOakley>
References: <1359334346-5879-1-git-send-email-davvid@gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, "John Keeping" <john@keeping.me.uk>
To: "David Aguilar" <davvid@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 28 09:21:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tzjxa-00025C-8j
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 09:20:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753971Ab3A1IUb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2013 03:20:31 -0500
Received: from out1.ip06ir2.opaltelecom.net ([62.24.128.242]:41719 "EHLO
	out1.ip06ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753823Ab3A1IUa (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Jan 2013 03:20:30 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AhcKAB40BlFcHKXV/2dsb2JhbABFjAOxWQN/F3OCGQUBAQQBCAEBLhEFCAEBIQsCAwUCAQMOBgEBCyUUAQQIEAIGBwkBDQYBBwsIAgECAwEMBIdeAwkKCLUgDYlVjBCBH4MVYQOILIVShjmCcooahRKCdw
X-IronPort-AV: E=Sophos;i="4.84,550,1355097600"; 
   d="scan'208";a="564098408"
Received: from host-92-28-165-213.as13285.net (HELO PhilipOakley) ([92.28.165.213])
  by out1.ip06ir2.opaltelecom.net with SMTP; 28 Jan 2013 08:20:27 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214819>

From: "David Aguilar" <davvid@gmail.com>
Sent: Monday, January 28, 2013 12:52 AM
> This is round two of this series.
> I think this touched on everything brought up in the code review.
> 4/4 could use a review as I'm not completely familiar with the
> makefile dependencies, though it seems to work correctly.

Does this 4/4 have any effect on the Msysgit / Git for Windows 
documentation which simply refers [IIRC] to HTML documenation made by 
Junio?

That is, how easy is it to create a 'default' set of docs, rather than 
personalised documenation. Or have I misunderstood how it is working?

>
> David Aguilar (4):
>  mergetool--lib: Simplify command expressions
>  mergetool--lib: Improve the help text in guess_merge_tool()
>  mergetool--lib: Add functions for finding available tools
>  doc: Generate a list of valid merge tools
>
> Documentation/.gitignore       |   1 +
> Documentation/Makefile         |  22 +++++++-
> Documentation/diff-config.txt  |  13 ++---
> Documentation/merge-config.txt |  12 ++---
> git-mergetool--lib.sh          | 116 
> ++++++++++++++++++++++-------------------
> 5 files changed, 96 insertions(+), 68 deletions(-)
>
> -- 
> 1.8.0.13.g3ff16bb
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
> -----
> No virus found in this message.
> Checked by AVG - www.avg.com
> Version: 2013.0.2890 / Virus Database: 2639/6061 - Release Date: 
> 01/27/13
> 
