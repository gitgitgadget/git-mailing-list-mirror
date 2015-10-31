From: Edmundo Carmona Antoranz <eantoranz@gmail.com>
Subject: Re: [PATCH] checkout: add --progress option
Date: Sat, 31 Oct 2015 11:42:19 -0600
Message-ID: <CAOc6eta7_0RfBUngtMg5ZAEUvjuPVgZ20ESgnbJK=--h53k+Tw@mail.gmail.com>
References: <1446168186-4730-1-git-send-email-eantoranz@gmail.com>
	<CAPig+cTvRs_O8uY9_SrZZCf95Lraon8knkQUDgm0Lke3pve01A@mail.gmail.com>
	<xmqqh9l8kxa3.fsf@gitster.mtv.corp.google.com>
	<20151030193151.GB5336@sigill.intra.peff.net>
	<xmqq4mh8kv0e.fsf@gitster.mtv.corp.google.com>
	<CAOc6etYiqH8bvnCD_9hedzDW6fhknXLGesM6dX7S9DBB_r-9zA@mail.gmail.com>
	<CAOc6etYCzBYpf+7p8p3=zQun7bYXYVc-codoUf5Abcq+hAz8cA@mail.gmail.com>
	<xmqqk2q3hrbl.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 31 18:42:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZsaAZ-0000S1-Lm
	for gcvg-git-2@plane.gmane.org; Sat, 31 Oct 2015 18:42:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752049AbbJaRmV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Oct 2015 13:42:21 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:36774 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751478AbbJaRmT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Oct 2015 13:42:19 -0400
Received: by pacfv9 with SMTP id fv9so108673855pac.3
        for <git@vger.kernel.org>; Sat, 31 Oct 2015 10:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=VNOUC2p7md/t2V6jmwy10N/L9R9BK4lwUKta7QCdrJ4=;
        b=jvdhN/Ou4fjNjG0R+SgHQEoyGquFU5kLAtboQGMg5rmCJBRYDPFeOjNRwX2X8i4A47
         XltcbEQAPVyOp5Be2ulea2agJqtwp5iq2kUqrpGp30wW46+5fx7vrxLI0lksWPKDea+O
         fEUfpmvuOYTHHGyQa0F+tZ/lgTRwRhUiCcW0ay6D9yledLoBn/PjAbp8FfkgKzF4YIcC
         DUpPMqym9TbFt5Oy40N4tao/fQL+dpGhxXzCd537r3nHgVzSGv4fTIHORJgWLr6FCA01
         gsVRATerYx6dHNOZej8EVBxiQmm0cVNIlves1tBFqr5Vc/kMYgy7ceK71dZe+jH9guUp
         DKNA==
X-Received: by 10.66.55.42 with SMTP id o10mr16070016pap.124.1446313339195;
 Sat, 31 Oct 2015 10:42:19 -0700 (PDT)
Received: by 10.66.149.4 with HTTP; Sat, 31 Oct 2015 10:42:19 -0700 (PDT)
In-Reply-To: <xmqqk2q3hrbl.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280594>

On Sat, Oct 31, 2015 at 11:37 AM, Junio C Hamano <gitster@pobox.com> wrote:
> I do find what Peff showed us a lot easier to follow.
>
>         if (opts.show_progress < 0) {
>                 if (opts.quiet)
>                         opts.show_progress = 0;
>                 else
>                         opts.show_progress = isatty(2);
>         }
>

Ok.... let me rewrite it that way. Other than that, the other things are ok?
