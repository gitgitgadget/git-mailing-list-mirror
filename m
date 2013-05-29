From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 1/3] cherry-pick: add support to copy notes
Date: Wed, 29 May 2013 19:18:48 +0530
Message-ID: <CALkWK0kK+Mbscsue0wwU5QDKXCrw5Q078MCdOVCoJnMZq7T6UA@mail.gmail.com>
References: <1369745947-19416-1-git-send-email-felipe.contreras@gmail.com>
 <1369745947-19416-2-git-send-email-felipe.contreras@gmail.com>
 <7vobbv119k.fsf@alter.siamese.dyndns.org> <87mwrfx9ug.fsf@linux-k42r.v.cablecom.net>
 <51a56bef1b9c2_807b33e1899991@nysa.mail> <877giixl4c.fsf@linux-k42r.v.cablecom.net>
 <CAMP44s3vkJCr2f2zsZU++j4Wqxuefmpt8BQ9dJoP=JtTB=rgkQ@mail.gmail.com>
 <87y5ayqivi.fsf@linux-k42r.v.cablecom.net> <CALkWK0k5+2nebRLZfWFpxyPmptV_Qo3sKwgpbpvN-bK6_S6W3w@mail.gmail.com>
 <CAMP44s2tvUs813hrheWpWXR2G4kMJL4rscEtynaKYvw5a6HCHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thomas Rast <trast@inf.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 29 15:49:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uhgkw-0005pg-46
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 15:49:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966250Ab3E2Nta (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 09:49:30 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:57269 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966077Ab3E2Nt3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 09:49:29 -0400
Received: by mail-ie0-f169.google.com with SMTP id u16so24814126iet.14
        for <git@vger.kernel.org>; Wed, 29 May 2013 06:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Yr2qUogUrA9cuT4BOVPOoIHU5FjU0e2RmcIAzrtJphI=;
        b=W0cqTiVybegu+nqEhsPDtN0dalvpm1cmGNWUwzgQYS++35hQ6zHWiDut+myW6/KwkL
         oHB2nD6UPGZVicGZ0wQVMphHWMNKpuMHckCeDWopaSRa7rFteZcQSjDIZkNF3i/ZdU+q
         xIWdc3WHgTozSpEXq9oVBOj0vsJVZyLMWQcIMRjcxP5rGBm3oetDpqr2G9GCJHmU14gM
         5PX/h/p6GK+KQB9kwxpWxerz1v636g1KihV93jVaSubG9rCAh/AgWF1bHNa/MhLBXn+d
         ms//lnwNq1FT5TKYaH2atqWdgx4+U+7vHmfnk/mhb8RGCdGtW/tOb6udfIKImFstwVDg
         ldRg==
X-Received: by 10.50.171.161 with SMTP id av1mr1259361igc.104.1369835369152;
 Wed, 29 May 2013 06:49:29 -0700 (PDT)
Received: by 10.64.226.135 with HTTP; Wed, 29 May 2013 06:48:48 -0700 (PDT)
In-Reply-To: <CAMP44s2tvUs813hrheWpWXR2G4kMJL4rscEtynaKYvw5a6HCHA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225826>

Felipe Contreras wrote:
> What you are really complaining about is that I don't agree with
> *every* single suggestion you make. And since you made them, they must
> be sensible, and single I don't agree with you, I must not be
> sensible, is that right?

Oh, I have no problems: I reviewed git-related, and it resulted in
massive simplifications and improvements; those threads didn't run
wild.  I was mainly criticizing Thomas' review style (when it comes to
reviewing your patches in particular), and was prodding him to "make
concrete suggestions" in a one-email review, and leave it at that.
What started out as a pointer to the guidelines:

Thomas Rast wrote:
> We've been over this already:
>
>   The body should provide a meaningful commit message, which:

has resulted in this thread running wild.

> There's nothing wrong with me choosing how best to spend my time. Really.

Ofcourse you are.  You have arguably spent it very productively
solving a lot of user issues (especially remote-bzr).

Personally, I try to do the minimum amount of boring work required to
make sure that a good series gets in.  Sometimes this is a little high
(for a recent example, see my pickaxe-doc series).  The result being
that I just won't work on documentation in the future because doing
iterations is so piss boring: the git community needs to recognize
this problem and make amends.
