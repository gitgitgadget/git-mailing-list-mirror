From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/2] test: check that "git blame -e" uses mailmap correctly
Date: Wed, 15 Feb 2012 00:56:26 +0200
Message-ID: <CAMP44s0TmuxfLD=-hs8jf_AfPiet+rVy7h_5x_dtp_Nwjf+i+A@mail.gmail.com>
References: <1329235894-20581-1-git-send-email-felipe.contreras@gmail.com>
	<20120214203431.GB13210@burratino>
	<20120214203603.GD13210@burratino>
	<CAMP44s2M8Ava6xyKX32h9+pbxG+zq1wH1RkdWwfNsZMzcVQEmw@mail.gmail.com>
	<20120214215930.GD9651@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 14 23:56:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxRIX-0004tn-FL
	for gcvg-git-2@plane.gmane.org; Tue, 14 Feb 2012 23:56:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932382Ab2BNW43 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Feb 2012 17:56:29 -0500
Received: from mail-lpp01m020-f174.google.com ([209.85.217.174]:45360 "EHLO
	mail-lpp01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932117Ab2BNW42 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2012 17:56:28 -0500
Received: by lbom4 with SMTP id m4so221789lbo.19
        for <git@vger.kernel.org>; Tue, 14 Feb 2012 14:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=i5F1DoUbVieM2v1hcDHCoq6Qy3aVvecyKNJWgjXwxw4=;
        b=oGveuJjpjDG04MoH9dlRT0EF/rPk5WLjk/SNtgWmJFrWJ2RWjo8qQaxdEtiPGt7mV5
         ModkmmDmTUDDIMndXaUmL0X5pbojKibFfK2YKCCpRUQYJRa+aXYPfNi6UKE1uJALgooc
         kgBpHxTrvnDivIGaeMsA2kYbKORhlRk3+cUdw=
Received: by 10.112.32.1 with SMTP id e1mr8233835lbi.3.1329260186897; Tue, 14
 Feb 2012 14:56:26 -0800 (PST)
Received: by 10.112.41.73 with HTTP; Tue, 14 Feb 2012 14:56:26 -0800 (PST)
In-Reply-To: <20120214215930.GD9651@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190791>

On Tue, Feb 14, 2012 at 11:59 PM, Jonathan Nieder <jrnieder@gmail.com> =
wrote:
> Do you mean you do not agree with the following?

> =C2=A0 =C2=A0 =C2=A0 =C2=A0(a) The contribution was created in whole =
or in part by me and I
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0have the right to submit it =
under the open source license
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0indicated in the file; or

Anybody can come up with that patch from scratch, all you have to do
is copy the previous test, change 'git blame' to use 'git blame -e',
and fix the expect file. And the subtle diff from my own patch changes
the whole meaning of it, so I wouldn't say it came from me.

But I don't care much, do whatever is more convenient for you, but if
possible, I would remove my s-o-b from it as I have not agreed on it.
And as I said; this is two patches in one.

--=20
=46elipe Contreras
