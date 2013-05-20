From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: What's cooking in git.git (May 2013, #04; Wed, 15)
Date: Mon, 20 May 2013 18:08:48 -0500
Message-ID: <CAMP44s2P-GP+xmViv5CA+CVZZv+rO8BQcJJ-3r=RPdoh+kNUhQ@mail.gmail.com>
References: <7vmwrvajye.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 21 01:09:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UeZCO-0002uQ-WB
	for gcvg-git-2@plane.gmane.org; Tue, 21 May 2013 01:09:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758447Ab3ETXIv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 May 2013 19:08:51 -0400
Received: from mail-la0-f41.google.com ([209.85.215.41]:52246 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758396Ab3ETXIu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 May 2013 19:08:50 -0400
Received: by mail-la0-f41.google.com with SMTP id ee20so5633575lab.0
        for <git@vger.kernel.org>; Mon, 20 May 2013 16:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=k+CvIbXzjFK/5mCSICQlUhn2B3E4kc95haXwlGkRmXo=;
        b=JZGUnI3Yu6RojenccqNdvo4KFbNo25t4njJZg0mKsXccSAXjwc6BwVuaExITXbRBN5
         unwjcwQdcNzdfvBuXSg/aqXKvd4c8i+YOLsqbmBPfRzzugP0w1uVqjxgb7yulrQf6RRY
         kaXRrEPVDzaBIKKUQXAXXKR9RZVGscGXCagpGxw7eNZRjtlb9QbbC8Z3YVnagt7ooSRB
         kkS864xQv+Z1XWPP90K5GlOWYhZuvfx8iAHAazLP4uFqY4CKXB9JGHIoACqUnG6Y+C8Z
         SXb99KYz+GCNjCDiUs2bQuTC9HG/8KxdIwSKMSnvxz/9yToSltAKFT4Gg6ecvj70AgQl
         BD6A==
X-Received: by 10.112.63.169 with SMTP id h9mr89985lbs.135.1369091328657; Mon,
 20 May 2013 16:08:48 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Mon, 20 May 2013 16:08:48 -0700 (PDT)
In-Reply-To: <7vmwrvajye.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224999>

On Wed, May 15, 2013 at 6:42 PM, Junio C Hamano <gitster@pobox.com> wrote:

> * fc/completion (2013-04-27) 9 commits
>  - completion: remove __git_index_file_list_filter()
>  - completion: add space after completed filename
>  - completion: add hack to enable file mode in bash < 4
>  - completion: refactor __git_complete_index_file()
>  - completion: refactor diff_index wrappers
>  - completion: use __gitcompadd for __gitcomp_file
>  - completion; remove unuseful comments
>  - completion: document tilde expansion failure in tests
>  - completion: add file completion tests
>
>  I saw this discussed somewhat. Is everybody happy with this
>  version?  This is its v2, in the $gmane/222682 thread.

I think we've waited long enough for feedback. I already demonstrated
that this fixes regressions, and I tested that works on all relevant
versions of bash.

-- 
Felipe Contreras
