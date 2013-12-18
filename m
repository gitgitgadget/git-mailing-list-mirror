From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: I have end-of-lifed cvsps
Date: Wed, 18 Dec 2013 11:53:47 -0500
Message-ID: <CACPiFC+W-RiO-YL=Wgs7YzV=z-p97ehfA+64j5F2KbayPAQm8w@mail.gmail.com>
References: <CACPiFCK+Z7dOfO2v29PMKz+Y_fH1++xqMuTquSQ84d8KyjjFeQ@mail.gmail.com>
 <20131212042624.GB8909@thyrsus.com> <CACPiFC+bopf32cgDcQcVpL5vW=3KxmSP8Oh1see4KduQ1BNcPw@mail.gmail.com>
 <52B02DFF.5010408@gmail.com> <20131217140746.GB15010@thyrsus.com>
 <CANQwDwe8AcbCYG5GZcY1tn9BN0x5KWux_CNQY2OWG+qZJ5rS4Q@mail.gmail.com>
 <20131217210255.GA18217@thyrsus.com> <CANQwDwdQZGhR=hhFHe7wRAeNej_F5fHspN7+f-LiJu06utwC-w@mail.gmail.com>
 <20131218002122.GA20152@thyrsus.com> <CANQwDwdgZUWcgyZCWoDni+e9jgQ+8j0Yn_HMxiMn5OHzsRzjwQ@mail.gmail.com>
 <20131218162710.GA3573@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Eric Raymond <esr@thyrsus.com>
X-From: git-owner@vger.kernel.org Wed Dec 18 17:54:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VtKO8-00064L-91
	for gcvg-git-2@plane.gmane.org; Wed, 18 Dec 2013 17:54:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755433Ab3LRQyM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Dec 2013 11:54:12 -0500
Received: from mail-wg0-f53.google.com ([74.125.82.53]:62753 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752031Ab3LRQyK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Dec 2013 11:54:10 -0500
Received: by mail-wg0-f53.google.com with SMTP id k14so7821258wgh.20
        for <git@vger.kernel.org>; Wed, 18 Dec 2013 08:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=WdxbeEqmAEpMpvOBBwTnZOzB9BkdqZDPeE5tP/LpmlA=;
        b=U/UWT647GlKMKVHKnf0D29z00vc9ZmkOvvF4eDPuLDh2vnbW6p0KfSq+HL/tzwuMA3
         ed8fD/8frofL9GszxhkJv9t7JgQRtEjxuOVjuoJq3S7Q6Rml6R10nKHpvint74RCXMeH
         B8/RRTCL4SMcNxnouPsM2/hpjBRxt081e2fedR0WaCCWRKJY5Du/k4+aExAcuHBzFIbn
         XCIIIAzPS/M0/dAFzVwSCWG0a0PTXuhdO5VKv/3cxFF+YrromnXeI0/kX/F8D+tx61te
         rZMIoWE2NKB3jXVtCy4DgocsGI85UwJYL1vNeAql3LhUfHcJ2kYWQEGV/eXzShP+jaK6
         K0Cg==
X-Received: by 10.180.19.165 with SMTP id g5mr8821444wie.31.1387385647502;
 Wed, 18 Dec 2013 08:54:07 -0800 (PST)
Received: by 10.216.172.202 with HTTP; Wed, 18 Dec 2013 08:53:47 -0800 (PST)
In-Reply-To: <20131218162710.GA3573@thyrsus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239457>

On Wed, Dec 18, 2013 at 11:27 AM, Eric S. Raymond <esr@thyrsus.com> wrote:
>> Anyway I hope that incremental CVS import would be needed less
>> and less as CVS is replaced by any more modern version control system.
>
> I agree.  I have never understood why people on this list are attached to it.

I think I have answered this question already once in this thread, and
a few times in similar threads with Eric in the past.

People track CVS repos that they have not control over. Smart
programmers forced to work with a corporate CVS repo. It happens also
with SVN, and witness the popularity of git-svn which can sanely
interact with an "active" svn repo.

This is a valid use case. Hard (impossible?) to support. But there
should be no surprise as to its reasons.

cheers,



m
-- 
 martin.langhoff@gmail.com
 -  ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 ~ http://docs.moodle.org/en/User:Martin_Langhoff
