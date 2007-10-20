From: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
Subject: RE: [PATCH] Fix receive-pack error msg.
Date: Sat, 20 Oct 2007 19:44:49 +0200
Message-ID: <003701c81340$e9a44230$5267a8c0@Jocke>
References: <1192901822-20431-1-git-send-email-Joakim.Tjernlund@transmode.se>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 20 19:45:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjINm-0005bV-PM
	for gcvg-git-2@gmane.org; Sat, 20 Oct 2007 19:45:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757276AbXJTRo4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Oct 2007 13:44:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757052AbXJTRoz
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Oct 2007 13:44:55 -0400
Received: from mail.transmode.se ([83.241.175.147]:64086 "EHLO
	tmnt04.transmode.se" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754638AbXJTRoz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Oct 2007 13:44:55 -0400
Received: from Jocke ([84.217.95.61]) by tmnt04.transmode.se with Microsoft SMTPSVC(5.0.2195.6713);
	 Sat, 20 Oct 2007 19:44:53 +0200
X-Mailer: Microsoft Office Outlook 11
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.3198
In-Reply-To: <1192901822-20431-1-git-send-email-Joakim.Tjernlund@transmode.se>
Thread-Index: AcgTP9LEjZ737VtDQC6pheazKCxZAgAAOCEw
X-OriginalArrivalTime: 20 Oct 2007 17:44:53.0574 (UTC) FILETIME=[EBD8AE60:01C81340]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61844>

ehh, git sendmail didn't send the whole commit msg, just the subject.
Trying again.

> -----Original Message-----
> From: Joackim Tjernlund [mailto:jocke@gentoo-jocke] 
> Sent: den 20 oktober 2007 19:37
> To: git@vger.kernel.org
> Cc: Joakim Tjernlund
> Subject: [PATCH] Fix receive-pack error msg.
> 
> 
> Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
> ---
>  receive-pack.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/receive-pack.c b/receive-pack.c
> index d3c422b..1521d0b 100644
> --- a/receive-pack.c
> +++ b/receive-pack.c
> @@ -166,7 +166,7 @@ static const char *update(struct command *cmd)
>  	struct ref_lock *lock;
>  
>  	if (!prefixcmp(name, "refs/") && check_ref_format(name + 5)) {
> -		error("refusing to create funny ref '%s' 
> locally", name);
> +		error("refusing to create funny ref '%s' 
> remotely", name);
>  		return "funny refname";
>  	}
>  
> -- 
> 1.5.3.4
> 
> 
