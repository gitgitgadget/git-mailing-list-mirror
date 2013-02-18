From: Drew Northup <n1xim.email@gmail.com>
Subject: Re: [PATCH v2 02/15] user-manual: Update for receive.denyCurrentBranch=refuse
Date: Mon, 18 Feb 2013 08:00:59 -0500
Message-ID: <CAM9Z-nm1WbJ0ZCVGuSuuC8kJADXUD3e-tjB51kAEerSfFxVVLQ@mail.gmail.com>
References: <7vzjzexv8l.fsf@alter.siamese.dyndns.org>
	<cover.1360508415.git.wking@tremily.us>
	<ba62167be6df7a6ba666373913bfd235bcc29c9d.1360508415.git.wking@tremily.us>
	<7vd2w7uajk.fsf@alter.siamese.dyndns.org>
	<20130210214621.GA8000@odin.tremily.us>
	<7v1ucnssnw.fsf@alter.siamese.dyndns.org>
	<7v4nhezpta.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "W. Trevor King" <wking@tremily.us>, Git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 14:01:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7QLX-0005uW-28
	for gcvg-git-2@plane.gmane.org; Mon, 18 Feb 2013 14:01:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752974Ab3BRNBB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2013 08:01:01 -0500
Received: from mail-ie0-f177.google.com ([209.85.223.177]:45849 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752139Ab3BRNBA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2013 08:01:00 -0500
Received: by mail-ie0-f177.google.com with SMTP id 16so6896239iea.8
        for <git@vger.kernel.org>; Mon, 18 Feb 2013 05:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=RB+ddz1kCHBoboc1R8K7TBUmtxMod86xaATzBczE5uM=;
        b=EKxSBffCEdUUAlJR3lWm5hLypRdVHYTbYc7AtA8h02nfbvq7oIaMxCbB6WEksYbgMk
         Cc7FZEMTr6D3zvyDIdt9Bm04n97lVrglu7tY7TXxSUK4VPqGZZhDNdCp9vVAbCVkJ3SC
         O7l9GaSNyt3KWBNUwi/3ocTEWsYx+a87nKtVK1C9Zd/1oH/InOhsAXq4YZHailpBAIMe
         18xzZVLzLODUITRGD4Gz9olgzvedMse6NbvfFZBeOMBGPO3KD6tVyZYpycUypoFaZQoD
         sVAC9nGWSsGwV124Bye5jaw8BeEcmmAEr7tvjU8g84qt6n1ZEaHl8N+VLvR4V5Rbvtdx
         dDDw==
X-Received: by 10.50.190.138 with SMTP id gq10mr6734419igc.38.1361192459384;
 Mon, 18 Feb 2013 05:00:59 -0800 (PST)
Received: by 10.42.173.70 with HTTP; Mon, 18 Feb 2013 05:00:59 -0800 (PST)
In-Reply-To: <7v4nhezpta.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216481>

On Thu, Feb 14, 2013 at 1:57 PM, Junio C Hamano <gitster@pobox.com> wrote:

> I did not think the detailed discussion belongs there in the first
> place, so I re-read the context.  I think the only thing the reader
> of the user manual needs to learn at that point of the flow is that
> they can push to a non-bare but cannot push to update the currently
> checked out branch by default.  So let's tone everything down and do
> this instead:

> diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
> index 85651b5..7c534dc 100644
> --- a/Documentation/user-manual.txt
> +++ b/Documentation/user-manual.txt
> @@ -1986,9 +1986,10 @@ handling this case.
>
>  Note that the target of a "push" is normally a
>  <<def_bare_repository,bare>> repository.  You can also push to a
> -repository that has a checked-out working tree, but the working tree
> -will not be updated by the push.  This may lead to unexpected results if
> -the branch you push to is the currently checked-out branch!
> +repository that has a checked-out working tree, but a push to update the
> +currently checked-out branch is denied by default to prevent confusion.
> +See the description ofthe receive.denyCurrentBranch option
> +in linkgit:git-config[1] for details.

This looks safe to me, with the minor nit that "ofthe" ("of the")
isn't one word.

-- 
-Drew Northup
--------------------------------------------------------------
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
