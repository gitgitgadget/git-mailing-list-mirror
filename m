From: Alex Henrie <alexhenrie24@gmail.com>
Subject: Re: [PATCH] gitk: l10n: Update Catalan translation
Date: Tue, 6 Oct 2015 09:42:05 -0600
Message-ID: <CAMMLpeSMLjzq-8kkSx-shJGqVS1ZHsC=nKG5pOSyyz7ymnE95w@mail.gmail.com>
References: <1444105572-20580-1-git-send-email-alexhenrie24@gmail.com> <xmqqk2r0wo8g.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Paul Mackerras <paulus@samba.org>,
	Git mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 06 17:42:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZjUNq-0000YG-RA
	for gcvg-git-2@plane.gmane.org; Tue, 06 Oct 2015 17:42:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753185AbbJFPm0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Oct 2015 11:42:26 -0400
Received: from mail-wi0-f169.google.com ([209.85.212.169]:33509 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752293AbbJFPmZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Oct 2015 11:42:25 -0400
Received: by wiclk2 with SMTP id lk2so173668852wic.0
        for <git@vger.kernel.org>; Tue, 06 Oct 2015 08:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=vJDhEKRPu/lA8+oNX6vO1/QO1A3MkQENp30+ogE9qNI=;
        b=HtjWQrbh56A7n/iHUNN0q2b40bLn9S/NfqWJGrgth46bVhsYuY+6cWlu5VWD227zFg
         hJfk121UUlzE5ArnlMttSk9Op+MA70QGPXryIyjSZDnLJzQb5PqiBGYp0+qrKU//xIjr
         DFlJ3t0kcLtFXcWsHOK7FvlfGvyZJRlPjL0UxAnbTpsdMXvtTUW8b2W8MmXS0TAMPyKc
         44wxXJMgHCZz7XswrJ3i8/RYVfDH88a3TCtjyCDzxlMBPTPLslnjIkIXrx2iWl7Zic/q
         L7aGcTn0NzUuI0zpFPYPv/JytlMgQ1jhQC0axkzP3MGFbuxOTFulT9e3HTrk8CdnOdFT
         HzgA==
X-Received: by 10.180.86.39 with SMTP id m7mr19504637wiz.91.1444146144500;
 Tue, 06 Oct 2015 08:42:24 -0700 (PDT)
Received: by 10.28.16.211 with HTTP; Tue, 6 Oct 2015 08:42:05 -0700 (PDT)
In-Reply-To: <xmqqk2r0wo8g.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279153>

2015-10-05 23:38 GMT-06:00 Junio C Hamano <gitster@pobox.com>:
> Alex Henrie <alexhenrie24@gmail.com> writes:
>
>> The gitk included in git 2.6.0 crashes if run from a Catalan locale.
>> I'm hoping that a translation update will fix this.
>
> I seriously hope that l10n files would not "crash" applications.
>
> I wonder if you are hitting $gmane/278863 perhaps?

I really don't know. Gmane bug 278863, "In Low Screen Heights (768 px)
Konsole always opens as full-height (even after resized)", appears to
be unrelated. But the crashing stopped today, either from rebooting or
from a package upgrade, so I guess it's not a real bug.

At any rate, the translation update is still worth committing.

-Alex
