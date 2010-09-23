From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: git-reflog bails if branch points to bad commit
Date: Thu, 23 Sep 2010 20:35:35 +0000
Message-ID: <AANLkTimzQ5Jdw5oqiE17859YBiM0EQ6fnTp5+x6JR48k@mail.gmail.com>
References: <F628129C-56AE-4BB5-9227-4282763C5B7E@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Thu Sep 23 22:35:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OysWA-0000WA-LD
	for gcvg-git-2@lo.gmane.org; Thu, 23 Sep 2010 22:35:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755102Ab0IWUfh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Sep 2010 16:35:37 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:35214 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753869Ab0IWUfg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Sep 2010 16:35:36 -0400
Received: by iwn5 with SMTP id 5so1702517iwn.19
        for <git@vger.kernel.org>; Thu, 23 Sep 2010 13:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=S8YaVeYXGjSkV4lJtzwm1sUBObw6B+0jBkj6hc9BFao=;
        b=iw+dP1GC5apO7NPfIA7AQ+EM9l/hC9j6jAiFmH8UuMnGcQpiklYjNS7vMbLaaoQrUU
         c3vTwPEUSUxtcgWYHwriG5DlB9uOSwhALzsbukSvdqu7cqrBBr3UFmlnc8+m4huxjJBb
         TNr668j1g0CUkS1m+xSRjrrX41xUpC/zM6RfY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=tEyoWGqHjOwWbeLp07d0Zl/keZrK1nnhub8ureQDEs6+ktH4gFgCAnQnM5qm+JiUMA
         2+bstrZT1uaA/WbjrTCKcT2tbjkajEGPF/61RLvl4VlLQanoSDj7y2pAcp4V6g1Fhknc
         sUuTuHo9+xGyRKkC2UhgvtFnTMlH7lOtKfVxM=
Received: by 10.231.157.205 with SMTP id c13mr2631922ibx.71.1285274135488;
 Thu, 23 Sep 2010 13:35:35 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Thu, 23 Sep 2010 13:35:35 -0700 (PDT)
In-Reply-To: <F628129C-56AE-4BB5-9227-4282763C5B7E@sb.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156903>

On Thu, Sep 23, 2010 at 20:13, Kevin Ballard <kevin@sb.org> wrote:

> Attempting to use `git reflog show foo` or `git log -g foo` will
> bail with "bad object: foo" if the tip commit of foo is
> invalid. This seems incredibly non-useful. Why should reflog care if
> foo points to a valid commit? This bug prevents reflog from being
> used in a time of great need, which someone just ran into on the
> #git IRC channel. Their power cut out and they ended up with a
> corrupt commit on the tip of their branch, and they simply could not
> view the reflog, which would have enabled them to roll the branch
> back to a previous commit. Does anybody know why reflog has this
> behavior?

As you say the repository is probably corrupted, and recovering from
that may be hard, not much you can do with corrupted data.

Can this person provide a tar-ed copy of the repository so we can look
at it and be of help, instead of speculating?
