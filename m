From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH v2] push: Enhance unspecified push default warning
Date: Thu, 3 Oct 2013 22:11:29 +0100
Organization: OPDS
Message-ID: <587B871F3486410EB43C42CB20930E6D@PhilipOakley>
References: <CAKYC+eJYgjZ1cZ2kA1v+nSN0ADA_ZPFgfYQ6_zR2PuYGBhi+3Q@mail.gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Matthieu Moy" <matthieu.moy@grenoble-inp.fr>,
	"Duy Nguyen" <pclouds@gmail.com>
To: "Greg Jacobson" <coder5000@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 03 23:11:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VRqBJ-0002Nr-E6
	for gcvg-git-2@plane.gmane.org; Thu, 03 Oct 2013 23:11:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755692Ab3JCVLX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Oct 2013 17:11:23 -0400
Received: from out1.ip05ir2.opaltelecom.net ([62.24.128.241]:57773 "EHLO
	out1.ip05ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755683Ab3JCVLV (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Oct 2013 17:11:21 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AokGAC3dTVJOl3GZ/2dsb2JhbABZgweJcLhWCoEbF3RpgSEWAQQBAQUIAQEuHgEBIQsCAwUCAQMOBwwlFAEECBIGBxcGARIIAgECAwGFOAeCFw0DE7JiDYlrjGaCa4MmgQQDiQGGE4cEjjKFNoE6gWs7
X-IPAS-Result: AokGAC3dTVJOl3GZ/2dsb2JhbABZgweJcLhWCoEbF3RpgSEWAQQBAQUIAQEuHgEBIQsCAwUCAQMOBwwlFAEECBIGBxcGARIIAgECAwGFOAeCFw0DE7JiDYlrjGaCa4MmgQQDiQGGE4cEjjKFNoE6gWs7
X-IronPort-AV: E=Sophos;i="4.90,1028,1371078000"; 
   d="scan'208";a="433561824"
Received: from host-78-151-113-153.as13285.net (HELO PhilipOakley) ([78.151.113.153])
  by out1.ip05ir2.opaltelecom.net with SMTP; 03 Oct 2013 22:11:19 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235695>

From: "Greg Jacobson" <coder5000@gmail.com>
> When the unset push.default warning message is displayed
> this may be the first time many users encounter push.default.
> Modified the warning message to explain in a compact
> manner what push.default is and why it is being changed in
> Git 2.0.  Also provided additional information to help users
> decide if this change will affect their workflow.
>
> Signed-off-by: Greg Jacobson <coder5000@gmail.com>
> ---
> builtin/push.c | 9 +++++++++
> 1 file changed, 9 insertions(+)
>
> diff --git a/builtin/push.c b/builtin/push.c
> index 7b1b66c..eb7a721 100644
> --- a/builtin/push.c
> +++ b/builtin/push.c
> @@ -174,6 +174,15 @@ N_("push.default is unset; its implicit value is
> changing in\n"
>    "\n"
>    "  git config --global push.default simple\n"
>    "\n"

Should 'matching' and 'simple' be quoted below for additional clarity?

> +   "When push.default is set to matching git will push all local 
> branches\n"
"When push.default is set to 'matching', git will push all local 
branches\n"

> +   "to the remote branches with the same (matching) name.  This will 
> no\n"
> +   "longer be the default in Git 2.0 because a branch could be\n"
> +   "unintentionally pushed to a remote.\n"
> +   "\n"
> +   "In Git 2.0 the new push.default of simple will push only the 
> current\n"
"In Git 2.0 the new push.default of 'simple' will push only the 
current\n"

> +   "branch to the same remote branch used by git pull.   A push 
> will\n"
> +   "only succeed if the remote and local branches have the same 
> name.\n"
> +   "\n"
>    "See 'git help config' and search for 'push.default' for further
> information.\n"
>    "(the 'simple' mode was introduced in Git 1.7.11. Use the similar 
> mode\n"
>    "'current' instead of 'simple' if you sometimes use older versions
> of Git)");
> -- 
Philip 
