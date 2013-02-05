From: Jakub Suder <jakub.suder@gmail.com>
Subject: Re: Assorted contrib/subtree Patches
Date: Tue, 5 Feb 2013 10:14:26 +0100
Message-ID: <CAAgkN4dx7jyjh=4BTWT6L4H1ymjwWNxSZk7WqyV1_CCYocy6Pg@mail.gmail.com>
References: <1360037173-23291-1-git-send-email-greened@obbligato.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: James Nylen <jnylen@gmail.com>, git@vger.kernel.org,
	Techlive Zheng <techlivezheng@gmail.com>,
	Wayne Walter <wayne@tickzoom.com>,
	"Avery Pennarun \"" <apenwarr@gmail.com>,
	John Yani <vanuan@gmail.com>
To: "David A. Greene" <greened@obbligato.org>
X-From: git-owner@vger.kernel.org Tue Feb 05 10:15:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2ecQ-0000N6-Kl
	for gcvg-git-2@plane.gmane.org; Tue, 05 Feb 2013 10:15:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754446Ab3BEJOq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2013 04:14:46 -0500
Received: from mail-oa0-f43.google.com ([209.85.219.43]:44725 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753929Ab3BEJO1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2013 04:14:27 -0500
Received: by mail-oa0-f43.google.com with SMTP id l10so7612185oag.16
        for <git@vger.kernel.org>; Tue, 05 Feb 2013 01:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=/djUXgzaPophX0vGmaANYlusnBL+1pmb8aWOOqTvmTY=;
        b=G1VLo/nDklTX8CPFgEaVIPHz0ll+ev9fQQiiHFFg8ipVDSwsLnEJRXwIXfbbqPyFFK
         djSj9HQIXdBggXN/yQZ9T/VtbFcNFwBHCma2wyysTvvVe1fL5JP9/A9f609fXcNE3HJq
         ybCItZM0RmQ2eLJdjmHxacf9kX9ziBi3IHY5ocdV5oIVAGzBButne8HlU/V+ZSkjFlVF
         gISnfRG9kC5s8w7MyC2IFieszqZ5uRZTkYgDSpiHjPX/xISuZx14XZcgPwcUm9tSh21T
         fA6am+CF7XnbwkXSeTrND+xr7orsdWU0mtKPyJINhxWr7e0IObb9qpN2QYIdvvY6Xm9R
         OIfg==
X-Received: by 10.182.40.69 with SMTP id v5mr14544903obk.57.1360055666862;
 Tue, 05 Feb 2013 01:14:26 -0800 (PST)
Received: by 10.76.167.161 with HTTP; Tue, 5 Feb 2013 01:14:26 -0800 (PST)
In-Reply-To: <1360037173-23291-1-git-send-email-greened@obbligato.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215471>

Can I please unsubscribe from this thing?...

Thanks.

Jakub Suder

On 5 February 2013 05:06, David A. Greene <greened@obbligato.org> wrote:
> All of the patches I have received from others as well as a few of my
> own follow.  Probably the most controversial is a patch to remove
> --annotate.  After some discussion on the list it became clear that we
> really want a more general commit rewrite feature.  Removing
> --annotate means we don't have to also support --unannotate and carry
> both forward as backward-compatibility baggage.
>
> Before --annotate was added, git-subtree would force an annotation of
> "*" on every split commit message.  It now does no such thing so
> there's no need to unannotate anything.
>
> Please review and integrate.  Thanks!
>
>                         -David
>
