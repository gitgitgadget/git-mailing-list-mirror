From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3] status: show the branch name if possible in
 in-progress info
Date: Tue, 5 Feb 2013 19:20:51 +0700
Message-ID: <CACsJy8D_kSrJYagxo1LWt=P8XKj9F9_yAwH3vzQWQOi+yvP8kg@mail.gmail.com>
References: <1359471493-32531-1-git-send-email-pclouds@gmail.com>
 <1359870807-22817-1-git-send-email-pclouds@gmail.com> <20130205063847.GA3240@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 05 13:21:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2hX1-0004Eg-3X
	for gcvg-git-2@plane.gmane.org; Tue, 05 Feb 2013 13:21:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755058Ab3BEMVY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2013 07:21:24 -0500
Received: from mail-oa0-f54.google.com ([209.85.219.54]:34614 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755041Ab3BEMVW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2013 07:21:22 -0500
Received: by mail-oa0-f54.google.com with SMTP id n12so69065oag.27
        for <git@vger.kernel.org>; Tue, 05 Feb 2013 04:21:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=4d0CzCY1ydpCgPcET3YsDVOb7RfIxjJVkmWYM83hzMc=;
        b=L7C7OGNmAFjesyYpdgjl1alpAg5fLAKkBLuJBunm5eIenqgbnW9sX74NdN8ZGg0VXO
         uryr3aa0k47y3W7tkHLxcv84/DQy1hDHzuaPx6XnMslg/kqOfN7Dthyf39Hle8U7zwO1
         xhBE6YMZIG1bRClf1Vvy8QYZrTtMRVNpT5b2MVyK+RbXwuSAgpU9sD5WYRayzCGgTN8a
         8kbHaoG8razPItMbnBbOvER/aQ+hekNRW+eYZ6yGgTa7ZSj+WYCq1zCOM3D2TpDlWrgv
         sXI1zzCg6mqB/QyoneVqJPblgj8Y+QoX8p+pTM6R1T+2504/QaXxPRXilkCyYjQjirNb
         vVKw==
X-Received: by 10.182.18.133 with SMTP id w5mr18399061obd.64.1360066881879;
 Tue, 05 Feb 2013 04:21:21 -0800 (PST)
Received: by 10.182.118.229 with HTTP; Tue, 5 Feb 2013 04:20:51 -0800 (PST)
In-Reply-To: <20130205063847.GA3240@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215498>

On Tue, Feb 5, 2013 at 1:38 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Missing description.  Stealing from the link you sent:
>
>         The typical use-case is starting a rebase, do something else, come back
>         the day after, run "git status" or make a new commit and wonder what
>         in the world's going on. Which branch is being rebased is probably the
>         most useful tidbit to help, but the target may help too.
>
>         Ideally, I would have loved to see "rebasing master on origin/master",
>         but the target ref name is not stored during rebase, so this patch
>         writes "rebasing master on a78c8c98b" as a half-measure to remind
>         future users of that potential improvement.
>
>         Signed-off-by: <...>

Looking good. Junio, do you need a new patch mail or can you just
amend the commit message?
-- 
Duy
