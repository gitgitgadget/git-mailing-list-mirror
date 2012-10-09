From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH] submodule: teach "foreach" command a --revision
 <tree-ish> option
Date: Tue, 9 Oct 2012 17:38:07 -0400
Message-ID: <CAG+J_DxeqPU=rLeJj0fR6Ojo7S=3fhStCo=xMXoO3CFYGMYZ3Q@mail.gmail.com>
References: <1349743810-10753-1-git-send-email-jaysoffian@gmail.com>
	<7v8vbgi3yz.fsf@alter.siamese.dyndns.org>
	<7v4nm4i37u.fsf@alter.siamese.dyndns.org>
	<CAG+J_Dw1iXJfgkmA2V-L11xCOOxO57U4Dh7=h7AzkFUqLc55=w@mail.gmail.com>
	<7vr4p7fqr2.fsf@alter.siamese.dyndns.org>
	<5074956E.3060909@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Oct 09 23:38:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLhVN-00007I-En
	for gcvg-git-2@plane.gmane.org; Tue, 09 Oct 2012 23:38:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756983Ab2JIViL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2012 17:38:11 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:54347 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756953Ab2JIViJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2012 17:38:09 -0400
Received: by mail-vc0-f174.google.com with SMTP id fo13so7490852vcb.19
        for <git@vger.kernel.org>; Tue, 09 Oct 2012 14:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=E1cbRB5n+BPWVA/cpS2kqyJKMUdWYFy4sYtnM6PruWE=;
        b=lp/E+Flsqul0kc+/EOIelBiVb9M3dwnnnJykUCAPebBcBVuyUzOxe0FiR6IgBPniwZ
         6x0zDAIVgnudfYoolgUVM53V4gWnR0/O2TSqwNWy92d29gJx7JjDl1vKnvUJyqDjPlwH
         iv3kW2O1I9gEh0lJlJs2V/riTBB3oavbnKa0a+xTMyxkXXWqgh6zG4Jg9VhC3GynB80h
         Zhr3I+i5mH/IYwo/DKEdztm7N9MadhWmrLWtmfPaJP+UY6rjBKvkOV3SlU5HoUQgFNMu
         BPHea/ZZdzZFUqDAYw1nWo/Ri++rGnOVgsTfEAUtT8jjblYHk1RxRKzbcFqjEDb4LC93
         BIzA==
Received: by 10.220.221.72 with SMTP id ib8mr12478803vcb.25.1349818687627;
 Tue, 09 Oct 2012 14:38:07 -0700 (PDT)
Received: by 10.58.29.169 with HTTP; Tue, 9 Oct 2012 14:38:07 -0700 (PDT)
In-Reply-To: <5074956E.3060909@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207350>

On Tue, Oct 9, 2012 at 5:21 PM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
> Nothing I can think of right now, the above is a pretty good summary.
> My gut feeling is that having "git submodule foreach --revision ..."
> recurse through submodules whose work trees are out of sync is pretty
> fragile and could easily lead to inconsistencies. So I tend to think
> adding a custom script to the release process Jay uses which does the
> tagging itself might be a better solution here. Opinions?

I agree now that this is a perilous option, and that its use case may
be so narrow that it may not worth adding. I am indeed already using a
custom script, and maybe I should leave it at that.

j.
