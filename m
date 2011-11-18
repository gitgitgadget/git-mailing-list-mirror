From: Shawn Ferris <shawn.ferris@gmail.com>
Subject: Re: .git ignored regardless of --git-dir value
Date: Fri, 18 Nov 2011 16:44:03 -0700
Message-ID: <CAC2kKA-E4KstQCGV=gMJHFdUdzM0boc7SmZNzvSh9_OQWvHcdQ@mail.gmail.com>
References: <CAC2kKA_PZNDg_dPjWXKeFU4ZVpMas3PubZfSgTnfCfVPuNPdsA@mail.gmail.com>
	<7vsjlljf57.fsf@alter.siamese.dyndns.org>
	<7v7h2xjbf4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 19 00:44:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RRY6a-00072W-AC
	for gcvg-git-2@lo.gmane.org; Sat, 19 Nov 2011 00:44:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755898Ab1KRXoF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Nov 2011 18:44:05 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:48882 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753595Ab1KRXoE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Nov 2011 18:44:04 -0500
Received: by vbbfc21 with SMTP id fc21so724054vbb.19
        for <git@vger.kernel.org>; Fri, 18 Nov 2011 15:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=6ILaUB3sGz1/b1+VDALj33Or59bDEYnH3Ofh+MTds5Q=;
        b=Rql/UkWkSCc5tWvEb35EIF3/hRmOvVr24ulJ4qGGZ8wWA9u+akUr8ZArjRAVoQAfHy
         BazENJO+HjCCJfgLvS/s5HM+VYURDdZZ39uSanYZZVI9+G2tiDOnEeao9q8hdpDRbI31
         +QM08CB3x5C7xk+0JT+FlKlVeSGtd12ZYTGfk=
Received: by 10.52.74.162 with SMTP id u2mr5647014vdv.69.1321659843971; Fri,
 18 Nov 2011 15:44:03 -0800 (PST)
Received: by 10.220.227.3 with HTTP; Fri, 18 Nov 2011 15:44:03 -0800 (PST)
In-Reply-To: <7v7h2xjbf4.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185685>

On Fri, Nov 18, 2011 at 3:47 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:

>>
>> GIT_DIR and --git-dir are meant to refer to a different .git dir (or a
>> bare-looking repository) located elsewhere, and not for a random pathname
>> like ".foo". No matter what, ".git/" anywhere is ignored from very early

I'm extremely green to git, so please forgive if this is obvious, but,
could I indulge and ask what a sample use case of that would be?
(since it's not intended for what I assumed it was) And, if the
behavior I expected was possible, simply, with perhaps a separate
option, what is the likelihood a patch would be accepted? (Or am I
just talking nonsense and should just go away) ;D

Thanks Again!

Shawn
