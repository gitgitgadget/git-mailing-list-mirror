From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: is this a bug of git-diff?
Date: Wed, 15 May 2013 08:43:40 +0200
Message-ID: <CALWbr2z338CJgavC9sVGffHSoqr0Sb9nCsr4LKURDYpkOog2TQ@mail.gmail.com>
References: <CABwUO_X8oTzuJh8+v3Oqca2W4ht-cQRNGQ+a1DbEruq5jY+vgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: eric liou <accwuya@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 15 08:43:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcVRI-0004cj-8A
	for gcvg-git-2@plane.gmane.org; Wed, 15 May 2013 08:43:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756564Ab3EOGnn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 May 2013 02:43:43 -0400
Received: from mail-qe0-f54.google.com ([209.85.128.54]:34338 "EHLO
	mail-qe0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756061Ab3EOGnl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 May 2013 02:43:41 -0400
Received: by mail-qe0-f54.google.com with SMTP id q19so1036790qeb.41
        for <git@vger.kernel.org>; Tue, 14 May 2013 23:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=h7giUFOpU4fRaqB7e8aizSFgQGD54QUm1GOiLFAqg+w=;
        b=dCynBW0XWh3oE+uUwxpNtfJD0DmnPkZuuWQAV+trSvi7AmLS2wGKeGfx1VJYHZuDRf
         Bkkw6h9dN3MBYZkt249JVknulxrpQSmQRR04joR+ijGPNDNbr5kiZ5xHKvyD0CASNK5R
         4iYOhjLginlUYR/R+RR1AdokyJLeoUajnwyNTyLhEfQnL9ryOusVcxDk8FCoudx/Wfbg
         ilw++vYFOdqeTNygfiSEW+aIha8jUykpPC0a+iG9EBuQ5+B3+q/LE8FYY5oq+PpvSo+A
         AXceMI6VVkXaZnbFF40Kn9qBlkoIUsAhcn7Q9NcO7qIMbGhuqRxgyQPFUSyvekBfu1ur
         I2dQ==
X-Received: by 10.224.187.67 with SMTP id cv3mr26582445qab.20.1368600220798;
 Tue, 14 May 2013 23:43:40 -0700 (PDT)
Received: by 10.49.81.99 with HTTP; Tue, 14 May 2013 23:43:40 -0700 (PDT)
In-Reply-To: <CABwUO_X8oTzuJh8+v3Oqca2W4ht-cQRNGQ+a1DbEruq5jY+vgA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224384>

On Wed, May 15, 2013 at 8:23 AM, eric liou <accwuya@gmail.com> wrote:
> The output of git-diff is different from my expectation.
> It may skip some lines of context.

git-diff is using a default of 3 lines of context above and below the changes.
In your example, there is only two lines of context below the change,
so only two lines are displayed.
Above the change, three lines are displayed, as expected. That's why
the blank line and leading slash line are not displayed.
You can change the number of context lines by invoking git-diff with -U<n>.

Hope that helps,
Antoine
