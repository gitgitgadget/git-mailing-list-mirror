From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 0/5] Sequencer: working around historical mistakes
Date: Sat, 5 Nov 2011 18:43:12 -0500
Message-ID: <20111105234312.GB27272@elie.hsd1.il.comcast.net>
References: <1320510586-3940-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 06 00:43:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMptf-000833-4Y
	for gcvg-git-2@lo.gmane.org; Sun, 06 Nov 2011 00:43:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752167Ab1KEXnX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Nov 2011 19:43:23 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:37989 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751954Ab1KEXnW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Nov 2011 19:43:22 -0400
Received: by ywf7 with SMTP id 7so3877849ywf.19
        for <git@vger.kernel.org>; Sat, 05 Nov 2011 16:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=kq+tZyxchVPSuPVFErGO7mfUZUe+0BMbVrjM8Rq0Hk8=;
        b=Zf8mMYWp57Pf7YxeTQJyqkF2/ZHLFCBPuF+jq0jFzSbR4xswfLCFxbozSsDfzvkzs/
         KnwerIW4+DPC6ihWbOukatL2/AB38lmtDpHSHmczUe2yICFELsfB8hQz/BaXNs7BlQK8
         U3KeXQN+GSu/107nqF77fxb/MWTSctCNrOiO8=
Received: by 10.50.169.97 with SMTP id ad1mr26708236igc.35.1320536601809;
        Sat, 05 Nov 2011 16:43:21 -0700 (PDT)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id bu33sm30253821ibb.11.2011.11.05.16.43.20
        (version=SSLv3 cipher=OTHER);
        Sat, 05 Nov 2011 16:43:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1320510586-3940-1-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184878>

Hey,

Ramkumar Ramachandra wrote:

> As described in the discussion following $gmane/179304/focus=179383,
> we have decided to handle historical hacks in the sequencer itself.
> This series that follows is one step in the right direction.

I'm not sure what the above means.  But let's see what the patches
say. :)

[...]
> 2. This series depends on rr/revert-cherry-pick, but doesn't apply to
> the current 'next'- sorry, rebasing is a massive pita due to 1/5.

Shouldn't it be based against rr/revert-cherry-pick, rather than
"next" which is more of a moving target?

Thanks,
Jonathan
