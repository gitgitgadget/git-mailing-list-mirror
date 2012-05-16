From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v5] completion: add new __git_complete helper
Date: Wed, 16 May 2012 17:25:50 +0200
Message-ID: <CAMP44s0F04HZc5+MJQrzDJ0qJNjogBSpnWPdiS9MRWrUZx4Bpg@mail.gmail.com>
References: <1337009718-1164-1-git-send-email-felipe.contreras@gmail.com>
	<7vvcjyhd5n.fsf@alter.siamese.dyndns.org>
	<CAMP44s1pb+J_SAzZ66QVcWq4V=LauUQ2VmzMD8KBtnhjubkkVg@mail.gmail.com>
	<7vmx5ahbrm.fsf@alter.siamese.dyndns.org>
	<CAMP44s1h=MPT8vx6JrGjMZWJzRjndxYKoYgo+1Y_Mmv+gWXzaQ@mail.gmail.com>
	<7vaa1ah95p.fsf@alter.siamese.dyndns.org>
	<CAMP44s2L=s4bd-sDcY3RWLWe9=YzLgC7UavgnE6K0akMCJSK4w@mail.gmail.com>
	<7v62bxfkeh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Thomas Rast <trast@student.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 16 17:25:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SUg6w-0003Pt-3T
	for gcvg-git-2@plane.gmane.org; Wed, 16 May 2012 17:25:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755013Ab2EPPZx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 May 2012 11:25:53 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:32965 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754131Ab2EPPZw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 May 2012 11:25:52 -0400
Received: by lbbgm6 with SMTP id gm6so600596lbb.19
        for <git@vger.kernel.org>; Wed, 16 May 2012 08:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=vcE3GVpWG3QH9ykg9L6bmVyMzZy71MvCgSFUo/4msrA=;
        b=Y1cy11aEOrbrny1RsVLcRiUkwlQVpsglB6Tg+ABfNbrO1mGhIfig7NIP2iBg/eQ2oB
         MgANvwUnmC5tsW8kBcrOkcxXmuI1TOQQdd0/4znwAdamTpw1tW7sv3Ylkyf71iDghbCb
         Z0sjZUWCDTRXUUmtwmpDOu2eKnFuJArw8HTHLUUT8plD5GcwDIQHc3tIFXpoaIL1h+sC
         X6JnBEL9asic3IdaQDsYfJGJvWgJzlK+2W/8hYFf36Sh+BEq28MZMu5YxJS/EjS2oyAB
         PCx4zF08q5mB2qHOGZAhsIks4SlRhwyWb46IbcukhdBn0P2rwCarOKfZCyl0eipjFa4c
         ATUA==
Received: by 10.112.40.5 with SMTP id t5mr1506644lbk.55.1337181950562; Wed, 16
 May 2012 08:25:50 -0700 (PDT)
Received: by 10.112.107.65 with HTTP; Wed, 16 May 2012 08:25:50 -0700 (PDT)
In-Reply-To: <7v62bxfkeh.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197884>

On Tue, May 15, 2012 at 7:01 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:

>> Is there something actionable?
>
> Like adding an explanation, preferrably a better one, there, so that the
> next person do not have to wonder and waste time like I did?

The next person that does what? Review the code while keeping an eye
on the way the variable arguments are used inside the implementation
of the function? I don't think there will *ever* be such a person
after the code is committed.

Either way, I believe in the notion of self-documenting code, so I
would rather add a few double quotes rather than add an essay on top
of the function just for you.

Not everything in the code needs to be documented, and most
documentation in the code is ignored anyway, and for a good example
take a look at the code in the Linux kernel.

Cheers.

-- 
Felipe Contreras
