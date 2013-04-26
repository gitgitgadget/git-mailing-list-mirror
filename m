From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 00/20] remote-bzr: massive changes
Date: Thu, 25 Apr 2013 21:35:16 -0500
Message-ID: <CAMP44s0XHXbX5brcxv-NROJ=PSSzi3oEzQv81=f3-1-zcypQuQ@mail.gmail.com>
References: <1366938488-25425-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 26 04:35:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVYVZ-00035Z-U6
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 04:35:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932201Ab3DZCfT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 22:35:19 -0400
Received: from mail-la0-f49.google.com ([209.85.215.49]:43319 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757190Ab3DZCfS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 22:35:18 -0400
Received: by mail-la0-f49.google.com with SMTP id fp13so919908lab.22
        for <git@vger.kernel.org>; Thu, 25 Apr 2013 19:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=MwN/GXteN8q9bt/QMlhN/VAmjGzoEx8iXmD4BqolFr0=;
        b=vnfIdlHgulqGmyhEEU8mKHVdTeX4hgjyNBMAqQ5eEmHEAjYInY9F+wGk/d0Ar51cMI
         F1h2ssFfOKgkKKlPQkrGAHXHMeVRx6N5sryh7ita79dm6iWwEpLoZILnK017D3kliTuw
         Px900E5D7GwwvWbkGBvY7FT50zEzN9OQCkzeEQ71iZu/CuFMlB/LFfvgSGJ71HD4TbWX
         WuDwobJ7TFx7JL8gQaVizj7FHDuEJ2i5rh05B4D75TR2Hbn2KD/xTbI7x0DvFxgGVeYe
         FRtcN2bApGvUnaAtP2ceVm0qMpdWAosxtjF26rZW6UOxLWIgOU00h8UjBugJvDci1z9f
         lB4w==
X-Received: by 10.112.140.100 with SMTP id rf4mr12036454lbb.82.1366943716335;
 Thu, 25 Apr 2013 19:35:16 -0700 (PDT)
Received: by 10.114.83.167 with HTTP; Thu, 25 Apr 2013 19:35:16 -0700 (PDT)
In-Reply-To: <1366938488-25425-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222505>

On Thu, Apr 25, 2013 at 8:07 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:

I forgot to mention; these apply on top of the previous 'fixes and cleanups'.

> Felipe Contreras (20):
>   remote-bzr: cleanup CustomTree
>   remote-bzr: delay blob fetching until the very end
>   remote-bzr: fix order of locking in CustomTree
>   remote-bzr: always try to update the worktree
>   remote-bzr: add support to push merges
>   remote-bzr: fixes for branch diverge
>   remote-bzr: fix partially pushed merge
>   remote-bzr: use branch variable when appropriate
>   remote-bzr: add support for bzr repos
>   remote-bzr: fix branch names
>   remote-bzr: add support for shared repo
>   remote-bzr: split marks file
>   remote-bzr: improve author sanitazion
>   remote-bzr: add custom method to find branches
>   remote-bzr: add option to specify branches
>   remote-bzr: improve progress reporting
>   remote-bzr: iterate revisions properly
>   remote-bzr: delay peer branch usage
>   remote-bzr: access branches only when needed
>   remote-bzr: export HEAD
>
>  contrib/remote-helpers/git-remote-bzr | 365 +++++++++++++++++++++++++---------
>  contrib/remote-helpers/test-bzr.sh    |  36 ++++
>  2 files changed, 302 insertions(+), 99 deletions(-)

-- 
Felipe Contreras
