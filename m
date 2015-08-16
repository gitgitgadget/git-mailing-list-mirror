From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH v3] po/README: Update directions for l10n contributors
Date: Sun, 16 Aug 2015 19:59:04 +0100
Organization: OPDS
Message-ID: <766F16CA94884DEBAEFC7A594DE64529@PhilipOakley>
References: <CANYiYbEKoF6GhezPmR1fGxRqTvZAE4L2xguvvwFEWqWBkOp9tw@mail.gmail.com> <30198223977cc51444ce3c3a61833fa9d7619dc7.1439704077.git.worldhello.net@gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Git List" <git@vger.kernel.org>,
	"Jiang Xin" <worldhello.net@gmail.com>
To: "Jiang Xin" <worldhello.net@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 16 20:58:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZR383-0002ar-Av
	for gcvg-git-2@plane.gmane.org; Sun, 16 Aug 2015 20:57:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752127AbbHPS5z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Aug 2015 14:57:55 -0400
Received: from out1.ip01ir2.opaltelecom.net ([62.24.128.237]:9378 "EHLO
	out1.ip01ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751021AbbHPS5y (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Aug 2015 14:57:54 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2CtFADF3NBVPKizYwJdGQEBgwBUaYc/uB+FcwQEAoEjTQEBAQEBAQcBAQEBQSQbhB4GAQEECAEBLh4BASELAgMFAgEDDgcMJRQBBAgSBgcDFAYBEggCAQIDAYgIAxYJv1SJCg2FVwELARsEi1KCT4I6gx+BFAWHIYV2iAYBgRKDcYV7gzeEK4wFd4NPg2eEJD0zgkwBAQE
X-IPAS-Result: A2CtFADF3NBVPKizYwJdGQEBgwBUaYc/uB+FcwQEAoEjTQEBAQEBAQcBAQEBQSQbhB4GAQEECAEBLh4BASELAgMFAgEDDgcMJRQBBAgSBgcDFAYBEggCAQIDAYgIAxYJv1SJCg2FVwELARsEi1KCT4I6gx+BFAWHIYV2iAYBgRKDcYV7gzeEK4wFd4NPg2eEJD0zgkwBAQE
X-IronPort-AV: E=Sophos;i="5.15,690,1432594800"; 
   d="scan'208";a="797284433"
Received: from host-2-99-179-168.as13285.net (HELO PhilipOakley) ([2.99.179.168])
  by out1.ip01ir2.opaltelecom.net with SMTP; 16 Aug 2015 19:57:50 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276022>

From: "Jiang Xin" <worldhello.net@gmail.com>
> From: Philip Oakley <philipoakley@iee.org>
>
> Some Linux distributions (such as Ubuntu) have their own l10n 
> workflows,
> and their translations may be different.  Add notes for this case for
> l10n translators.
>
> Signed-off-by: Philip Oakley <philipoakley@iee.org>
> Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
> ---
> po/README | 19 +++++++++++++++++++
> 1 file changed, 19 insertions(+)
>
> diff --git a/po/README b/po/README
> index d8c9111..fef4c0f 100644
> --- a/po/README
> +++ b/po/README
> @@ -10,10 +10,26 @@ coordinates our localization effort in the l10 
> coordinator repository:
>
>         https://github.com/git-l10n/git-po/
>
> +The two character language translation codes are defined by 
> ISO_639-1, as
> +stated in the gettext(1) full manual, appendix A.1, Usual Language 
> Codes.
> +
> +
> +Contributing to an existing translation
> +---------------------------------------
> As a contributor for a language XX, you should first check TEAMS file 
> in
> this directory to see whether a dedicated repository for your language 
> XX
> exists. Fork the dedicated repository and start to work if it exists.
>
> +Sometime, contributors may find that the translations of their Git
> +distributions are quite different with the translations of the
> +corresponding version from Git official. This is because some Git
> +distributions (such as from Ubuntu, etc.) have their own l10n 
> workflow.
> +For this case, wrong translations should be reported and fixed 
> through
> +their workflows.
> +

OK. That's a reasonable summary of what the reader should do.


> +
> +Creating a new language translation
> +-----------------------------------
> If you are the first contributor for the language XX, please fork this
> repository, prepare and/or update the translated message file po/XX.po
> (described later), and ask the l10n coordinator to pull your work.
> @@ -23,6 +39,9 @@ coordinate among yourselves and nominate the team 
> leader for your
> language, so that the l10n coordinator only needs to interact with one
> person per language.
>
> +
> +Translation Process Flow
> +------------------------
> The overall data-flow looks like this:
>
>     +-------------------+            +------------------+
> -- 

Confirmed-by: Philip Oakley <philipoakley@iee.org>
-- 
