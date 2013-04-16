From: Phil Hord <phil.hord@gmail.com>
Subject: Re: What's cooking in git.git (Apr 2013, #05; Mon, 15)
Date: Tue, 16 Apr 2013 18:45:46 -0400
Message-ID: <CABURp0qGYG4T+t36=Us328YdLzy9KjBOWot2gSOk=FgCRUCLnQ@mail.gmail.com>
References: <7vhaj7r116.fsf@alter.siamese.dyndns.org> <CAMP44s2_wiNr4RaBOEnKnZzT4CF0qKK+bp+Lyi=Nfx3Q9ggqOQ@mail.gmail.com>
 <7vip3npet0.fsf@alter.siamese.dyndns.org> <CAMP44s3NE3yrQoa1nZXAgy3KFXGF56Ki8icJ2z2TDigzax0nWg@mail.gmail.com>
 <8761zm4wzg.fsf@linux-k42r.v.cablecom.net> <CAMP44s0a2VsPBMd9Vrrhwdw=SPp2HrvDdXZ9Dmzhr9A6T+Sz7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Thomas Rast <trast@inf.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 17 00:46:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USEdg-0004Zh-Vc
	for gcvg-git-2@plane.gmane.org; Wed, 17 Apr 2013 00:46:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965555Ab3DPWqI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Apr 2013 18:46:08 -0400
Received: from mail-vb0-f53.google.com ([209.85.212.53]:58992 "EHLO
	mail-vb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965542Ab3DPWqH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Apr 2013 18:46:07 -0400
Received: by mail-vb0-f53.google.com with SMTP id i3so800770vbh.40
        for <git@vger.kernel.org>; Tue, 16 Apr 2013 15:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=FNfe/CLgNL+ow0OfwxDYLmiprjnzLpKUXxBdzPp/vb8=;
        b=VVlQSnZIGU1TxghI4SzRwO/3LGSOyapBD6H/lxGaDLyMta9saOjLkR25Zmr8Dr8bMi
         +ywIhk82Ojkbs1BC39Ms4IIsiY/DywikmRpPYyN1sA7sUsVeN7H7HWm5A3EQfUtY1aB5
         3HHCO1IsSz8ev1xkD3dT0QHFEUv5VWj85Mdd6nJaavuKeR7rBfJHNAKKvkLLIx4+mK5M
         kbG6dS//Kwf/z3vOK6GlQlEprNPApBH2hGc7aW//rqEJk6xz6s2wlnGxea/fkrEzplx7
         PSvTxldWLma3mqnX0AnHur3WS7oJi0XkQ7nU/GJ/O2NVls5hentgmXjw6NzwozIXeOVw
         LSiw==
X-Received: by 10.220.39.69 with SMTP id f5mr3100633vce.45.1366152366637; Tue,
 16 Apr 2013 15:46:06 -0700 (PDT)
Received: by 10.58.219.34 with HTTP; Tue, 16 Apr 2013 15:45:46 -0700 (PDT)
In-Reply-To: <CAMP44s0a2VsPBMd9Vrrhwdw=SPp2HrvDdXZ9Dmzhr9A6T+Sz7w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221487>

On Tue, Apr 16, 2013 at 3:04 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Tue, Apr 16, 2013 at 4:59 AM, Thomas Rast <trast@inf.ethz.ch> wrote:
>> A cursory look^W^Wreview of the messages in fc/remote-hg:
>
> [skipping irrelevant comments]
>
> I'm sorry, did you actually hit an issue that required to look at the
> commit message to understand where the issue came from? No? Then I
> won't bother with hypotheticals.
>
> If you want to waste your time, by all means, rewrite all my commit
> messages with essays that nobody will ever read. I'm not going to do
> that for some hypothetical case that will never happen. I'm not going
> to waste my time.

This is not a hypothetical.  Almost every time I bisect a regression
in git.git, I find the commit message tells me exactly why the commit
did what it did and what the expected result was.  I find this to be
amazingly useful.  Do I need to show you real instances of that
happening? No.  I promise it did, though.

Of course, 99% of the commit messages may never be useful to me or
anyone else.  But we do not eschew them altogether.  The 1% I have to
rely on are nearly always helpful and clear, and that is the part I
care about.

If you will not waste your time to write a decent commit message, why
do you waste our time asking us to review and accept ill-defined
patches?  Here, of course, I use the royal "us" as I do not review
your patches.  I do not know why that is; I suppose you patch things
outside of my interests, but it may also be that your patches are
simply incomprehensible by design.

Phil
