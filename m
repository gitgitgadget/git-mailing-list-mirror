From: Michael Lukashov <michael.lukashov@gmail.com>
Subject: Re: [PATCH 3/3] fetch --all/--multiple: keep all the fetched branch 
	information
Date: Wed, 24 Feb 2010 22:54:18 +0300
Message-ID: <63cde7731002241154o40ad7e6eh26f20017f7854fc3@mail.gmail.com>
References: <1267035726-2815-1-git-send-email-gitster@pobox.com>
	 <1267035726-2815-2-git-send-email-gitster@pobox.com>
	 <7vpr3uqwya.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 24 20:54:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkNJZ-0002I8-GX
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 20:54:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757897Ab0BXTyV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Feb 2010 14:54:21 -0500
Received: from mail-ww0-f46.google.com ([74.125.82.46]:49323 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757542Ab0BXTyU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Feb 2010 14:54:20 -0500
Received: by wwf26 with SMTP id 26so1484719wwf.19
        for <git@vger.kernel.org>; Wed, 24 Feb 2010 11:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=NgAspIuE5YClUgbGedSUyFrJ8nEs4bSZNGtqfqdHAxw=;
        b=YP1XC+m8hYeDNbrRhqbKKetcJvl5bf1Lp7vg+RpDIhzXALVjJl1erpGgRVFAulT3dw
         zX4Z9v3stf4tIkTIqbutdxfo7NeS4lDgYHZXankZocJSXP6l2Q5+yHgFGs0v0OoPPtqt
         rJR0eeDUwUTRBRvbk985vPt70nZ8Jmg5pDYh4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=vQNa+hy9ptZvM6umRxFlDruxpCZPnZF5vaqOtO88BefhEDCMfxDgzLVlRemai1DAxb
         LrQ+rXvz+wyk3/gfUSsOlmt3tsjnCBrhWyG7NsK5FVnMAdqW5W5RHYdO60X5BPiEZlSY
         tPdgAnPauN7/mKb4aOdiQl+o16nFKlMeC9MzM=
Received: by 10.216.86.11 with SMTP id v11mr112407wee.219.1267041258683; Wed, 
	24 Feb 2010 11:54:18 -0800 (PST)
In-Reply-To: <7vpr3uqwya.fsf_-_@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140983>

Patch 3 does not apply correctly:

Applying: fetch --all/--multiple: keep all the fetched branch informati=
on
error: patch failed: t/t5521-pull-options.sh:72
error: t/t5521-pull-options.sh: patch does not apply
Patch failed at 0001 fetch --all/--multiple: keep all the fetched
branch information
When you have resolved this problem run "git am --resolved".
If you would prefer to skip this patch, instead run "git am --skip".
To restore the original branch and stop patching run "git am --abort".

On Wed, Feb 24, 2010 at 10:02 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Since "git fetch" learned "--all" and "--multiple" options, it has be=
come
> tempting for users to say "git pull --all". =C2=A0Even though it may =
fetch from
> remotes that do not need to be fetched from for merging with the curr=
ent
> branch, it is handy.
>
