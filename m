From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: File Systems and a Theory of Edits
Date: Sat, 30 Jul 2011 21:06:33 +0200
Message-ID: <CACBZZX48aDN_Njm+qMvovfz1tjdhnmXe5-bbJe=0_Q3LbLWoPA@mail.gmail.com>
References: <CADo4Y9hG=-Bye5g7OWROJNbbUOcnH0hj0f3csws5V+YzEUKAMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: mike@nahas.com
X-From: git-owner@vger.kernel.org Sat Jul 30 21:06:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnErx-0003il-VA
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jul 2011 21:06:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752511Ab1G3TGg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 30 Jul 2011 15:06:36 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:62101 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752323Ab1G3TGe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 Jul 2011 15:06:34 -0400
Received: by fxh19 with SMTP id 19so3275169fxh.19
        for <git@vger.kernel.org>; Sat, 30 Jul 2011 12:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=NLS0TEBpkdeGMNNe7HSUxEBTpOF9d+Lr1LlSrLcx8b0=;
        b=orNNOlU08UlJ2iDYjhlcohOiSKlZfE/5yQYQbl09cwTkYzPkVxVWkDM1fSJl7MzmxA
         usS+cKRLqU41KE5h9gN1xpIecLM6KGr/CiffbZF/Z14sn/l/cC2Hbl0y9uFZa6tyKyy4
         Bc6RkKlxubi5hHt/bcSowbShfUcIZNmD0wdiU=
Received: by 10.223.32.19 with SMTP id a19mr3748724fad.22.1312052793137; Sat,
 30 Jul 2011 12:06:33 -0700 (PDT)
Received: by 10.223.148.78 with HTTP; Sat, 30 Jul 2011 12:06:33 -0700 (PDT)
In-Reply-To: <CADo4Y9hG=-Bye5g7OWROJNbbUOcnH0hj0f3csws5V+YzEUKAMg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178217>

On Sat, Jul 30, 2011 at 16:29, Michael Nahas <mike.nahas@gmail.com> wro=
te:
> =C2=A0=C2=A0=C2=A0 "git xargs <commit> ..."=C2=A0 (Is this possible?)

I don't have comments on the rest of your proposal, but I've often
wanted a git-find(1) similar to git-grep(1). Which would give you this
functionality.

Then you could simply:

    git find <commit> <path> -type f | xargs <whatever>

Or something like that.
