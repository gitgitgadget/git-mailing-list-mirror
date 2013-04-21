From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 4/5] git-log.txt: rewrite note on why "--" may be required
Date: Sun, 21 Apr 2013 13:30:06 +0530
Message-ID: <CALkWK0kEngwYQieR=Xmvzu+XqBe+ZFxiWj0C8M-euFavDDaD2Q@mail.gmail.com>
References: <1366458313-7186-1-git-send-email-artagnon@gmail.com>
 <1366458313-7186-5-git-send-email-artagnon@gmail.com> <7vtxn0wf4j.fsf@alter.siamese.dyndns.org>
 <CALkWK0nFAzPPb0_jTRev6nuicCV81sRQAbe=277nhyyY8TnQ7A@mail.gmail.com>
 <7v8v4cwd6g.fsf@alter.siamese.dyndns.org> <CALkWK0kiT7vggXgqGs2iiMooiw7TyJEgr2=Yy06S7H1NKiWJ3g@mail.gmail.com>
 <7vzjwsuxzp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Thomas Rast <trast@inf.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 21 10:00:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTpCe-0005aN-Gj
	for gcvg-git-2@plane.gmane.org; Sun, 21 Apr 2013 10:00:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752020Ab3DUIAr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Apr 2013 04:00:47 -0400
Received: from mail-ia0-f176.google.com ([209.85.210.176]:46414 "EHLO
	mail-ia0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751637Ab3DUIAq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Apr 2013 04:00:46 -0400
Received: by mail-ia0-f176.google.com with SMTP id i9so4451250iad.7
        for <git@vger.kernel.org>; Sun, 21 Apr 2013 01:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=EjgXUocwCAzMWGeJ8m+Un05Gsqliwee+8fP09K79L9I=;
        b=wUnzZYmNywTArWvktDzmiHR3a+JXPk+D+BvmBiK/3JtA56+grkKqLFZ4piBGco9y65
         OTo2XIiPNwK7t8Js07nK91xuimCwXg7lCpslpGhSbqaUE2CcGKAvr5n3eQ5VjaClw40A
         mmSabLzksWK73vBsRTjR8wg5X8dl/LiHC2ouazYwN6EOMn6cY4HqFMvZd3AVXgU0alvV
         cSoeGEeV+Ptww8YhjALnlwhSg56Stcmv9NLFNXRc4OAhnqxYL+D9vyLE5PyKhNonuF8Q
         br3ugMcB3DmCHSX1SWCqwMx1YmJQuf02mRccfolSEpWi5/RjZ8UPgBVk/RU2zNGH9O2F
         1s1A==
X-Received: by 10.50.108.235 with SMTP id hn11mr12298125igb.107.1366531246274;
 Sun, 21 Apr 2013 01:00:46 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Sun, 21 Apr 2013 01:00:06 -0700 (PDT)
In-Reply-To: <7vzjwsuxzp.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221913>

Junio C Hamano wrote:
> Sounds like a bug, if it doesn't.
>
> Patches welcome---I suspect that it can be solved the same way as
> the recent cherry-pick patch by Miklos.

It's not as pressing as the glaring Documentation inaccuracies, so
I'll queue the task.

To exclude this case, I would say the most technically accurate
description of what 'git log' takes is a "committish range" (basically
a "revision range" that resolves to commits).
