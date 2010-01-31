From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [ANNOUNCE] Git 1.7.0.rc1
Date: Sun, 31 Jan 2010 02:12:19 +0100
Message-ID: <fabb9a1e1001301712h3223f4c5xcf4742cde1642dfe@mail.gmail.com>
References: <7vaavvi4r5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 31 02:12:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NbOMr-0001D8-HD
	for gcvg-git-2@lo.gmane.org; Sun, 31 Jan 2010 02:12:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754136Ab0AaBMk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 30 Jan 2010 20:12:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754114Ab0AaBMk
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jan 2010 20:12:40 -0500
Received: from mail-pz0-f172.google.com ([209.85.222.172]:51101 "EHLO
	mail-pz0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752993Ab0AaBMj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 Jan 2010 20:12:39 -0500
Received: by pzk2 with SMTP id 2so2929279pzk.21
        for <git@vger.kernel.org>; Sat, 30 Jan 2010 17:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=b5Gd5b0yMiQZFRZwDoFMQITt2aSFEAObbwduwy4QflM=;
        b=Xn0owFgdCY/BDcWTTJW6mz/EyoOWLx7gfYelVRo2ci8yb/K486Yp8Uy7lSqHb3XoxP
         dzQgFB6kAQbV5m18nP6KGAN4Mw7K87ik/V6Bv1asVStDLfh0RkxSG7CG3wKYBPvBl8wT
         vJzIPpyvRnGZHvy1rJee8lgiGqo40IhfCesqw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=OE+kc9DaeMWx5KuqlgoJ/sBti/MSpjjOmAOX7MnWqdt5hHejHaiW8jJfeeGaz53afE
         p7Ejnj5CqSdU/1jI6QnOBRv8MebsFkI6GQRwDy3oAZPyK7bTxFbiDwivbGjsikN+j1xt
         bUBdJbQzPck29IIZolzg1HXqjgByi6b2Svw0o=
Received: by 10.142.2.23 with SMTP id 23mr1809266wfb.327.1264900359056; Sat, 
	30 Jan 2010 17:12:39 -0800 (PST)
In-Reply-To: <7vaavvi4r5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138524>

Heya,

=46eel free to tell me "go build 1.7.0.rc0 yourself and see" to any of
these, but I can't right now, and am curious :).

On Sat, Jan 30, 2010 at 23:53, Junio C Hamano <gitster@pobox.com> wrote=
:
> =A0* "git checkout A...B" is a way to detach HEAD at the merge base b=
etween
> =A0 A and B.

Does 'git checkout -b mergebase-a-b A...B' work as expected?

> =A0* "git log" and friends learned "--glob=3Dheads/*" syntax that is =
a more
> =A0 flexible way to complement "--branches/--tags/--remotes".

Not --glob=3Drefs/*?

> =A0* "git rebase --onto A...B" means the history is replayed on top o=
f the
> =A0 merge base between A and B.

Oh wow, neat, I guess that complements the 'git checkout A...B'
behavior? Is there anywhere else that we could/should support this new
syntax, but don't?

> =A0* "git rebase -i" also learned --autosquash option, that is useful
> =A0 together with the new "fixup" action.

Did we add a config option for this?

--=20
Cheers,

Sverre Rabbelier
