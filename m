From: Dun Peal <dunpealer@gmail.com>
Subject: Re: Proper way to checkout a tag?
Date: Wed, 1 Dec 2010 14:16:37 -0600
Message-ID: <AANLkTim=0dqH=gqbM1xQOWQPCZb78wfsn9wf5WRJJ9vt@mail.gmail.com>
References: <AANLkTi=b12n0J+Qg4S7i9dnbMHoWvPS3OXP0CDZevT_4@mail.gmail.com>
	<20101201195125.GC27347@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git ML <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 01 21:16:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNt6Z-0002Dx-Um
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 21:16:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756403Ab0LAUQj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Dec 2010 15:16:39 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:35346 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755919Ab0LAUQi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Dec 2010 15:16:38 -0500
Received: by qwb7 with SMTP id 7so7478547qwb.19
        for <git@vger.kernel.org>; Wed, 01 Dec 2010 12:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=+C6o0I0RI7znU83GCZyxXicfdlkc4bYi531fN7ICaHs=;
        b=QUabHATzZWic/DQeuuCR8LPex1jPS4j2PCRCs71V/wG1nkxyWCGa/m2MHfW/slbw9d
         mmHjIAbr0C63mMRFszLKJEe5YxZ20pxVHjhpkcIAeu2i/w0cJqGffJYvt+Jgr7wHtvuQ
         SYfUXYcKOawMsQhtj+RIkrIibUPXkSDdIYjLw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=pH0g9+St+bKJp/A9tJeF974ZSZw0AjYCTLWYa+EnE0pc/L98+pfwYNly6KTltDxyhh
         O9H1oFA061R4a8BxfJq8XwfRHZu0H8a/lBcEYnEn/8UgXo14t8RjMiTR+864Eklzi1vU
         Jvw71RdyAnNYNpQX+gwPxUD6TRY9yM6aIUmpw=
Received: by 10.224.74.13 with SMTP id s13mr8352429qaj.149.1291234597979; Wed,
 01 Dec 2010 12:16:37 -0800 (PST)
Received: by 10.220.128.133 with HTTP; Wed, 1 Dec 2010 12:16:37 -0800 (PST)
In-Reply-To: <20101201195125.GC27347@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162600>

On Wed, Dec 1, 2010 at 1:51 PM, Jonathan Nieder <jrnieder@gmail.com> wr=
ote:
> The idea is this: when you check out a tag or a remote-tracking
> branch, it is not to make changes to it. =A0Tags are unchanging,
> remote-tracking branches track remote state that the user does not
> directly control.

Yes, users checkout a release tag just so they can build parts of it.
There's definitely no intention of creating new changes on top of
them, and if there is then it should properly be a head (branch).

I guess that's exactly the use-case for detached HEAD, so I guess the
answer is that we should all stop being afraid of that superficially
scary term.

Thanks, D
