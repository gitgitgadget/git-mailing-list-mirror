From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: How to create a branch without any links to the others branches
Date: Fri, 29 Aug 2008 11:27:02 +0200
Message-ID: <81b0412b0808290227g328b793cl58a606e718b4b3ff@mail.gmail.com>
References: <38b2ab8a0808290127o32621d09vac07e7811e6e8139@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Francis Moreau" <francis.moro@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 29 11:28:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZ0H6-0001vL-AQ
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 11:28:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753307AbYH2J1H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2008 05:27:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753327AbYH2J1G
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Aug 2008 05:27:06 -0400
Received: from wa-out-1112.google.com ([209.85.146.179]:20273 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753307AbYH2J1D (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2008 05:27:03 -0400
Received: by wa-out-1112.google.com with SMTP id j37so419113waf.23
        for <git@vger.kernel.org>; Fri, 29 Aug 2008 02:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=W4t6+fN9JFNrEitb2V/VzC4DfUk/hcQV/ijtIRmhI10=;
        b=TNe/1juW8ZUOn7bsIYIT0qcMm5U9usaTSvJ4Hzff8nT6V1tlqa6ruX0fTQe6Ae4eSO
         Zgf0EW7MA3mRjcyD6TRwDKNhxRcLcmHkze5Ciujy6utkBlZFkQM1QBr/2mGgRptsDEK0
         zU1iR0u8yaNqgjSbKDDyU4HGQrMmJ78k3XLmI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=uNxwb5eu8S2c6KlGIf73OAhOX3ggBUidFsoVw7kUdt3yCGa81nMBjiUTT1oqBIf4Y+
         zSPc1LKEV7JsZsPwejlcm0w5BptxV9AbX7s6uHOB/3QEwjWf5X2eEZ4p+3/q3saQYocM
         e9S80dy3KOdaJd9dp4u5o4BzbeIYQDx1e2YMU=
Received: by 10.114.209.1 with SMTP id h1mr2436376wag.36.1220002022804;
        Fri, 29 Aug 2008 02:27:02 -0700 (PDT)
Received: by 10.114.157.9 with HTTP; Fri, 29 Aug 2008 02:27:02 -0700 (PDT)
In-Reply-To: <38b2ab8a0808290127o32621d09vac07e7811e6e8139@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2008/8/29 Francis Moreau <francis.moro@gmail.com>:
>
> The only solution I'm seeing is to create a new repository with these
> 'unrelated' branches and pull them from the other repository.
>
> Is this correct ?
>

Almost:

$ rm .git/HEAD
$ echo ref: refs/heads/NEW-BRANCH-NAME > .git/HEAD
$ git commit
