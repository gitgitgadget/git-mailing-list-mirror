From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v4 00/10] Sequencer Foundations
Date: Fri, 27 May 2011 12:52:07 +0530
Message-ID: <BANLkTik1oyCCjcAqvqZNHPecNKUJ9k0bCA@mail.gmail.com>
References: <1306333025-29893-1-git-send-email-artagnon@gmail.com>
 <1306425233-504-1-git-send-email-artagnon@gmail.com> <7vpqn5w9zi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <christian.couder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 27 09:22:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPrNR-0000Jk-EA
	for gcvg-git-2@lo.gmane.org; Fri, 27 May 2011 09:22:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755153Ab1E0HW3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 May 2011 03:22:29 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:54267 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751274Ab1E0HW2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 May 2011 03:22:28 -0400
Received: by wwa36 with SMTP id 36so1554368wwa.1
        for <git@vger.kernel.org>; Fri, 27 May 2011 00:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=v2XnAVBRyBXnCggLC1XJPgVNsDPWKkUeKzw7y/gvBw8=;
        b=NhLHBIknSMkUrbujwN10RbpFu8xITeQjD3QPsccyJEQXnZLarAs9VGRqMjc5Vq+Y0O
         imrkD6zN/ahl4YIgBq04qrQhG4opyarhxa6pHbPLiTcygUN98btbXs0WLiMNuGwXB0kU
         TFSgCzLWo04772cNUiHicne9WZyEntDKP5j+s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=sUperSI5kgVsfYuZO3N9PWlPSBYpGoxS8Yl8Kifsb3fnFBFjsU0qIrUAPzt3ti80zH
         9AQBLQU5oSxEshIjjvoQCKCDun5G/B/nLisXSJ1MQfCC6AhTLZqbsWrF1vvPgxNrrbR3
         logJ52Q+gMgUx/1CgFCQa841hxrZcw1YZPejI=
Received: by 10.216.145.234 with SMTP id p84mr1615071wej.64.1306480947075;
 Fri, 27 May 2011 00:22:27 -0700 (PDT)
Received: by 10.216.158.70 with HTTP; Fri, 27 May 2011 00:22:07 -0700 (PDT)
In-Reply-To: <7vpqn5w9zi.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174601>

Hi Junio,

Junio C Hamano writes:
> Without spending that effort and saying "I am in a hurry" give a wron=
g
> impression to others: "I cannot tell if this round is better cooked t=
han
> the previous round without spending nontrivial time reading on it, bu=
t
> chances are it hasn't been much improved during the 24 hours. =C2=A0I=
t may be
> better use of my time to skip it and work on other topics first. =C2=A0=
After
> finishing everything else I can come back---by that time Ram may have=
 sent
> out another round and reviewing this round right now may become waste=
d
> time".

You're right; this iteration was ill-thought-out. I'll try to put
myself in my reviewer's shoes before submitting code next time, so
that I don't waste effort re-rolling unnecessarily.

> Also the series seems to be based on a rather old codebase where we d=
idn't
> allow reverting the root commit. I tried to apply a first few to
> understand where these "positive" error status could be coming from, =
and
> was stopped by patch conflicts. In [2/10] I think you are propagating
> errors from run_command() coming back through try_merge_command(), an=
d the
> change is good for that particular codepath, but I haven't followed a=
ll
> the other codepaths from do_cherry_pick() to convince myself that the=
 exit
> status from the merge strategy backend are _the only_ positive return=
s you
> can possibly get. Have you?

Oops, I'll rebase.
I'll trace all the code paths carefully and include a summary of my
learnings in the next iteration.

-- Ram
