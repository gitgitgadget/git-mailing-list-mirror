From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: Merge seems to overwrite unstaged local changes
Date: Thu, 29 Sep 2011 15:07:13 +0200
Message-ID: <CAHGBnuNrhtyq1tfok3p9YHAVbfo9T7BO3ZOUy+8YvNE9Mmhjhg@mail.gmail.com>
References: <j5v9r7$fi1$1@dough.gmane.org>
	<7vaa9o1yf7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 29 15:07:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9GKh-0003yW-F4
	for gcvg-git-2@lo.gmane.org; Thu, 29 Sep 2011 15:07:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756401Ab1I2NHQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Sep 2011 09:07:16 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:55368 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756394Ab1I2NHO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Sep 2011 09:07:14 -0400
Received: by vcbfk10 with SMTP id fk10so390017vcb.19
        for <git@vger.kernel.org>; Thu, 29 Sep 2011 06:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=z5hmOB85lrRaOlkobfxyKtYrZ6ieEjhIBAk+oDcbZ9U=;
        b=ktTp3b8lgfrDjoT2flQ/dvT1k3lP5VDJIKEx/e+MFa8CdhHGDdpZqf9nwNJzoQwyt0
         csHlee33AkrdP5Hg6gGvIzvTmGMzpreOLofy3i8c89G49MzY5dD3cRD5dTyddT5B18H0
         WpQLpa6Sbi0FH5/5qqZU0bOFikLxyj97zw5F4=
Received: by 10.220.151.145 with SMTP id c17mr218190vcw.25.1317301633572; Thu,
 29 Sep 2011 06:07:13 -0700 (PDT)
Received: by 10.220.182.136 with HTTP; Thu, 29 Sep 2011 06:07:13 -0700 (PDT)
In-Reply-To: <7vaa9o1yf7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182395>

On Wed, Sep 28, 2011 at 17:25, Junio C Hamano <gitster@pobox.com> wrote:

>> ... I'm seeing this on Linux and Windows, with versions 1.7.4.3 and 1.7.6.
>
> There recently have been quite a change in merge-recursive implementation
> and it would be really nice if you can try this again with the tip of
> 'master' before 1.7.7 final ships.

The unstaged changes do not seem to get lost during the merge anymore
when using git version 1.7.7.rc3.4.g8d714 on Linux. I guess that
somewhat confirms that there's a bug in git < 1.7.7. I'll write a word
of warning to our in-house git users that they should always commit
before merging ...

-- 
Sebastian Schuberth
