From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: potential improvement to 'git log' with a range
Date: Wed, 23 Jun 2010 15:36:51 -0400
Message-ID: <AANLkTinPrObdQh1vZLo0tlq2bZn7BXKvHWLktI2pR5LY@mail.gmail.com>
References: <w2j3abd05a91004091624mb2836ff4v118a1ae9ac5ca6e7@mail.gmail.com>
	<i2kfabb9a1e1004091633nc70f2f19hd16ea9704f0933b0@mail.gmail.com>
	<n2t3abd05a91004091713s4d081106qd74419425b25e8e@mail.gmail.com>
	<alpine.LFD.2.00.1004091807220.3558@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Aghiles <aghilesk@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	git list <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jun 23 21:37:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORVkn-00087l-O5
	for gcvg-git-2@lo.gmane.org; Wed, 23 Jun 2010 21:36:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753490Ab0FWTgw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jun 2010 15:36:52 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:36661 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752611Ab0FWTgw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jun 2010 15:36:52 -0400
Received: by iwn1 with SMTP id 1so65381iwn.19
        for <git@vger.kernel.org>; Wed, 23 Jun 2010 12:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=Qo9mhpUukhcujuITIVFoZrYk0GW4DmBr4wo0ndXK5e0=;
        b=BlpbAeHWf7phbLo6cmdXzMyY1EHE5b3XYj8o7MRNeKru85Oq+j3xzbzv6N2dmWynrE
         ziy7EqOTOCijFa8tieDUm6ThlC4nCG4hRbP8TIRouE5E6DMLPfuzYopHAph6s45tyGkF
         UjhrO0ZaIakzhNpm3HcvjU6Tx26lmVW7yMCu4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=T7h9i44EgrIDXNRYVkgHWMIMHr4q2m8uZ8VDSu7NCjB4KNrQKVGC59RGU4pHW9deH1
         6fIh4pNy9m5PYNnkPMcMiSYDjaaGO/zIPy2Jkf1o4L/qqEC+8aVqVQMhOqDOAE/BvLDp
         u5MtuQD6YEA9nXOFpJF923XIK6D1rkkfQsJqs=
Received: by 10.231.156.73 with SMTP id v9mr9402914ibw.117.1277321811542; Wed, 
	23 Jun 2010 12:36:51 -0700 (PDT)
Received: by 10.231.120.19 with HTTP; Wed, 23 Jun 2010 12:36:51 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1004091807220.3558@i5.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149538>

On Fri, Apr 9, 2010 at 9:20 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> To make things even more exciting triple-dot, "A...B" has two different
> meanings too, again one that is about sets ("symmetric difference") for
> the log-based ones, and one that is a somewhat badly defined range for the
> diff based ones (where the end-points are "one common nearest ancestor of
> A and B" and "B" respectively).
>
> It's all actually very natural when you get used to it, although that
> "A...B" as a range really isn't well-defined, since there can be more than
> one common nearest ancestors. It's still often enough useful in practice
> that I wouldn't get rid of it, but it's not the greatest feature.

Speaking of which, I'd love a switch to "git show $merge_commit" which
does "git log $merge_commit^..$merge_commit^2" but I've been too lazy
to write it. 9/10 times that I use .., it's in this context. :-)

j.
