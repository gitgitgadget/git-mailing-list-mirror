From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH] show-ref: place angle brackets around variables in usage string
Date: Sat, 29 Aug 2015 11:21:14 +0100
Organization: OPDS
Message-ID: <47B9DE8756F943C0A0985F41D093340F@PhilipOakley>
References: <1440821924-4289-1-git-send-email-alexhenrie24@gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Alex Henrie" <alexhenrie24@gmail.com>
To: "Alex Henrie" <alexhenrie24@gmail.com>, <git@vger.kernel.org>,
	<pclouds@gmail.com>, <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 29 12:21:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZVdGA-0003o9-Vz
	for gcvg-git-2@plane.gmane.org; Sat, 29 Aug 2015 12:21:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752570AbbH2KVO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Aug 2015 06:21:14 -0400
Received: from out1.ip06ir2.opaltelecom.net ([62.24.128.242]:29238 "EHLO
	out1.ip06ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752135AbbH2KVN (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 29 Aug 2015 06:21:13 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2B6DwBzhuFVPOgXFlxdGQEBgwCBPYZRbb48BAQCgSpNAQEBAQEBBwEBAQFBJBtBBYNYBQEBAQECAQgBAS4eAQEUDQUGAgMFAgEDFQwlFAEECBIGBwMUBgESCAIBAgMBiAgDCgy2MIhcDYVRhnCDdoEFgk+BV2WDH4EUBY0oiBkBgROJcpUbhzyCNB2BVT0zgQWBSAEBAQ
X-IPAS-Result: A2B6DwBzhuFVPOgXFlxdGQEBgwCBPYZRbb48BAQCgSpNAQEBAQEBBwEBAQFBJBtBBYNYBQEBAQECAQgBAS4eAQEUDQUGAgMFAgEDFQwlFAEECBIGBwMUBgESCAIBAgMBiAgDCgy2MIhcDYVRhnCDdoEFgk+BV2WDH4EUBY0oiBkBgROJcpUbhzyCNB2BVT0zgQWBSAEBAQ
X-IronPort-AV: E=Sophos;i="5.17,429,1437433200"; 
   d="scan'208";a="689037166"
Received: from host-92-22-23-232.as13285.net (HELO PhilipOakley) ([92.22.23.232])
  by out1.ip06ir2.opaltelecom.net with SMTP; 29 Aug 2015 11:21:12 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276774>

From: "Alex Henrie" <alexhenrie24@gmail.com>
> Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
> ---
> builtin/show-ref.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/show-ref.c b/builtin/show-ref.c
> index dfbc314..131ef28 100644
> --- a/builtin/show-ref.c
> +++ b/builtin/show-ref.c
> @@ -8,7 +8,7 @@
>
> static const char * const show_ref_usage[] = {
>  N_("git show-ref [-q | --quiet] [--verify] [--head] [-d 
> | --dereference] [-s | --hash[=<n>]] [--abbrev[=<n>]] [--tags] 
> [--heads] [--] [<pattern>...]"),
> - N_("git show-ref --exclude-existing[=pattern] < ref-list"),
> + N_("git show-ref --exclude-existing[=<pattern>] < <ref-list>"),

Should the '<' stdin redirection be shown?

It looks (at first glance) as if this gained a double '< <' at the 
beginning of 'ref-list', rather than being a clean indication of the 
redirection. Perhaps change 'ref-list' to 'ref-list-file' for a slight 
improvement in clarity - this it's only occurance, and the redirection 
would best match a file.


>  NULL
> };
>
> -- 
> 2.5.0
>
--
Philip
(will be offline for 4 days) 
