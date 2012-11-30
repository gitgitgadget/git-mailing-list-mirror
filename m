From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] cache-tree: invalidate i-t-a paths after writing trees
Date: Fri, 30 Nov 2012 08:26:30 +0700
Message-ID: <CACsJy8BQO4G0YXf87jS+sEpd6+RW+UVULDEt80yzTiiisWS2-A@mail.gmail.com>
References: <3E62F933-76CD-4578-8684-21444EAA454F@JonathonMah.com>
 <1352459040-14452-1-git-send-email-pclouds@gmail.com> <7vy5ibouo4.fsf@alter.siamese.dyndns.org>
 <CACsJy8DEwpg0gY1o6gSB747W5fAYYxz97e-qnkQthSut3B7Eag@mail.gmail.com> <7vhao8neck.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jonathon Mah <me@jonathonmah.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 30 02:27:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TeFNv-0003mw-9B
	for gcvg-git-2@plane.gmane.org; Fri, 30 Nov 2012 02:27:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755025Ab2K3B1D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2012 20:27:03 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:47813 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752859Ab2K3B1B (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2012 20:27:01 -0500
Received: by mail-ob0-f174.google.com with SMTP id wc20so13736831obb.19
        for <git@vger.kernel.org>; Thu, 29 Nov 2012 17:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=mXJ/Z0kZqiqeFgWxQq/A45SNUIH0GO7Jled6fKYo/oI=;
        b=Yw1fIXiy6q137McL7D+ETnHZg/1fBYP8ZXt4IXl0wrC7mP7B9cdw5d3nJuXkCOaJIj
         jsJk92NXRcPAXVnvZ8IXmCDOR9cW42d5BaeqiDrfj+6WJw1OzPp5Bih25048f6crYCe2
         6ABlG2tpjv/s1OqzJw/2NlWZI9Vl/Q8/zKlCPKgmUVQcdY2wfhVeXUkAfXxi360jVuhL
         GmfVebsApNh+H8+XY1Xk6JwqfkcYSgEXyfyDtbvj3jFl+HRpEgtgZ7f3wUgRXbm3P3vn
         kz53gYLrZObxArAIbFuRVOUh1bX6kGzkOfeJHaOvBtp5KOVKogOfuxQebNOfDw4ihrfA
         UsNw==
Received: by 10.60.24.7 with SMTP id q7mr3333532oef.108.1354238820999; Thu, 29
 Nov 2012 17:27:00 -0800 (PST)
Received: by 10.182.162.105 with HTTP; Thu, 29 Nov 2012 17:26:30 -0800 (PST)
In-Reply-To: <7vhao8neck.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210887>

On Fri, Nov 30, 2012 at 7:06 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>
>>> An alternative might be to add a "phoney" bit next to "used" in the
>>> cache_tree structure, mark the cache tree as phoney when we skip an
>>> entry marked as CE_REMOVE or CE_ITA, and make the postprocessing
>>> loop this patch adds aware of that bit, instead of iterating over
>>> the index entries; instead, it would recurse the resulting cache
>>> tree and invalidate parts of the tree that have subtrees with the
>>> "phoney" bit set, or something.
>>
>> Yeah, that sounds better.
>
> Did anything happen to this topic after this?

Not from my side because I forgot to mark this thread as a todo item
and unsurprisingly forgot about it.
-- 
Duy
