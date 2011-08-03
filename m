From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH] git-am: ignore leading whitespace before patch
Date: Wed, 3 Aug 2011 21:31:46 +0800
Message-ID: <CALUzUxrubhFpLd00BomM5WwPYNwPbxCx6q7U2TG4PssaQODkZQ@mail.gmail.com>
References: <1312323646-93427-1-git-send-email-davidbarr@google.com>
	<CALUzUxpn-vCWpTQyB7z9dsu8a+UBL9MPjEycOfTmyws5ndz5kA@mail.gmail.com>
	<CAGdFq_it-QAA5uSme6S715dRzHs-s-Uj=MWKzBK2MOaaSdiXtg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: David Barr <davidbarr@google.com>,
	Git Mailing List <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 03 15:32:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QobYI-0005Vx-A4
	for gcvg-git-2@lo.gmane.org; Wed, 03 Aug 2011 15:32:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753665Ab1HCNbw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Aug 2011 09:31:52 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:38525 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754495Ab1HCNbs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2011 09:31:48 -0400
Received: by fxh19 with SMTP id 19so670025fxh.19
        for <git@vger.kernel.org>; Wed, 03 Aug 2011 06:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=SfqRFrgf2jDbf/+LR0kgp+x7Xo/vnq8rweYgK/WVz0M=;
        b=GoKvXrGyn+wLdB59o61RSrXXkY4FWhZxeSAuw0QhFJDqPmhsPO9zwsf4pGmjWZZHDo
         m7G/NThTG03zRAVzoqhlrDi4oVye2NUXXgPurAy8HZ5NK+kjZRgJ8koYxRELixbt3SH1
         fwVx9q9EgcczQUzWxO2x5KslCGCeVQ8cRmk0M=
Received: by 10.223.9.217 with SMTP id m25mr2248577fam.122.1312378306728; Wed,
 03 Aug 2011 06:31:46 -0700 (PDT)
Received: by 10.223.87.66 with HTTP; Wed, 3 Aug 2011 06:31:46 -0700 (PDT)
In-Reply-To: <CAGdFq_it-QAA5uSme6S715dRzHs-s-Uj=MWKzBK2MOaaSdiXtg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178570>

On Wed, Aug 3, 2011 at 9:21 PM, Sverre Rabbelier <srabbelier@gmail.com> wrote:
> So how do you get the patches out of gmail? Do you just copy/paste the
> output of the "Show original" page?

I Ctrl-S from the "Show original" page. Using Chrome, that yields a
mail.txt file.

Without this patch, I used to manually remove the first line (all
empty whitespace).

-- 
Cheers,
Ray Chuan
