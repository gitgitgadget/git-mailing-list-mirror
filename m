From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Proposal: sharing .git/config
Date: Tue, 19 Feb 2013 17:34:43 +0700
Message-ID: <CACsJy8Ch70gZMkT7ScY3R-FNQU4QjtUe8UhoGRzE27cH9mu0HA@mail.gmail.com>
References: <CALkWK0npW6TLdMNd5_zw-RAB0bjF9DDoyAVSx4Zx=7AmvdEo3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 19 11:35:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7kYA-0005q2-9l
	for gcvg-git-2@plane.gmane.org; Tue, 19 Feb 2013 11:35:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932655Ab3BSKfS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2013 05:35:18 -0500
Received: from mail-oa0-f54.google.com ([209.85.219.54]:58490 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932662Ab3BSKfP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2013 05:35:15 -0500
Received: by mail-oa0-f54.google.com with SMTP id n12so6699264oag.27
        for <git@vger.kernel.org>; Tue, 19 Feb 2013 02:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=rXqUkWSuioYSOH8h4060HMDYWm/NV2dTw4HmCla9wVE=;
        b=KHvfWCDDwEbA8nyeBh0MhnDQ62oCtcrtT/qpdi9/iyFX8Nx3z3HXjbO2fg8Hi5H0sS
         EU19p5cgIL+tqA2o97Ra+KnCvPPoBn0RhflCKryJe7wFw4BsA7BMf7pqEpW+VPbHVvHB
         dDPCxbhBkMV2H41iJUEQ1q3gD/vsSFLKDp8oghUvEyDkEdq+IhIuPiQox49b1ADJ+B6c
         ymKQCikEG0EYFsXGxFvqzJ6Spf77OtYBiUouj1/3cgrz7rVGcQkr3ld6qx4xNWDLMLxY
         OcMiSmFZrg6M2xuHIwD9rHsO0LN5BijC/N8BPJaXHMol0BdyCPBE8D47mRyH487lpaLU
         /eKg==
X-Received: by 10.60.5.231 with SMTP id v7mr7347619oev.62.1361270113399; Tue,
 19 Feb 2013 02:35:13 -0800 (PST)
Received: by 10.76.154.197 with HTTP; Tue, 19 Feb 2013 02:34:43 -0800 (PST)
In-Reply-To: <CALkWK0npW6TLdMNd5_zw-RAB0bjF9DDoyAVSx4Zx=7AmvdEo3w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216599>

On Tue, Feb 19, 2013 at 4:25 PM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Hi,
>
> I have this itch where I want to share my remotes config between
> machines.  In my fork, I should be able to specify where my upstream
> sources are, so remotes get set up automatically when I clone.  There
> are also other things in .git/config that would be nice to share, like
> whether to do a --word-diff (why isn't it a configuration variable
> yet?) on the repository.  The only problem is that I have no clue how
> to implement this: I'm currently thinking a special remote ref?

If you check out the config file, then include.path should work. You
could add include.ref to point to a ref, but you need to deal with the
attached security implications. This has been proposed before (and
turned down, I think).
-- 
Duy
