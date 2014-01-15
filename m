From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Diagnosing stray/stale .keep files -- explore what is in a pack?
Date: Wed, 15 Jan 2014 08:42:26 -0500
Message-ID: <CACPiFCKeOYHUb22d_Ea0PcbU-uAn=fVAn0QP1qbLAiNh1KEoqQ@mail.gmail.com>
References: <CACPiFCLa3X-Xt5GwrHHA-PFj-Bi9_sW+=y2xidZ7tDbFfM26rA@mail.gmail.com>
 <CACPiFCJVx0dkkPQ=LosbAAKq7CvK6_yQL5QDHMYr5oJAS6wb6Q@mail.gmail.com>
 <201401141236.44393.mfick@codeaurora.org> <CACPiFCLxiCOqv=wLeq9LxisWn5T62hk8xDYwXmeFRNT05HY0iQ@mail.gmail.com>
 <20140115091220.GB14335@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Martin Fick <mfick@codeaurora.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 15 14:42:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3Qk8-0007gk-Kr
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jan 2014 14:42:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751735AbaAONmt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jan 2014 08:42:49 -0500
Received: from mail-we0-f176.google.com ([74.125.82.176]:44873 "EHLO
	mail-we0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751553AbaAONms (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jan 2014 08:42:48 -0500
Received: by mail-we0-f176.google.com with SMTP id q58so1795008wes.35
        for <git@vger.kernel.org>; Wed, 15 Jan 2014 05:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=09HaC8JUyaf+jY+9/Z+bHOwq1VrmKbfES25CxqWdoyE=;
        b=Zo1ctaoZvHDeoULrB7wLTNaMhmCOy6wx2sOAEjNqkUQaEOOJrB58AON1HS9e+eY8GV
         EXdVL/fh8dWzRMGzG6FUzsLBh00N/0k5EejEDmhr5KAXLnqKGlXI1ZizkJIb5abiJvD2
         91DXMEQer1mtIJfa3gQlOD+SIOoUyZXQm/Y2c2aHAWtAGbzAAKhv8CVGzNzep/3njqfJ
         UZdsUQgXTshknqpc/ExzLqNtk5W9uvV6UDqTOjcmwD5pC6CdcoeXLLz8dCVKcOm5ftaD
         Sgo4BK5BHvQURrgTqA2wAYNhbJAP4w4HMaCkGhAVpns2H8z/B4Fduxqq+bm4ljfkZwm1
         H/Yg==
X-Received: by 10.180.39.43 with SMTP id m11mr2529369wik.8.1389793366577; Wed,
 15 Jan 2014 05:42:46 -0800 (PST)
Received: by 10.216.64.66 with HTTP; Wed, 15 Jan 2014 05:42:26 -0800 (PST)
In-Reply-To: <20140115091220.GB14335@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240469>

On Wed, Jan 15, 2014 at 4:12 AM, Jeff King <peff@peff.net> wrote:
> We see these occasionally at GitHub, too. I haven't yet figured out a
> definite cause, though whatever it is, it's relatively rare.

Do you have a cleanup script to safely get rid of stale .keep and
.lock files? I wonder what other stale bits merit a cleanup...

We could draft a 'git-repo-clean' that works akin to git clean (i.e.:
only reports by default), or add it to gc.

cheers,



m
-- 
 martin.langhoff@gmail.com
 -  ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 ~ http://docs.moodle.org/en/User:Martin_Langhoff
