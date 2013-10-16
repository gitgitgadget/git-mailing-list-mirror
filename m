From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH V3 1/2] doc: command line interface (cli) dot-repository dwimmery
Date: Wed, 16 Oct 2013 07:53:05 +0100
Organization: OPDS
Message-ID: <48EF6E550D1745E0BEC830BE5CB2E88F@PhilipOakley>
References: <1379776269-4496-1-git-send-email-philipoakley@iee.org><1379776269-4496-2-git-send-email-philipoakley@iee.org> <xmqqhacici3t.fsf@gitster.dls.corp.google.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "GitList" <git@vger.kernel.org>,
	"Jonathan Nieder" <jrnieder@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 16 08:53:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWKyu-0004V7-Qn
	for gcvg-git-2@plane.gmane.org; Wed, 16 Oct 2013 08:53:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753674Ab3JPGxR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Oct 2013 02:53:17 -0400
Received: from out1.ip03ir2.opaltelecom.net ([62.24.128.239]:24622 "EHLO
	out1.ip03ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753584Ab3JPGxG (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Oct 2013 02:53:06 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AmkGAOo2XlJOl3+a/2dsb2JhbABagweJcblECoEeF3RpgSEWAQQBAQUIAQEuHgEBIQsCAwUCAQMVAgolFAEEGgYHDwgGEwgCAQIDAYU4B4IXI74xj1GDJoEGA4kEhhKacIMlOw
X-IPAS-Result: AmkGAOo2XlJOl3+a/2dsb2JhbABagweJcblECoEeF3RpgSEWAQQBAQUIAQEuHgEBIQsCAwUCAQMVAgolFAEEGgYHDwgGEwgCAQIDAYU4B4IXI74xj1GDJoEGA4kEhhKacIMlOw
X-IronPort-AV: E=Sophos;i="4.93,505,1378854000"; 
   d="scan'208";a="439818301"
Received: from host-78-151-127-154.as13285.net (HELO PhilipOakley) ([78.151.127.154])
  by out1.ip03ir2.opaltelecom.net with SMTP; 16 Oct 2013 07:53:03 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236234>

From: "Junio C Hamano" <gitster@pobox.com>
> Philip Oakley <philipoakley@iee.org> writes:
>
>> The Git cli will accept dot '.' (period) as the relative path,
>> and thus the current repository. Explain this action.
>>
>> Signed-off-by: Philip Oakley <philipoakley@iee.org>
>> ---
>>
>> This updates 431260cc8dd
>
> It appears that the original has already been merged to 'next', so
> we need to make this incremental on top.  I'll queue this on top.

Thank you, that looks good.


>
> -- >8 --
> From: Philip Oakley <philipoakley@iee.org>
> Subject: doc/cli: make "dot repository" an independent bullet point
>
> The way to spell the current repository with a '.' dot is
> independent from how the pathspec allows globs expanded by Git.
>
> Make them two separate bullet items in the enumeration.
>
> Signed-off-by: Philip Oakley <philipoakley@iee.org>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> Documentation/gitcli.txt | 8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/gitcli.txt b/Documentation/gitcli.txt
> index 1672842..24e1784 100644
> --- a/Documentation/gitcli.txt
> +++ b/Documentation/gitcli.txt
> @@ -58,10 +58,10 @@ the paths in the index that match the pattern to 
> be checked out to your
> working tree.  After running `git add hello.c; rm hello.c`, you will 
> _not_
> see `hello.c` in your working tree with the former, but with the 
> latter
> you will.
> -+
> -Just as the filesystem '.' (period) refers to the current directory,
> -using a '.' as a repository name in Git (a dot-repository) is a 
> relative
> -path for your current repository.
> +
> + * Just as the filesystem '.' (period) refers to the current 
> directory,
> +   using a '.' as a repository name in Git (a dot-repository) is a 
> relative
> +   path and means your current repository.
>
> Here are the rules regarding the "flags" that you should follow when 
> you are
> scripting Git:
>
> --
