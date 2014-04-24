From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v7 12/12] cherry-pick: copy notes and run hooks
Date: Thu, 24 Apr 2014 18:35:21 -0500
Message-ID: <53599fb99b418_523614ed2ec3d@nysa.notmuch>
References: <1398307491-21314-1-git-send-email-felipe.contreras@gmail.com>
 <1398307491-21314-13-git-send-email-felipe.contreras@gmail.com>
 <CALkWK0k3OTsvaqxrpJzhGNwSHg8tZ2tuhiO8Rd-AsHLp6WOL9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 25 01:45:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdTL0-0000Ko-Ck
	for gcvg-git-2@plane.gmane.org; Fri, 25 Apr 2014 01:45:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754089AbaDXXpu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Apr 2014 19:45:50 -0400
Received: from mail-oa0-f45.google.com ([209.85.219.45]:43735 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752714AbaDXXpt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Apr 2014 19:45:49 -0400
Received: by mail-oa0-f45.google.com with SMTP id eb12so3466246oac.32
        for <git@vger.kernel.org>; Thu, 24 Apr 2014 16:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=y5WDZ5oiRH1JfZs025+m6CNylamNm7KiF81+q6jfXOo=;
        b=wm5O5cBg57V39z88WjDfT0QWMjxvETLaF41einbar+5Q3DrXLIQ5UvliHFn5sxdx7L
         KwWdq7SAG5WC4oIzt2AmXj7A5DEEupJF8rJ8YpLC+DZRlkh1LT9/zVlHre02WjP4TLo/
         Rh+EzsJxh3VHte450+S3DIIK61hjfWhoP79BHjS5hhbIB4wQ4ro9G6+avHt6MCtc2iwz
         IF8rCb5OJthriqarUY5svGDp/O0Fc49ZrxmBOvBRT4eqrB0lrKsswasZ8Grk23VFOG7L
         Tac0lnlaWG7bKns+lbyCtwhDgLssdpM9n+J2HrWnusXw+mWh39WF5UHFdBZvsBOGdn7e
         zwfg==
X-Received: by 10.182.22.33 with SMTP id a1mr3995294obf.60.1398383148397;
        Thu, 24 Apr 2014 16:45:48 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id ci10sm23931952oec.0.2014.04.24.16.45.46
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Apr 2014 16:45:47 -0700 (PDT)
In-Reply-To: <CALkWK0k3OTsvaqxrpJzhGNwSHg8tZ2tuhiO8Rd-AsHLp6WOL9A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247026>

Ramkumar Ramachandra wrote:
> Felipe Contreras wrote:
> > If no action-name is specified, nothing is done.
> 
> Why? Is it because git-rebase implements its own notes-copy-on-rewrite logic?

Yes, and `git rebase` uses `git cherry-pick`.

-- 
Felipe Contreras
