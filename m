From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Git help for kernel archeology, suppress diffs caused by CVS keyword expansion
Date: Mon, 23 Jul 2007 21:06:12 -0400
Message-ID: <9e4733910707231806r40d9d427t25853ac65ac756f4@mail.gmail.com>
References: <9e4733910707221148g69d7600bk632abb7452ce9c7c@mail.gmail.com>
	 <9e4733910707221248q45fb3aaala9c79afd4b09830e@mail.gmail.com>
	 <Pine.LNX.4.64.0707222238180.14781@racer.site>
	 <9e4733910707221645x21d74e70y3c43bc8c02a9d4ca@mail.gmail.com>
	 <Pine.LNX.4.64.0707230048570.14781@racer.site>
	 <9e4733910707221711u6e965e6cr29e06fa8fb09165@mail.gmail.com>
	 <Pine.LNX.4.64.0707230136360.14781@racer.site>
	 <9e4733910707230744u2d3a0a31t9f65d5c9e68c9805@mail.gmail.com>
	 <Pine.LNX.4.64.0707231933030.14781@racer.site>
	 <9e4733910707231743w759afabfvd43045ad2e2eba5a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 24 03:06:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ID8qw-0005br-FC
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 03:06:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759051AbXGXBGO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jul 2007 21:06:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758955AbXGXBGO
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 21:06:14 -0400
Received: from wa-out-1112.google.com ([209.85.146.181]:33445 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758198AbXGXBGN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2007 21:06:13 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2214620wah
        for <git@vger.kernel.org>; Mon, 23 Jul 2007 18:06:13 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jmjtexoNVKmwxjUvAFqKURB5rQJQC93BkbCeT9oUSQGeTC3BbULaLJCcXJbil/7z6AtnURcSO7uXXMhjhiskNScHeZnFEQbqx/QVz7w16qYb2uxqxJxmn/bTEbwWuBZt57YDieQjg6c7gV+NxL5dBu7Qhi8mLWSzsj3ZS3o+RdA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ABUwmKUGgMG3mdP2QF8WnAFVZ0BTQjiP7N8AUgZqlM3KsE4BTefkbXDdfv0EEzhJ3BnlXrIDY1D8SZqf5TfRB96CWmR779Mhlucg6VqCOoTGQ6KlrvFAGX04q2ymTsXOobQAKOEi9H3mjVDo+wIB1yamRK5bI7AJrs/wAB850vU=
Received: by 10.114.133.1 with SMTP id g1mr3535792wad.1185239172293;
        Mon, 23 Jul 2007 18:06:12 -0700 (PDT)
Received: by 10.114.195.5 with HTTP; Mon, 23 Jul 2007 18:06:12 -0700 (PDT)
In-Reply-To: <9e4733910707231743w759afabfvd43045ad2e2eba5a@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53517>

On 7/23/07, Jon Smirl <jonsmirl@gmail.com> wrote:
> Thanks for working on this. I'd like to see it added to git toolkit.
> This diff is way easier to read now. I can see that it has SPI support
> backported from some future version.
>
> But... it still has some problems.
> For the phytec patch it's not getting the $Log changes in the qlogic
> files right.
>
> I'm checking the output diff line by line for problems. It's down to
> 11,528 lines from 88,787. That's a lot of junk removed, I'll have to
> make sure it isn't removing too much.

I forgot about newly added files, looks like only 20,000 lines of CVS noise.

The phytec patch has several ia64 files added to it, those are obvious
not part of the support and an ARM9 processor. Never noticed those
before.


>
> --
> Jon Smirl
> jonsmirl@gmail.com
>


-- 
Jon Smirl
jonsmirl@gmail.com
