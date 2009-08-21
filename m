From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: git rebase --interactive problem
Date: Fri, 21 Aug 2009 23:18:55 +0200
Message-ID: <81b0412b0908211418l42abbe9btcb01ff86714075bd@mail.gmail.com>
References: <1250889145942-3492625.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Lenka Dubcova <dubcova@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 21 23:19:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MebVz-0007qQ-Dy
	for gcvg-git-2@lo.gmane.org; Fri, 21 Aug 2009 23:19:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932719AbZHUVS4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2009 17:18:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932584AbZHUVS4
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Aug 2009 17:18:56 -0400
Received: from mail-ew0-f207.google.com ([209.85.219.207]:55603 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932528AbZHUVS4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2009 17:18:56 -0400
Received: by mail-ew0-f207.google.com with SMTP id 3so978256ewy.18
        for <git@vger.kernel.org>; Fri, 21 Aug 2009 14:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=U3iGf/L/c272uZl9GgnuhGwgUnfgXfQMqeNFgxiNfds=;
        b=pO/PybYIseZpm5S6Q8MO5XE4RGu2M4udmTyQH3Sbzi6ayu1nYWhr+PVyeRGJ07RYgN
         hKtLL6WFFRBzWJ95lHp4gnB16imgZgdd+de3Heu59uDWguesbYpvVsgEmBxS6A7uhHUt
         x37n7GzKFAklq2dhTA1IyhlcXtWf1Yt37kpy0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=qyu19wPe4a/uoakRMWe93YwjpN8dAm08yfd9Dsf7cN2nc6jK61+couxxH2/EjFxfM6
         4uJkYHegXIi0tdcHhAPnaDOxX3KyALACpv8s1IhgBF9NBwfNcpy7BES4wiBfNiZq/6Rz
         aoGxKVb+RyBTudxxy+KPFuAVvk06SZAOaT5D8=
Received: by 10.210.62.4 with SMTP id k4mr1733629eba.25.1250889536648; Fri, 21 
	Aug 2009 14:18:56 -0700 (PDT)
In-Reply-To: <1250889145942-3492625.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126759>

On Fri, Aug 21, 2009 at 23:12, Lenka Dubcova<dubcova@gmail.com> wrote:
> Unknown command: sqaush 43ce3ae my commit message
> Please fix this in the file
> /home/lenka/hermes2d/.git/.dotest-merge/git-rebase-todo.
>
> Moreover it jumped from my branch to (no branch).
>
> So I corrected it in "git-rebase-todo" and saved, but I don't know what to
> do next.

Try "git rebase --continue"
