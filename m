From: Vijay Lakshminarayanan <laksvij@gmail.com>
Subject: Re: rev-list --cherry-pick and context lines
Date: Fri, 02 Sep 2011 23:44:39 +0530
Message-ID: <87ty8udd68.fsf@gmail.com>
References: <1k6zcbk.ov5qevxc1a91M%lists@haller-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@drmicha.warpmail.net (Michael J Gruber), git@vger.kernel.org
To: lists@haller-berlin.de (Stefan Haller)
X-From: git-owner@vger.kernel.org Fri Sep 02 20:14:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QzYGT-000519-HM
	for gcvg-git-2@lo.gmane.org; Fri, 02 Sep 2011 20:14:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753869Ab1IBSOq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Sep 2011 14:14:46 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:65337 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753661Ab1IBSOp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Sep 2011 14:14:45 -0400
Received: by pzk37 with SMTP id 37so4847602pzk.1
        for <git@vger.kernel.org>; Fri, 02 Sep 2011 11:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=43kXAKAmJQbbQHjWCQp5trNYNJi1BofM/MxZycs6grE=;
        b=L5rjcV2tgvAr5AIOXB41ExeuK6YVwUXnWTE99H4qOq2BWSCHrMn7Q3CVBd/ubmrCHU
         40IIf/ic2E6jlmFTFgu1mTwA9s2aGRIN//Vv5qyIQY+uYBGgjc4CRTEA/KqNq1EQrAwt
         zH8oecQhhvnBv6Xt2nsZQyMizmo2ouFzt+4sE=
Received: by 10.68.1.138 with SMTP id 10mr2483792pbm.138.1314987285195;
        Fri, 02 Sep 2011 11:14:45 -0700 (PDT)
Received: from BALROG ([59.92.79.237])
        by mx.google.com with ESMTPS id t7sm11630941pbn.11.2011.09.02.11.14.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 02 Sep 2011 11:14:44 -0700 (PDT)
In-Reply-To: <1k6zcbk.ov5qevxc1a91M%lists@haller-berlin.de> (Stefan Haller's
	message of "Fri, 2 Sep 2011 18:33:06 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (windows-nt)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180627>

lists@haller-berlin.de (Stefan Haller) writes:

> Is there a reason why the hard-coded default is 3 in the current code?

3 is the default context for GNU diff (and possibly other diff
implementations also).

> Thanks,
>    Stefan

-- 
Cheers
~vijay
