From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH] help.c: add a compatibility comment to cmd_version()
Date: Tue, 16 Apr 2013 22:59:56 +0100
Organization: OPDS
Message-ID: <3D6BDB8830FC44A38B1AC508488049C0@PhilipOakley>
References: <1366144405-61438-1-git-send-email-davvid@gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "David Aguilar" <davvid@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 16 23:59:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USDuo-0003fn-JK
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 23:59:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965417Ab3DPV7q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Apr 2013 17:59:46 -0400
Received: from out1.ip04ir2.opaltelecom.net ([62.24.128.240]:10475 "EHLO
	out1.ip04ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965386Ab3DPV7p (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Apr 2013 17:59:45 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AsMNAN7IbVFOl3gj/2dsb2JhbAAuIoMGNohwuA8EAQMBgQoXdIIaBQEBBQgBAS4RBQgBASELAgMFAgEDDgYBAQslFAEECBACBgcXBgEHCwgCAQIDAQwEh2EDEwisRIZHDYldjEiBaWqCa2EDiE6FdIZhgwaIWIF9hRyDDDs
X-IronPort-AV: E=Sophos;i="4.87,487,1363132800"; 
   d="scan'208";a="406781361"
Received: from host-78-151-120-35.as13285.net (HELO PhilipOakley) ([78.151.120.35])
  by out1.ip04ir2.opaltelecom.net with SMTP; 16 Apr 2013 22:59:43 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221480>

From: "David Aguilar" <davvid@gmail.com>
Sent: Tuesday, April 16, 2013 9:33 PM
> External projects have been known to parse the output of
> "git version".  Help prevent future authors from changing
> its format by adding a comment to its implementation.
>
> Signed-off-by: David Aguilar <davvid@gmail.com>
> ---
> help.c | 4 ++++
> 1 file changed, 4 insertions(+)
>
> diff --git a/help.c b/help.c
> index 1dfa0b0..02ba043 100644
> --- a/help.c
> +++ b/help.c
> @@ -397,6 +397,10 @@ const char *help_unknown_cmd(const char *cmd)
>
> int cmd_version(int argc, const char **argv, const char *prefix)
> {
> + /*
> + * The format of this string should be kept stable for compatibility
> + * with external projects that rely on the output of "git version".

Shouldn't the expected format of our known external project also be 
indicated?
Or mention "such as git gui"?

> + */
>  printf("git version %s\n", git_version_string);
>  return 0;
> }
> -- 
> 1.8.2.1.652.ge104b5e
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
> Version: 2013.0.3272 / Virus Database: 3162/6248 - Release Date: 
> 04/16/13
> 
