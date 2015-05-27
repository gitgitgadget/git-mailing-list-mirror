From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] glossary: add "remote" and "submodule"
Date: Wed, 27 May 2015 16:05:31 -0700
Message-ID: <xmqqwpztiptw.fsf@gitster.dls.corp.google.com>
References: <1432761209-4120-1-git-send-email-sbeller@google.com>
	<xmqq617dk621.fsf@gitster.dls.corp.google.com>
	<CAGZ79kbz6d8j1p5d-pO2cpou76ivhkCQPq4cpGxozc-9cnACPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Philip Oakley <philipoakley@iee.org>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu May 28 01:05:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxkOI-0000VD-FT
	for gcvg-git-2@plane.gmane.org; Thu, 28 May 2015 01:05:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751658AbbE0XFe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2015 19:05:34 -0400
Received: from mail-ig0-f180.google.com ([209.85.213.180]:36502 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751630AbbE0XFd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2015 19:05:33 -0400
Received: by igbpi8 with SMTP id pi8so97935965igb.1
        for <git@vger.kernel.org>; Wed, 27 May 2015 16:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=Xi8dxGYLtE55a6Fqpfok+h42F0/DCB3v+EsOF3vnpWI=;
        b=icQmE4Z3+bHujimDk7qecrdcM9LwtCIbilO7zRCFSVm7G/66DF4mm1IYGUmUP10DGB
         rGx0LzQxDMxHIpb/oJ4CylEDwZKcReqlDH4YXjMFfOHw6ptOLoEeb0wJZY52uWmue8Oa
         sxGuDqhWpNk4PsRJo8sHADPnGvWc0DYiNAebdWVBM8Fhee8d2Qz9wq9MpVIel91mBT2P
         YRUrbWTNTkcLQcaqRMpkhYVw3AcHweyOUrV7tlLK6wiNy66mJTQ/h0Aqu+Kso+TobzrS
         WfUC/9ThlXhX+yb9yM2N4CCBA5Mzd9BtpOQFfwznFJVKpLUeg7ZeEaZ6CmJ1MhkbQ6EL
         uQXA==
X-Received: by 10.42.240.82 with SMTP id kz18mr1646114icb.92.1432767932996;
        Wed, 27 May 2015 16:05:32 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:91c7:752b:4513:7344])
        by mx.google.com with ESMTPSA id d185sm331988ioe.42.2015.05.27.16.05.32
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 27 May 2015 16:05:32 -0700 (PDT)
In-Reply-To: <CAGZ79kbz6d8j1p5d-pO2cpou76ivhkCQPq4cpGxozc-9cnACPQ@mail.gmail.com>
	(Stefan Beller's message of "Wed, 27 May 2015 15:59:41 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270117>

Stefan Beller <sbeller@google.com> writes:

>>> +[[def_submodule]]submodule::
>>> +     A <<def_repository,repository>> inside another repository. The two
>>> +     repositories have different history, though the outer repository
>>> +     knows the commit of the inner repository.
>>
> ... But correctness trumps brevity indeed.

I do not think the correct way is that much longer, though.

A repository inside another repository. The two repositories have different history
A repository that holds the history of a separate project inside another repository

Heh, they are the same length, no?

>
>>
>>        A repository that holds the history of a separate project
>>        inside another repository (the latter of which is called
>>        superproject).
>
> This is better than what I proposed, but confusing. When naming
> a project a submodule, my mental standpoint is the superproject.
> ("This project has the submodule foo and bar"). But In your description
> the superproject is called "another repository".

That is because you are adding an entry for "submodule" to the
glossary, no?  I was writing from submodule's point of view, i.e. "I
(submodule) is inside another repository, and my project is separate
from that other repository's".

>>        The containing superproject knows about the
>>        names of (but does not hold copies of) commit objects of the
>>        contained submodules.
>
> That makes sense to point out here. Though should we also introduce
> "superproject" now?

Yes, that is what I was hinting at.
