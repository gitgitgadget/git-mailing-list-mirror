From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH v3 07/11] Documentation/replace: tell that -f option bypasses the type check
Date: Sat, 31 Aug 2013 23:16:40 +0100
Organization: OPDS
Message-ID: <70F5C527E29F43A9BE85694F560E01A9@PhilipOakley>
References: <20130831190528.26699.33964.chriscool@tuxfamily.org> <20130831191215.26699.720.chriscool@tuxfamily.org>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, "Thomas Rast" <trast@inf.ethz.ch>,
	"Johannes Sixt" <j6t@kdbg.org>
To: "Christian Couder" <chriscool@tuxfamily.org>,
	"Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 01 00:15:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFtST-0005Yv-SE
	for gcvg-git-2@plane.gmane.org; Sun, 01 Sep 2013 00:15:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754390Ab3HaWPt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Aug 2013 18:15:49 -0400
Received: from out1.ip06ir2.opaltelecom.net ([62.24.128.242]:43456 "EHLO
	out1.ip06ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753181Ab3HaWPs (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 31 Aug 2013 18:15:48 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AmoMAD1qIlJOl3GZ/2dsb2JhbABagweJa7d9BAQBgR0XdGgBAYEfAQEUAQQBAQUIAQEuHgEBIQsCAwUCAQMOBwwlFAEEGgYHFwYBCQkIAgECAwGFOAcBghIjuWuONIFLgySBAAOIfYYSmkyBOimBPjuBLA
X-IPAS-Result: AmoMAD1qIlJOl3GZ/2dsb2JhbABagweJa7d9BAQBgR0XdGgBAYEfAQEUAQQBAQUIAQEuHgEBIQsCAwUCAQMOBwwlFAEEGgYHFwYBCQkIAgECAwGFOAcBghIjuWuONIFLgySBAAOIfYYSmkyBOimBPjuBLA
X-IronPort-AV: E=Sophos;i="4.89,999,1367967600"; 
   d="scan'208";a="587134648"
Received: from host-78-151-113-153.as13285.net (HELO PhilipOakley) ([78.151.113.153])
  by out1.ip06ir2.opaltelecom.net with SMTP; 31 Aug 2013 23:15:46 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233551>

From: "Christian Couder" <chriscool@tuxfamily.org>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
> Documentation/git-replace.txt | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-replace.txt 
> b/Documentation/git-replace.txt
> index 736b48c..a2bd2ee 100644
> --- a/Documentation/git-replace.txt
> +++ b/Documentation/git-replace.txt
> @@ -21,10 +21,12 @@ replaced. The content of the 'replace' reference 
> is the SHA-1 of the
> replacement object.
>
> The replaced object and the replacement object must be of the same 
> type.
> -There is no other restriction on them.
> +This restriction can be bypassed using `-f`.
>
> Unless `-f` is given, the 'replace' reference must not yet exist.
>
> +There is no other restriction on the replaced and replacement 
> objects.

Is this trying to allude to the fact that merge commits may be exchanged 
with non-merge commits? I strongly believe that this ability to exchange 
merge and non-merge commits should be stated _explicitly_ to counteract 
the false beliefs that are listed out on the internet.

It's probably better stated in a separate patch for that explicit 
purpose to avoid mixed messages within this commit.

> +
> Replacement references will be used by default by all Git commands
> except those doing reachability traversal (prune, pack transfer and
> fsck).
> -- 
