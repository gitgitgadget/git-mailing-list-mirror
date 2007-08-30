From: "Tom Clarke" <tom@u2i.com>
Subject: Re: Add --rebase option to git-pull?
Date: Thu, 30 Aug 2007 15:17:46 +0200
Message-ID: <550f9510708300617y69352a67r818000273c25ce11@mail.gmail.com>
References: <550f9510708300540u13c77201oe7cbe599c6773364@mail.gmail.com>
	 <46D6C12A.5090705@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Andreas Ericsson" <ae@op5.se>
X-From: git-owner@vger.kernel.org Thu Aug 30 15:17:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQjuF-0006Bz-VK
	for gcvg-git@gmane.org; Thu, 30 Aug 2007 15:17:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758298AbXH3NRw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Aug 2007 09:17:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758280AbXH3NRv
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Aug 2007 09:17:51 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:55666 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756603AbXH3NRv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2007 09:17:51 -0400
Received: by py-out-1112.google.com with SMTP id u77so2859615pyb
        for <git@vger.kernel.org>; Thu, 30 Aug 2007 06:17:50 -0700 (PDT)
Received: by 10.35.10.13 with SMTP id n13mr625118pyi.1188479866729;
        Thu, 30 Aug 2007 06:17:46 -0700 (PDT)
Received: by 10.35.86.2 with HTTP; Thu, 30 Aug 2007 06:17:46 -0700 (PDT)
In-Reply-To: <46D6C12A.5090705@op5.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57041>

On 8/30/07, Andreas Ericsson <ae@op5.se> wrote:
> If I read the patch correctly (which I may not, ofcourse), you're
> rebasing the upstream changes to on top of your own work. That's
> not something you can readily do, since the parentage chain in
> git is supposed to be immutable, so mutating the one you get from
> an already published source would be a horribly bad idea indeed.

It's intended to (and appears to) rebase on top of $merge_head, which
would typically be something like origin/master or
origin/topics/my_topic or something. I just noticed I don't need the
$strategy_args which might be confusing.

> If that's what the patch does, then I guess all is fine and dandy,
> although I think it'd be better to add the merge-strategy rebase
> or possibly rebase-ours or rebase-theirs, which can be given as
> arguments to git-pull.

Ok, makes sense.

-Tom
