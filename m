From: Nathan Gray <n8gray@n8gray.org>
Subject: Re: Please discuss: what "git push" should do when you do not say
 what to push?
Date: Tue, 20 Mar 2012 00:13:31 -0700
Message-ID: <CA+7g9JzfFg9U9qiWtjX5OgA5c=dS1bPWaXqMbmxAtzaQeKRF8Q@mail.gmail.com>
References: <7v7gyjersg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 20 08:13:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9tGE-0006fZ-TR
	for gcvg-git-2@plane.gmane.org; Tue, 20 Mar 2012 08:13:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755983Ab2CTHNe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Mar 2012 03:13:34 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:62010 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755906Ab2CTHNd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Mar 2012 03:13:33 -0400
Received: by bkcik5 with SMTP id ik5so4854150bkc.19
        for <git@vger.kernel.org>; Tue, 20 Mar 2012 00:13:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-originating-ip:in-reply-to:references:date
         :message-id:subject:from:to:content-type:x-gm-message-state;
        bh=0X7yNNYF5+5wLQQ7085itH8K4PeKjcv2R1O/zvbMz9Y=;
        b=dUOYu1JiKryaU2pvo8MMYa5LnPTlUkE7HpC7kLkefEhCCFjWbvHee8IFPW1xQ5ElBG
         d2qmQRe9P+1ax9hn8xBUCb1Ghi7r7R2J41YcZq3LPLBG9NOTiIReBYPoJyE4JAChzpcL
         0M04SSi4v+VychP5y8S1mqFHgskXrr7smN+PgDOOL9PDGsizVnjEGqJpkloIW+ngzs9f
         Ihjgi/FYbrhT923coi4n4bjavor5hFa5nfyuSvRCGz3nByzTWAL1fFwzPz70xLubai7j
         mquLeGwbwzABNWtesfmu+dUQirxOEyCvFvJEmsoQgiQum4d3k2BIx17y/cvBshyBaTTF
         w8Ew==
Received: by 10.205.124.20 with SMTP id gm20mr5801302bkc.111.1332227611786;
 Tue, 20 Mar 2012 00:13:31 -0700 (PDT)
Received: by 10.205.34.9 with HTTP; Tue, 20 Mar 2012 00:13:31 -0700 (PDT)
X-Originating-IP: [66.75.229.176]
In-Reply-To: <7v7gyjersg.fsf@alter.siamese.dyndns.org>
X-Gm-Message-State: ALoCoQljefATPI+Z6RPR7T7dKEJaPy5TSnQU3S4WkN1RvL7svkiepWArWgaedY3SM1E4cgYG+zg9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193486>

On Fri, Mar 16, 2012 at 10:10 PM, Junio C Hamano <gitster@pobox.com> wrote:
> There is a proposal to change the default behaviour of 'git push' on the
> Git mailing list. The goal of this message is to encourage you to discuss
> it before it happens (or the change is aborted, depending on the outcome
> of the discussion).
>
> In the current setting (i.e. push.default=matching), 'git push' without
> argument will push all branches that exist locally and remotely with the
> same name. This is usually appropriate when a developer pushes to his own
> public repository, but may be confusing if not dangerous when using a
> shared repository. The proposal is to change the default to 'upstream',
> i.e. push only the current branch, and push it to the branch 'git pull'
> would pull from. Another candidate is 'current'; this pushes only the
> current branch to the remote branch of the same name.

+1 for 'upstream'.  "Push" should mirror "pull" by the principle of
least surprise.

Cheers,
-Nathan

-- 
http://n8gray.org
