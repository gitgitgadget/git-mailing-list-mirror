From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [RFC 0/16] Introduce index file format version 5
Date: Thu, 2 Aug 2012 20:53:08 +0700
Message-ID: <CACsJy8ArnHCXsaW8K47OdcWgYe3=jEPukt-c61kOx1raTNvUEA@mail.gmail.com>
References: <1343905326-23790-1-git-send-email-t.gummerer@gmail.com>
 <CACsJy8De=1RR9yAQ79zzNM_iALF1OCB2L9A8pMK_v+ixZqgJug@mail.gmail.com> <20120802134718.GA1000@tgummerer.unibz.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, trast@student.ethz.ch, mhagger@alum.mit.edu,
	gitster@pobox.com, robin.rosenberg@dewire.com
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 02 15:53:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SwvqX-0005yR-Jm
	for gcvg-git-2@plane.gmane.org; Thu, 02 Aug 2012 15:53:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754454Ab2HBNxk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Aug 2012 09:53:40 -0400
Received: from mail-gh0-f174.google.com ([209.85.160.174]:53135 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753792Ab2HBNxj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2012 09:53:39 -0400
Received: by ghrr11 with SMTP id r11so2257856ghr.19
        for <git@vger.kernel.org>; Thu, 02 Aug 2012 06:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=zOKSnlDsVwynn7YyXU5YO+YjneZTMQbxsfp6UN5DbnI=;
        b=hlIDu615I2tfjqp2+fKAyAkStPTqIwBTmwuAkyitiVqPNIOKkbpi9FHZr+g8d9Eskz
         mnbpNijTCP/O2lki0SIKdGLtFzimExQEKolZmDg9+N/dN80sMT0cs/ZHwL3rK7rWKnZg
         Ego2465LYqj4tQNbFfAoY+F18dDYOViduWuUDZRfESMHAx7rtS9CiEFIpyBsG6S25/Jg
         HgV/VTJ6jE/1385o8gnMh5RIyPk6SZF79iMeqDS2Qvu5ada7hKF73fePB8S2zbT4f3TC
         ew12alYQCc/ZOXnu98gF0OY3OWqBU6y5kRzzECrKu6tgOGwssJkUTNDpfjRhhwyRg3Sx
         22Fg==
Received: by 10.50.6.197 with SMTP id d5mr3736010iga.44.1343915618932; Thu, 02
 Aug 2012 06:53:38 -0700 (PDT)
Received: by 10.64.90.2 with HTTP; Thu, 2 Aug 2012 06:53:08 -0700 (PDT)
In-Reply-To: <20120802134718.GA1000@tgummerer.unibz.it>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202776>

On Thu, Aug 2, 2012 at 8:47 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> On 08/02, Nguyen Thai Ngoc Duy wrote:
>> On Thu, Aug 2, 2012 at 6:01 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
>> > Documentation/technical/index-file-format-v5.txt |  281 ++++++++++++++++++++++++++++++++++
>> > builtin/update-index.c                           |    5 +-
>> > cache-tree.c                                     |  145 ++++++++++++++++++
>> > cache-tree.h                                     |    7 +
>> > cache.h                                          |   96 +++++++++++-
>> > read-cache.c                                     | 1519 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------
>> > resolve-undo.c                                   |  129 ++++++++++++++++
>> > resolve-undo.h                                   |    3 +
>> > t/perf/p0002-index.sh                            |   33 ++++
>> > t/t2104-update-index-skip-worktree.sh            |   15 +-
>> > t/t3700-add.sh                                   |    1 +
>> > test-index-version.c                             |    2 +-
>> > 12 files changed, 2082 insertions(+), 154 deletions(-)
>>
>> This is not good (too many pluses in read-cache.c) if it comes from
>> format-patch. Does it?
>
> No this comes from git diff --stat. It's probably just my terminal
> width then?
>

Ah ok. Recent git learns to use much screen estate as possible but
format-patch keep it fit wihtin 75 or so columns.
-- 
Duy
