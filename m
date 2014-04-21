From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/2] remote-helpers: move tests out of contrib
Date: Mon, 21 Apr 2014 14:23:14 -0500
Message-ID: <53557021ed75d_414c80b30836@nysa.notmuch>
References: <1398029971-1396-1-git-send-email-felipe.contreras@gmail.com>
 <1398029971-1396-3-git-send-email-felipe.contreras@gmail.com>
 <xmqq7g6ia5rr.fsf@gitster.dls.corp.google.com>
 <5355690fbe8ad_32c4849310d1@nysa.notmuch>
 <xmqqy4yy8p0l.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 21 21:33:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcJyI-0002t3-3C
	for gcvg-git-2@plane.gmane.org; Mon, 21 Apr 2014 21:33:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754113AbaDUTdi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Apr 2014 15:33:38 -0400
Received: from mail-yh0-f54.google.com ([209.85.213.54]:55558 "EHLO
	mail-yh0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752779AbaDUTdg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Apr 2014 15:33:36 -0400
Received: by mail-yh0-f54.google.com with SMTP id f73so3931106yha.27
        for <git@vger.kernel.org>; Mon, 21 Apr 2014 12:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=QaCWxObXkoL9GwJ8dmWX/zV4L2tS1xp/JuWTSl53mLc=;
        b=u58w19htEi1Nsimo2NyegGZqCwXkZYggIZ4koE+CzBKVXrh2C2AljcCBNcl0h2DYZu
         XSD736TiAWY3XC7P/JQhPEhAraD4m0o4XWNRmkJh8+O/sl1fQMobU3PjX15C1VOw0d/U
         r2+l5lxNrmqeLcncuQvtWk/oqC1oFY1Ky8186fimwAfTEedPb9Rr6BrlvwxSc4IeziTo
         oMm0/6rZl8AUvxmCX5Ieu+0pWJpV9OJZuGR8HrcICq3lUuFwluKGGKbl5OQQEwspWO7J
         VhZfvY61cnQi3TphAuXlnGUpfM2xhXW4y5cI5b2iQcp7dX6mo6SpxBbTEbBH3Qh5QdTg
         tcaQ==
X-Received: by 10.236.197.68 with SMTP id s44mr5150567yhn.109.1398108816231;
        Mon, 21 Apr 2014 12:33:36 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id f62sm71539805yhq.6.2014.04.21.12.33.34
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Apr 2014 12:33:35 -0700 (PDT)
In-Reply-To: <xmqqy4yy8p0l.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246625>

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> >> This step needs a bit more work, I am afraid, to at least have these
> >> three test scripts follow the same numbering scheme.  Especially given
> >> that there were recent discussions on allowing a range of tests to
> >> be run (or omitted) via notations like "5000,5020,9800-9812", not
> >> doing so now will make it harder to implement such an enhancement.
> >
> > I don't see how such an enhancement would be beneficial to these remote
> > helpers.
> 
> Why are remote helpers more special than other parts of the system?

They aren't.

> Do they _have to_ be different and special?

No.
 
> > For starters there aren't any number rages left for them,...
> 
> Wouldn't "5 - the pull and exporting" be an obvious space for them,
> especiall somewhere after 5800?

Not _that_ obvious. If you are OK with having the hg-hg-git test (a test which
requires hg-git, a tool that is completely independent from git-remote-hg)
there, then fine.

-- 
Felipe Contreras
