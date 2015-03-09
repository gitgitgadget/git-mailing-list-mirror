From: Matthew Rothenberg <mrothenberg@gmail.com>
Subject: Re: Efficient parsing of `status -z` output
Date: Sun, 8 Mar 2015 21:41:08 -0400
Message-ID: <CAMJduDvDO4GesL+eru3h1YHrbF5hFmyycX3f4ADQOo+VnD7GDg@mail.gmail.com>
References: <CAMJduDuxBDoJ9_ETY8FCRoANf+taAS7-1acf5CFRGXDFyL72Rg@mail.gmail.com>
 <xmqqlhj7sy7l.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 09 02:42:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUmhu-00050U-S4
	for gcvg-git-2@plane.gmane.org; Mon, 09 Mar 2015 02:42:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752933AbbCIBla (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Mar 2015 21:41:30 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:38033 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751632AbbCIBl3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2015 21:41:29 -0400
Received: by iecrl12 with SMTP id rl12so16362999iec.5
        for <git@vger.kernel.org>; Sun, 08 Mar 2015 18:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=g745xvKig3RznF/O3Iw/5fSJaYjO7QL/QzilwBksl2o=;
        b=cCkujZ2U6AL+JhTHsjT0/DTEh6sEunzMcobVRkh4u1ypJ99cOg9zvB9uad8xWFGWor
         HD0Fz0Syj9BeCtqD0QcYnC5ZzZLPZdbuhT2I5d+w7PpMKLGNTMww1yz6T8H+tmffCuNa
         VsVeP0zq5u8KvAIPwJqPJboV32CE7X6+rHtxGGieLSbuAeJ1TbQPHqt3v1HTtIqGP97e
         09UajhTiOvugQ0HVIEcQV+osUZzdOXBVx3IjcHPRCYlJ2XxJL5TuGoPOCrNTqKPk2Iqj
         mBSmovFTTsU/PylxDPKe7LEK9JqKiqqK58lSAhwtZd2mSCPD2fpSU8lpTX592Oytv4uw
         yFcw==
X-Received: by 10.42.92.16 with SMTP id r16mr22996997icm.95.1425865289274;
 Sun, 08 Mar 2015 18:41:29 -0700 (PDT)
Received: by 10.36.25.74 with HTTP; Sun, 8 Mar 2015 18:41:08 -0700 (PDT)
In-Reply-To: <xmqqlhj7sy7l.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265123>

On Sun, Mar 8, 2015 at 4:14 AM, Junio C Hamano <gitster@pobox.com> wrote:
> I think this is how -z was designed to be used, and if that isn't
> clear, then the documentation must be updated to clarify.  Rename
> and Copy are the only ones that needs two pathnames, and I suspect
> that whoever did the original description of the short format in the
> documentation knew Git too well that he forgot to mention it ;-)

I see, thank you. But how would one ever get a copy operation to show
up in the output of `git status -z` to begin with? It appears copies
are only detected in `diff` and `show`, can be forced with the
--find-copies-harder option, but that `git status` does not appear to
take that option nor detect copies in any way that I can get it to
replicate and output that status code to me... a test case would be
great if you know one, thanks!
