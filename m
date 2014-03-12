From: Yuxuan Shui <yshuiv7@gmail.com>
Subject: GSoC proposal: port pack bitmap support to libgit2.
Date: Wed, 12 Mar 2014 16:19:23 +0800
Message-ID: <CAGqt0zz1W1k92B+XRWEmMEv1=iyej+zi9QUCp2EhA=g+VnCt0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: peff@peff.net, tanoku@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 12 09:19:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNeOE-0002iD-Nq
	for gcvg-git-2@plane.gmane.org; Wed, 12 Mar 2014 09:19:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756434AbaCLIT1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2014 04:19:27 -0400
Received: from mail-vc0-f195.google.com ([209.85.220.195]:53122 "EHLO
	mail-vc0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756336AbaCLITY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2014 04:19:24 -0400
Received: by mail-vc0-f195.google.com with SMTP id lg15so1275859vcb.10
        for <git@vger.kernel.org>; Wed, 12 Mar 2014 01:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=KoEc0D5cn1kqz3mdKfvXbgIVwwYKA6Vp2tu1BPo0NQo=;
        b=wIxU6hNe+3dOP+oniJCRMZgtZkKlhA+s9HQoUcI6VdKmvlOp0fF4Cl5L8n0fLTh2CI
         T+b6KRPJWXVl95bZZBNy1kZELwu9aljplep2wbAB4KOkA6QnMaBBBNWaAptQ+qZUfVuI
         wlSsTbC+Fcp1pIlLCRspfh8u3UJGw2POqE/mxD2sIwoVhlQdLEhE8W515DcxaHzaZOe/
         r11WpG8ZreU0v7SA2gTPg2oYB+wnRjAK4C42Ae9IN4MK7N/Pa4WSzIXOFW0uJ2sig/U9
         4KC0Ej3ZcovUhPkj5s8sAaHIZcx66uIYLgc46hSCnhmDHiPcaZLIrDslAcVjj112Qw9n
         oYLA==
X-Received: by 10.52.250.236 with SMTP id zf12mr29759310vdc.9.1394612363896;
 Wed, 12 Mar 2014 01:19:23 -0700 (PDT)
Received: by 10.220.89.209 with HTTP; Wed, 12 Mar 2014 01:19:23 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243925>

Hi,

I'm Yuxuan Shui, a undergraduate student from China. I'm applying for
GSoC 2014, and here is my proposal:

I found this idea on the ideas page, and did some research about it.
The pack bitmap patchset add a new .bitmap file for every pack file
which contains the reachability information of selected commits. This
information is used to speed up git fetching and cloning, and produce
a very convincing results.

The goal of my project is to port the pack bitmap implementation in
core git to libgit2, so users of libgit2 could benefit from this
optimization as well.

Please let me know if my proposal makes sense, thanks.

P.S. I've submitted by microproject patch[1], but haven't received any
response yet.

[1]: http://thread.gmane.org/gmane.comp.version-control.git/243854

-- 
Regards
Yuxuan Shui
