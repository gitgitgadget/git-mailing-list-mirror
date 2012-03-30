From: Yuval Adam <yuv.adm@gmail.com>
Subject: Re: Maintaining historical data in a git repo
Date: Fri, 30 Mar 2012 23:39:38 +0300
Message-ID: <CA+P+rLeDFu4KgEZPw=k67iMWVVGcZ3q48VZjgXNLXn3NdyQnow@mail.gmail.com>
References: <CA+P+rLeyEcZPudhLWavB74CiDAqpn+iNkk4F8=NK_yGaJPMmyA@mail.gmail.com>
 <201203301510.q2UFAqn6003864@no.baka.org> <CA+P+rLcWT0SZQjW2LtFXXCDRwjMp8daJ2hVup=7cnsRGbKw7xw@mail.gmail.com>
 <7vehsam3pn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 30 22:40:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDicA-0003Rz-16
	for gcvg-git-2@plane.gmane.org; Fri, 30 Mar 2012 22:40:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933336Ab2C3UkA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Mar 2012 16:40:00 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:56055 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933072Ab2C3Uj7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Mar 2012 16:39:59 -0400
Received: by iagz16 with SMTP id z16so1444701iag.19
        for <git@vger.kernel.org>; Fri, 30 Mar 2012 13:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type:content-transfer-encoding;
        bh=qWKCoB5MbVrk3RJsKqtOwIAvuC6X3XPJEME0yINtpqk=;
        b=xfwqewMH9BOMDDaUhVAq6LBwGCsoMKmTWB+DtIUFlze3evyT7Xp1hzzhVyb/KZghYj
         gHEw9LvqfBvbpLpFs486y2ArUfSWNZ4A+/pR8K8qlBotkU0xnamdnIRwdSI+812JHgJ8
         /RORxItGfDQtyosjg7QcFgW5eL4lVU5v8xn5oUvlP3XXLDZWfrb6rbvDuQF3m2dA24oK
         RK6Q+RThPqb7Pm6xwWe/jQRC1GZDk0mSlaRTI+UMrIwRS9sC94I/ulLdS+EXY5ZBDsP+
         EemxmsTHR4Ft7W1IYUbiYOed2j0uXWt0roRW84QBUSgy8naDkCCinUs1meFU8iy53F/V
         Sbdg==
Received: by 10.42.152.68 with SMTP id h4mr2103260icw.15.1333139998766; Fri,
 30 Mar 2012 13:39:58 -0700 (PDT)
Received: by 10.42.137.66 with HTTP; Fri, 30 Mar 2012 13:39:38 -0700 (PDT)
In-Reply-To: <7vehsam3pn.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194404>

On Fri, Mar 30, 2012 at 7:52 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> That's not really "is it complicated with git" question, I would have=
 to
> say. =A0Any version control system you would build history starting f=
rom one
> point going _forward_, never inserting past event as you dig back.

That is true.
It is very clear to us that an SCM is optimized for the prevalent use
case, which is tracking code (well, mostly code) as it is written.
Naturally this always starts at some point in time and progresses into
the future.

However, we perceive git as a very powerful tool, that can fit
beautifully with the way legislation works today.
The challenge for us - should we choose to accept it ;) - is to build
a set of wrapper tools that allow us to use git in such a way, while
enabling us to build up past history.

Yes, this is not the usual use case, but we're highly motivated on
making this work.
We believe this could also be an interesting experience for the git
community in seeing how the git plumbing can be used for other cases,
even if they veer off on some weird tangent.

We'll definitely be back with more questions and updates, as we progres=
s.
Thanks, everyone, for your responses and feedback!

--
Yuval Adam
http://y3xz.com
