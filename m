From: Nagaraj Mandya <nmandya@gmail.com>
Subject: Question about pull-requests
Date: Mon, 22 Feb 2016 17:24:15 +0530
Message-ID: <CAOh0v-WW=hOXw=uTdzkd3afzXCguBHWdaDShwKE3QKqUCOBTzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 22 12:54:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXp4H-0000m7-66
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 12:54:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754545AbcBVLyR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2016 06:54:17 -0500
Received: from mail-oi0-f48.google.com ([209.85.218.48]:34380 "EHLO
	mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754479AbcBVLyQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2016 06:54:16 -0500
Received: by mail-oi0-f48.google.com with SMTP id m82so53016639oif.1
        for <git@vger.kernel.org>; Mon, 22 Feb 2016 03:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=2e7hQTXWVOzHRxYmzO1lqAhYbqNAmo3qt3VpdaRBPYQ=;
        b=S4VVRmA4hhB1W2ZlfnCCCK/JCsE+EAqY2ucVfUsGXntCaSJZn9fHHQhXwlaVbfrG0c
         bgP0o6C1+S9r8QUD0SAYsp2206LngRc+Sp2kBXKdFvkYVhu4LjAc7PlTbKKAsNV62Kni
         u2pgbSHkm43UGQx4MFUNNqqEW0LSbJN+4Zrpdb2jPwaxlM0HTdAzSmFv93mFn3sUlK70
         iAaNvFBUEbaPjKy70ljcHlXHClqJz4Rdgqd4zOZQucaYjUv89ZWouoBzFkglK6HPvoT1
         hGwlqn9cnh/KGsgFOBOfinWGeBjiNyHrBugLZ6AxjsBHGb0fdGQnaNRv/uQLrCNq+84O
         DFnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=2e7hQTXWVOzHRxYmzO1lqAhYbqNAmo3qt3VpdaRBPYQ=;
        b=X1/isXdDXd+SKa9lMUUBvecLNsUXA1PCAA64/sESwk1xu4WkzHW9tfgxDrnit7jMou
         QTAXXE3DxUYfHkcvvJNHpHu20plpg2jpVmMCuvk/Y1QSQ+u8ZrKDFWPCIAsjFQy6YfQ+
         aMEmMePo0HbtC/pC3/Zt7jI3zdTvTPJViJS+whklfqJ9YgSeL0ubYYWuAytXjwu40wxo
         1arp96NKIveIMXomrKMtZgxrnO1L9Oy177szJCbU7ETowZRqcOvJ+ThZWw9PAlPcR1RL
         FqdMPunBgN+5DSKf04r46sXaHV2ibfeVuPuYqLOEk1jkyCuVdVTIQ9A2LzVsiPBZy2G0
         +ClQ==
X-Gm-Message-State: AG10YOTXMti8o/+EEoa1RQ+res1JQeq2iLlE8rDJayBIzCrzPB/fAkcJ+DHGCRcESLkrhU4hfM20nXp4kRSPdg==
X-Received: by 10.202.102.214 with SMTP id m83mr22391056oik.74.1456142055824;
 Mon, 22 Feb 2016 03:54:15 -0800 (PST)
Received: by 10.202.72.216 with HTTP; Mon, 22 Feb 2016 03:54:15 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286925>

Hello,
  In our GIT repository, all users are restricted from merging to
master without a pull request. This works well and all developers are
raising pull requests and merging. However, if there is a merge
conflict during the merge, we have a problem.

  We follow the instructions provided by Bitbucket and the final step
is to push the merged code to master to the "origin" repository.
However, that steps always fails with the error that pushes can only
be made with pull requests.

  How do we work around this problem? We want all pushes to happen
through merge requests but still allow pull requests with merge
conflicts to get pushed. Thanks.
--
Regards,
Nagaraj
