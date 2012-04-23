From: Junio C Hamano <gitster@pobox.com>
Subject: Re: tags not present in bare clone
Date: Mon, 23 Apr 2012 12:19:57 -0700
Message-ID: <xmqqobqii7c2.fsf@junio.mtv.corp.google.com>
References: <0BE9553B-C799-43D5-BA9A-28FC83CA0773@linea.gov.br>
	<xmqqsjfui7gn.fsf@junio.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Patricia Bittencourt Egeland <pbegeland@linea.gov.br>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 23 21:20:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMOns-0004HR-4v
	for gcvg-git-2@plane.gmane.org; Mon, 23 Apr 2012 21:20:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753205Ab2DWTT7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Apr 2012 15:19:59 -0400
Received: from mail-qc0-f202.google.com ([209.85.216.202]:48553 "EHLO
	mail-qc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753001Ab2DWTT6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2012 15:19:58 -0400
Received: by qcsp5 with SMTP id p5so1379911qcs.1
        for <git@vger.kernel.org>; Mon, 23 Apr 2012 12:19:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:x-gm-message-state;
        bh=NFuUI0TjQotm15S25+wOg3X1te2Hj90LvmD69AjGtT4=;
        b=WcxOJmm9Iujgc8yC+Qhh32Mqlp91VvvzA1tvF/21x3hxbPnKphpNFrjjGDnxHdB4re
         yhBEgEJHrK1VT+tzt525QpfRoJkoB7Keq5I+Jv9H8Z6BBwg8C2S15FCJAGthS7v4KBJ3
         Dxh07I8OrwNHIU08Jjw0T2bWSUQc0ft4TljmaP8S3K3sRnBE4Ia55aBQyCt0GC3AGx3T
         nBP5BezCZM927Hu4YtIBgQZjdsfsx986wkk0v6Ouggcz9KkflPBFJ8KTUWFPQ/MiBmj0
         j4f4YwEtvDIfKCbT+C/vokkIq5GvP9t6c2PG7IuBqxBBx3Od5Z08wE00d7J577lFHjV1
         0CqQ==
Received: by 10.100.245.28 with SMTP id s28mr6298692anh.6.1335208798061;
        Mon, 23 Apr 2012 12:19:58 -0700 (PDT)
Received: by 10.100.245.28 with SMTP id s28mr6298678anh.6.1335208797895;
        Mon, 23 Apr 2012 12:19:57 -0700 (PDT)
Received: from wpzn3.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id z48si15734904yhn.7.2012.04.23.12.19.57
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Mon, 23 Apr 2012 12:19:57 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by wpzn3.hot.corp.google.com (Postfix) with ESMTP id C61501000C2;
	Mon, 23 Apr 2012 12:19:57 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id 7166EE120A; Mon, 23 Apr 2012 12:19:57 -0700 (PDT)
In-Reply-To: <xmqqsjfui7gn.fsf@junio.mtv.corp.google.com> (Junio C. Hamano's
	message of "Mon, 23 Apr 2012 12:17:12 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQlq5et7cW1bgt/AeELArZFHOrw1oaQ9ewL3Rnrw8nCumBRx8LpLNYAvfCmA7W+ZixeiLtFa7iGbBMcBOV19s0vDgBNTeLj5ZdoBK0QWaqsTyZUDLePvawpjO70ygtkSCyj0oWDObxvlRbaAutldA/f3cQrvUy4ZnzJWMPrUOxVkiRhfg2o=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196162>

Junio C Hamano <gitster@pobox.com> writes:

> Patricia Bittencourt Egeland <pbegeland@linea.gov.br> writes:
>
>>        I'm trying to create a bare clone from a regular repo (all
>>        locally; in the same machine). However a tag created in the
>>        regular repo can't be found in the fresh bare clone.  I
>>        expected that the tags would also be present just like anything
>>        from "refs". Am I wrong about that?
>
> Reproduction recipe???
>
> A simple and straightforward attempt to reproduce what you said you did
> in your message does not exhibit any problem.
> ...

Oops, I forgot --bare.

>     $ cd ../ ;# back at /var/tmp/junk
>     $ git clone src dst

This should be "git --bare clone src dst" (or "git clone --bare src
dst").

But everything else in my previous message still holds true.  I am
getting the identical output as the following.

>     Cloning into 'dst'...
>     done.
>     $ cd dst
>     $ git for-each-ref
>     6982d523f08b93dc6862ae80e80065b208d0ba85 commit	refs/heads/master
>     6982d523f08b93dc6862ae80e80065b208d0ba85 commit	refs/remotes/origin/HEAD
>     6982d523f08b93dc6862ae80e80065b208d0ba85 commit	refs/remotes/origin/master
>     33a6b315ffb461cba32d84ecd1692525a0846f5a tag	refs/tags/v1.0
>     0d3f9dce20e28c6898423eb4a2c2010908e46a6c tag	refs/tags/v2.0
