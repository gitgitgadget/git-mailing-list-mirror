From: Junio C Hamano <gitster@pobox.com>
Subject: Re: making refs/bisect/ per worktree (was Re: (unknown))
Date: Tue, 01 Sep 2015 09:32:17 -0700
Message-ID: <xmqq7foat81a.fsf@gitster.mtv.corp.google.com>
References: <1441073591-639-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mhagger@alum.mit.edu,
	Christian Couder <christian.couder@gmail.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue Sep 01 18:32:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWoTw-0006dh-TE
	for gcvg-git-2@plane.gmane.org; Tue, 01 Sep 2015 18:32:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752775AbbIAQcU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Sep 2015 12:32:20 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:33323 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752736AbbIAQcT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2015 12:32:19 -0400
Received: by padan5 with SMTP id an5so917601pad.0
        for <git@vger.kernel.org>; Tue, 01 Sep 2015 09:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=FIM3A+0Y++ehQwe7etw8MNEz1haYNT9aKL6FBChiqeA=;
        b=nUCao/Ox8pyVsQnuRRlEW79nwvqSi1Fnr8peyVCgtbJWGD4IzbvuqFazzvWVeBRiIg
         9GclDj2NmrumK5+ZGUIFdDqkOrMJXO59pz/CUDeAFVGD8L0p8Je+n/PYPh5I7RMKiVdw
         7m6lEan1qVNeRKTE0qyNRvaRt3jFDg+0smCOn1cjKB3lxLmkwio/R5DcSbLglHUQXdYE
         MXJLo1AdwC9V6MB/wZa936BqE4uJJsW/mgiHO6b2pgwHEmWddKjK9el7AA12p1mFu/UF
         CpluM+DXv00emfIsmwNIPoHAbSq0gukO5ygT/WDqaR8Yvi8sAR1FE0g8MN7jBfOlTCv2
         pHTQ==
X-Received: by 10.66.234.202 with SMTP id ug10mr49071853pac.50.1441125139195;
        Tue, 01 Sep 2015 09:32:19 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:c585:9fe7:e0d8:e718])
        by smtp.gmail.com with ESMTPSA id rb2sm18777013pab.8.2015.09.01.09.32.18
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 01 Sep 2015 09:32:18 -0700 (PDT)
In-Reply-To: <1441073591-639-1-git-send-email-dturner@twopensource.com> (David
	Turner's message of "Mon, 31 Aug 2015 22:13:08 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276989>

David Turner <dturner@twopensource.com> writes:

> This version of the patch series squashes in Junio's comment fix and
> the xstrndup fix.
>
> In addition, it removes refs/worktree, and just makes refs/bisect
> per-worktree.  If we later discover that other things need to be
> per-worktree, we can do refs/worktree, but for now, this is
> backwards-compatible so we'll do this.

I've already squashed the "make common_list[] static" from Ramsay
into 1/3, so no need to resend for that one.

Let's wait for a few days to see if people spot any more issues,
merge to and cook in 'next' for the remainder of this cycle, and aim
to merge this down to 'master' in the first batch after the upcoming
release.

Thanks.
