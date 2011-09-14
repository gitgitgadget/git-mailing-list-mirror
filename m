From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Fwd: [Survey] Signed push
Date: Wed, 14 Sep 2011 08:27:35 -0700
Message-ID: <CA+55aFyGRM132OzoJR7wZ8wETvxrFWSmSMjMJnVOKP+6vys-Sw@mail.gmail.com>
References: <7vaaa8xufi.fsf@alter.siamese.dyndns.org> <CA+55aFxAQTR3sT7gekAD4qih8J+z-qwri7ZmNCPUd811xgci6w@mail.gmail.com>
 <CA+55aFy0b+eozmzbKD4RXcJ7e3WCpf7BV1n1qXHOeEwSHZKOXw@mail.gmail.com>
 <4E7085E6.3060509@alum.mit.edu> <vpqfwjzxu6i.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Sep 14 17:28:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3rO4-0001GN-GU
	for gcvg-git-2@lo.gmane.org; Wed, 14 Sep 2011 17:28:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756792Ab1INP15 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Sep 2011 11:27:57 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:60339 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755509Ab1INP14 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Sep 2011 11:27:56 -0400
Received: by wwf22 with SMTP id 22so2378475wwf.1
        for <git@vger.kernel.org>; Wed, 14 Sep 2011 08:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=/RNR8xs8uGhwAJZrl2CphYGd31eGBQ6d/pJIH+h6LpU=;
        b=dJk6jeGcigDK2QlTfRi7bXi8597PdGs+bUQUq50dz4B9CnQWjLQ+ynV49Jkn6kB7cA
         Iv+Li25iZh/VLDRDE2GYQK2W20LUTDRx1pYjvl6O9ceUveZLJAAVzGsMB2bxbasqkkUK
         5FI/MFMhbu0yoFvCj0rEp41L91S0kgCf3RUIA=
Received: by 10.216.55.210 with SMTP id k60mr3562417wec.61.1316014075153; Wed,
 14 Sep 2011 08:27:55 -0700 (PDT)
Received: by 10.216.174.8 with HTTP; Wed, 14 Sep 2011 08:27:35 -0700 (PDT)
In-Reply-To: <vpqfwjzxu6i.fsf@bauges.imag.fr>
X-Google-Sender-Auth: JBxwhMR8n_Vt4ImwA3x9wfek29M
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181363>

On Wed, Sep 14, 2011 at 4:03 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
>
> Would the notes mechanism be able to annotate ref names instead of
> commit sha1?

That would be a horrible, horrible notion.

It's quite common to have multiple branches with the same SHA1. It
might be in the "experimental-development" branch, but it got through
testing with flying colors and deemed to be stable, so it got upgraded
to the "for-linus" branch, and there hasn't been any other development
since. So now both "for-linus" and "experimental-development" are the
same commit, but they are very much not the same branch!

So no, don't confuse branch *contents* with branch *descriptions*.

                          Linus
