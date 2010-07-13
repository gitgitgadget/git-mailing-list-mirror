From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Merging branches
Date: Tue, 13 Jul 2010 22:05:17 +0000
Message-ID: <AANLkTikPdOVCs5aB7Gs5QCFGDIgBm00DO5XPkP39mzIW@mail.gmail.com>
References: <1279056529462-5289861.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: jhapk <pradeep.kumar.jha@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 14 00:05:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYnbR-0005Bq-0H
	for gcvg-git-2@lo.gmane.org; Wed, 14 Jul 2010 00:05:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753707Ab0GMWFU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jul 2010 18:05:20 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:42524 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752231Ab0GMWFT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jul 2010 18:05:19 -0400
Received: by iwn7 with SMTP id 7so6271375iwn.19
        for <git@vger.kernel.org>; Tue, 13 Jul 2010 15:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=MG4uJp6DUahjknkZ1Pq7Wt72srDD92HXBJiN0wXese0=;
        b=mG+grCAQHJ2YX6yyR9qF4EoffdCbhTv9A8j1R/4MXGDIkwT/j7AVqHsnuWlTf+LGnY
         gXBA9+4Yajg+agvHGyfOaf874mTPA2ba27COCb2b63YdNobswmk9BG5XXulEhUEbwSti
         32k1RUtEi60usK8GGG9PAZ1v36SjjzFTLx0zU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=mmOVPlvEDxLLFwo1YHo9eRNs2OgQszZ/NPmXwlOyFaSlTEe6VwYLergE95aNWvMlkJ
         K+Bnb/1ZW1HgbQwB4QqWaRUF+mUbJQS7jpGhWnRA4GjN3GCxSF9Ojz5Xrh05MzjcJPee
         h3PsWcac+17lzc4QKpmZ9xP5LnHQxu0qhYBTQ=
Received: by 10.231.130.145 with SMTP id t17mr16465936ibs.144.1279058717266; 
	Tue, 13 Jul 2010 15:05:17 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Tue, 13 Jul 2010 15:05:17 -0700 (PDT)
In-Reply-To: <1279056529462-5289861.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150929>

On Tue, Jul 13, 2010 at 21:28, jhapk <pradeep.kumar.jha@gmail.com> wrote:
> I have a git history which looks something like as in the figure above. I
> want to merge Branch A in Branch B. However, the commits a1, a2 and a3 are
> ugly and so I don't want those commits in my Branch B log. Is there anyway
> that I can only pull the final form of Branch A without pulling the whole
> history of Branch A?

Yes, you use rebase to squash or drop those commits, and then merge the branch.
