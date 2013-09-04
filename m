From: William Swanson <swansontec@gmail.com>
Subject: Re: Officially start moving to the term 'staging area'
Date: Tue, 3 Sep 2013 23:08:44 -0700
Message-ID: <CABjHNoR637ecLnnLwhj59ddnhy8Lcyk+2YzAqN=nxWN7-BkivA@mail.gmail.com>
References: <20130829180129.GA4880@nysa>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 04 08:08:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VH6Gq-0000NJ-D5
	for gcvg-git-2@plane.gmane.org; Wed, 04 Sep 2013 08:08:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761388Ab3IDGIq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Sep 2013 02:08:46 -0400
Received: from mail-wi0-f182.google.com ([209.85.212.182]:44080 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761946Ab3IDGIp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Sep 2013 02:08:45 -0400
Received: by mail-wi0-f182.google.com with SMTP id ez12so3549785wid.15
        for <git@vger.kernel.org>; Tue, 03 Sep 2013 23:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=kqgwTl8r2gAvHJ7sjJ0Wf2E0lLhsZe2anqeeudCsYYA=;
        b=VevBSgnCdQmfRDIYGEfk954G7YXY1QuiEkH+eE6xNV+IKdoVWDJXQq4mrQnEzcKeeE
         VMAmGUYQNEA17tTLYzWB/2qY28u3PE513PtHlAoLFieoIRnBOKmfEDo+ZmzI8PQ99Dd9
         jJMzYaltBmEGgvFs3YmfGwh123pI7vWnFg3EwYX675OwJWHkdcp5S2CWYzsQhdX6CUOR
         oq9JKWDkdZkc39B33VayT/gX5R9Pawb4SRQrAWXvPOCElgqPpCEMYWdaMrKz7oTjAcge
         tWQgzIUuiZfmH8LApAmvO1HPrcrI+7bStve1Qm4UptI6zFKLsCe/2wAmVGblt5twWN5n
         Aaxg==
X-Received: by 10.180.12.243 with SMTP id b19mr713761wic.18.1378274924465;
 Tue, 03 Sep 2013 23:08:44 -0700 (PDT)
Received: by 10.216.245.6 with HTTP; Tue, 3 Sep 2013 23:08:44 -0700 (PDT)
In-Reply-To: <20130829180129.GA4880@nysa>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233805>

On Thu, Aug 29, 2013 at 11:01 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> It has been discussed many times in the past that 'index' is not an
> appropriate description for what the high-level user does with it, and
> it has been agreed that 'staging area' is the best term.

I realize Git is not a democracy, but if the vote of a humble user
counts for anything, I agree that "index" is a terrible name.

I was very excited when Felipe first started this thread, since I
thought Git might finally fix one of it's biggest long-standing
usability problems. Calling this thing the "index" is like calling an
important variable "someValue." While the name may be technically
correct, it's way too generic to be useful. A name like "staging area"
may not capture the whole idea, but at least it provides a good clue
about what it does and how you might use it.

If we change this, I'm pretty sure most of the Internet will rejoice.
Only a few old-timers will be grumpy, but that's just because they
don't like change in general. I have never met anybody (outside this
thread) who thought the current name was a good idea.

-William
