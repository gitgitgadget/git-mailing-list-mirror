From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 4/8] t5800: document some non-functional parts of remote helpers
Date: Tue, 7 Jun 2011 19:53:01 +0200
Message-ID: <BANLkTimWZ03FWaZ=Oit2gWSOeUF66cbEkA@mail.gmail.com>
References: <20110607171838.GA21685@sigill.intra.peff.net> <20110607172030.GC22111@sigill.intra.peff.net>
 <BANLkTinx0F7nfpmqx7AWChab3g-4MNnswQ@mail.gmail.com> <20110607172832.GA23224@sigill.intra.peff.net>
 <BANLkTimAngV2BxODJ6gCn4zGh7+p+MnhZQ@mail.gmail.com> <20110607175110.GB22216@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Dmitry Ivankov <divanorama@gmail.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 07 19:53:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QU0TL-00078C-9n
	for gcvg-git-2@lo.gmane.org; Tue, 07 Jun 2011 19:53:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757438Ab1FGRxm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2011 13:53:42 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:50509 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753280Ab1FGRxm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2011 13:53:42 -0400
Received: by qyk7 with SMTP id 7so1487494qyk.19
        for <git@vger.kernel.org>; Tue, 07 Jun 2011 10:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=EaXPSDPqVt9BIr36O2LknNXmCu2iO8xuUREmjmi4kEU=;
        b=hd4HvUZ7jrPzq5MEyX66qskEXfeoeC2t5jO95I4IYHdFbgQfms6by6eXyUByznuJbc
         6QtcfBpjT74Sx2zWRdesdd3PiPfcmwc4Txc+5dULdnl/aMnq8j9cgQwbIhAXomgf67ps
         zGB3O2O+BjZNn3dqPvyZ9hgQxTIkTUL9tlcIc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=tb7GSlCYDYBQkCuekcuBL4vXfzS1puZW381eaIUXBGasRw92Tecolg8WqGHEKnj00k
         qaKnrT/Frgj2yDiZJLvlmtfi3jJS/JCKW7J7lysSaHHdYeCJGMWjcwwwNS6I5bSZcMZV
         zI1eGeRsUXvFRCbj1RGcumPCrmoWqkrOvpm7k=
Received: by 10.224.204.3 with SMTP id fk3mr3239091qab.177.1307469221136; Tue,
 07 Jun 2011 10:53:41 -0700 (PDT)
Received: by 10.229.83.203 with HTTP; Tue, 7 Jun 2011 10:53:01 -0700 (PDT)
In-Reply-To: <20110607175110.GB22216@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175241>

Heya,

On Tue, Jun 7, 2011 at 19:51, Jeff King <peff@peff.net> wrote:
> Thanks. I'm not sure of some details, though. In particular, we also use
> the staging area during push to know which parts of the history we
> _don't_ have to send. So where will the remote helper store that state
> if not in this staging repo?

Oh, I didn't mean the staging _repo_. I meant the refs/testgit namespace.

-- 
Cheers,

Sverre Rabbelier
