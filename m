From: Adam Mercer <ramercer@gmail.com>
Subject: Re: Getting the commit that corresponds to a specific annotated tag
Date: Fri, 1 Jun 2012 17:11:12 -0500
Message-ID: <CA+mfgz0GqTKwOg6b=6rPUUnS6kwXZfCCYE7SOVHFcqrjRpOiTw@mail.gmail.com>
References: <CA+mfgz2=ZFBetSGv1Bkq6orBbpVTS1k0gLVm0nGoR1sUDkDwqQ@mail.gmail.com>
 <7vd35i1ymz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 02 00:11:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Saa4b-0007bX-J4
	for gcvg-git-2@plane.gmane.org; Sat, 02 Jun 2012 00:11:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965546Ab2FAWLx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Jun 2012 18:11:53 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:42482 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750998Ab2FAWLx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Jun 2012 18:11:53 -0400
Received: by yenm10 with SMTP id m10so2188420yen.19
        for <git@vger.kernel.org>; Fri, 01 Jun 2012 15:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=9nYOSJwaIKhQiNql9Wgi4yAQ43ziS7y8xFAIhVG8a2A=;
        b=WW3cOIlqBsuWD02Iw8oe4diXJh9ZM/oEN2imhFnBwnfWnL1SwvUN6j/eVel22rm4K7
         MjiFfFj3+51UXVdZIYwwkssYyZl+CMsY+uH/urqV+6G8QUgSvfqeBuUWDv9SlUBdhWAB
         HV5s8JR8Ex8sq9zBgLtZlvI/a/DTOLThcHjnWzWNVbUbQ6aAOraOpZLmpyq9nHo0M0MV
         hZbDa9o4jVTi3JSobpVwyrsm7kRZA5HvYJBe9wx8aAaW+tK6ZkZTfTmPUulqMgio4JuQ
         eCO2UxDwG18vg+1W/+LzplrC7T7eZTJzEOF1//9gVEC8AtAWqc34Rq3dItpu+cePCE+q
         CBHA==
Received: by 10.236.126.15 with SMTP id a15mr335221yhi.14.1338588712332; Fri,
 01 Jun 2012 15:11:52 -0700 (PDT)
Received: by 10.147.97.23 with HTTP; Fri, 1 Jun 2012 15:11:12 -0700 (PDT)
In-Reply-To: <7vd35i1ymz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199028>

On Fri, Jun 1, 2012 at 5:00 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:

> I think you want
>
> =A0 =A0 =A0 =A0git rev-parse $tag^{commit}
>
> It's kind of scary, though.

Thanks, that does the trick. Why do you say it's scary?

Cheers

Adam
