From: demerphq <demerphq@gmail.com>
Subject: Re: I can never finish a push
Date: Fri, 23 Dec 2011 15:19:06 +0100
Message-ID: <CANgJU+VEpYkttoBp0SUNcROH6-HmGX5v7aVXGZFO_U2aZHv8mA@mail.gmail.com>
References: <4EF47DF3.9080809@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Martin L Resnick <mresnick@bbn.com>
X-From: git-owner@vger.kernel.org Fri Dec 23 15:19:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Re5xo-00070F-Sq
	for gcvg-git-2@lo.gmane.org; Fri, 23 Dec 2011 15:19:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757269Ab1LWOTI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Dec 2011 09:19:08 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:51406 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751009Ab1LWOTH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Dec 2011 09:19:07 -0500
Received: by ghbg21 with SMTP id g21so515846ghb.19
        for <git@vger.kernel.org>; Fri, 23 Dec 2011 06:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=EccYtkF4isgaSggwBfvoawPpFPSN5VOnzAiVlKWk/WM=;
        b=xxX13qHV36KkTXryNgKOWtmax5VpG8JQvGJjuOQZP/OVWrxce63rj4HMlS14aPQaIB
         T8wlOmbcwkVCLFV9ykp+P6D03EzoYqx91CD5Y7WjigI5QcyoqaCCYFwHqKK3TY4CodQ3
         vF3tB296n7Ta3V3uGfAmUnzVQ+idvayrw0Zlk=
Received: by 10.101.139.1 with SMTP id r1mr6318483ann.86.1324649946407; Fri,
 23 Dec 2011 06:19:06 -0800 (PST)
Received: by 10.236.72.132 with HTTP; Fri, 23 Dec 2011 06:19:06 -0800 (PST)
In-Reply-To: <4EF47DF3.9080809@bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187629>

On 23 December 2011 14:11, Martin L Resnick <mresnick@bbn.com> wrote:
> I'm working remotely over a VERY slow line.
>
> When I do a push it starts out fine
> but after the 15 seconds it takes to push
> it fails with non-fast-forward merge.
>
> So I pull (no merge needed, its fast-forward)
> and try push again. Fails again.
>
> I can keep this up for hours on end;
> pushing, pulling, pushing, pulling.
> Apparently there is fast and furious development
> on the branch I'm on that during my 15 seconds
> of pushing someone else on-site pushes and adds
> new commits before mine can finish.
>
> Is there anyway to lock the repository while
> my push is going on ?
>
> Please don't ask why I have a slow line
> or why the volume of changes that I am pushing.
> Suffice it to say its military work.

Maybe try pushing a branch and then having a colleague with a faster
connection do the merge for you.

yves


-- 
perl -Mre=debug -e "/just|another|perl|hacker/"
