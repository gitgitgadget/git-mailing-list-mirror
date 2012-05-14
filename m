From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH] link to gitmodules page at the beginning of git-submoduledocumentation
Date: Mon, 14 May 2012 20:36:54 +0100
Organization: OPDS
Message-ID: <82C8AAD86136458991DBC282E95C7AB1@PhilipOakley>
References: <20120510185903.GF76400@book.hvoigt.net> <A406C457BFB948FC9843C8F53AD82CDE@PhilipOakley> <20120514173207.GC58058@book.hvoigt.net>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, <git@vger.kernel.org>
To: "Heiko Voigt" <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Mon May 14 21:37:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SU154-00085a-EN
	for gcvg-git-2@plane.gmane.org; Mon, 14 May 2012 21:37:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757648Ab2ENThI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 May 2012 15:37:08 -0400
Received: from out1.ip02ir2.opaltelecom.net ([62.24.128.238]:41182 "EHLO
	out1.ip02ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757613Ab2ENThH (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 May 2012 15:37:07 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AgsLAI1esU9cHlGK/2dsb2JhbABEi0GnEgKBHYEIghABBAEBBAEIAQEuHgEBIQsCAwUCAQMOBwECCSUUAQQaBgcXBhMIAgECAwGFOAcBgicRCbpdixqBEIQNYwSIMIVKmEOCag
X-IronPort-AV: E=Sophos;i="4.75,588,1330905600"; 
   d="scan'208";a="393113182"
Received: from host-92-30-81-138.as13285.net (HELO PhilipOakley) ([92.30.81.138])
  by out1.ip02ir2.opaltelecom.net with SMTP; 14 May 2012 20:37:04 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197803>

From: "Heiko Voigt" <hvoigt@hvoigt.net> Sent: Monday, May 14, 2012 6:32 PM
> This way the user does not have to scroll down to the bottom to find
> it.
>
> Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
> ---
> On Thu, May 10, 2012 at 09:30:12PM +0100, Philip Oakley wrote:
>> From: "Heiko Voigt" <hvoigt@hvoigt.net> Sent: Thursday, May 10, 2012 7:59 PM
>>> This option was not yet described in the gitmodules documentation. We
>>> only described it in the 'git submodule' command documentation but
>>> gitmodules is the more natural place to look.
>>
>> The gitmodules documentation is only more natural if we tell (link) the
>> reader early in the submodule documentation. A link to gitmodules should
>> be provided in the third paragraph of Description where the .gitmodules
>> is introduced.
>>
>> Currently the gitmodules link is the last thing mentioned (i.e. 8 PgDn's for me).
>
> The gitmodules documentation page describes all the options you can use
> there so its by definition more natural. Yes I can see that a link to
> gitmodules page could be provided earlier but thats a completely
> different topic independent from my previous patch. Instead of
> complaining how about providing a patch next time?

My apologies, I was thinking I was avoiding a clash of patches on a common file, rather than seeing the independance you noted. 
Thank you for the patch.

>
> Anyway here we go...
>
> Documentation/git-submodule.txt | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
> index c83a856..9e488c0 100644
> --- a/Documentation/git-submodule.txt
> +++ b/Documentation/git-submodule.txt
> @@ -43,9 +43,9 @@ if you choose to go that route.
> Submodules are composed from a so-called `gitlink` tree entry
> in the main repository that refers to a particular commit object
> within the inner repository that is completely separate.
> -A record in the `.gitmodules` file at the root of the source
> -tree assigns a logical name to the submodule and describes
> -the default URL the submodule shall be cloned from.
> +A record in the `.gitmodules` (see linkgit:gitmodules[5]) file at the
> +root of the source tree assigns a logical name to the submodule and
> +describes the default URL the submodule shall be cloned from.
> The logical name can be used for overriding this URL within your
> local repository configuration (see 'submodule init').
>
> -- 
> 1.7.10.1.488.ga84c0c8
>
>
>
> -----
