From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (May 2015, #07; Tue, 26)
Date: Thu, 28 May 2015 14:52:50 -0700
Message-ID: <xmqqa8wofjyl.fsf@gitster.dls.corp.google.com>
References: <xmqqegm3j9jo.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 28 23:53:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yy5jX-0005Nl-O9
	for gcvg-git-2@plane.gmane.org; Thu, 28 May 2015 23:53:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754668AbbE1Vwz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2015 17:52:55 -0400
Received: from mail-ig0-f180.google.com ([209.85.213.180]:34801 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751812AbbE1Vww (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2015 17:52:52 -0400
Received: by igbhj9 with SMTP id hj9so971506igb.1
        for <git@vger.kernel.org>; Thu, 28 May 2015 14:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=mwPQZW3/rCitf56lZzN+1YW5Yqr1q4My1JxM7kbp5Gw=;
        b=AXNb9H9N+HNNxIvKYCgCzp8XI7EpQtvgHq5yK8m5ZcTvk3gjlfpmaV6OOYnSfyChGt
         cye7oDwckOlvcHogwySLj9M/mvP04XTEGqgePU+ziIWXuYEH/U+eOON59wC1IbVk/4lH
         mHdQuD79uj3FlHdUHsZVy4leUUFax6dP0xkXZDS9Y79T0TEhSFKmfYdcRwexpli4d14a
         870BLKSndxPOMVUix07So98zjtHi3Zw/u0sX58vignJBgGFA3jvgD7GP9MXVDO6aJHmO
         FKjx5Dpn/N4QA/To5R3Q3gVKuaxszIIpKrW1SbpF7KNJea73ZXJMzGQ7KiONHyB9TSSV
         UEQQ==
X-Received: by 10.107.152.14 with SMTP id a14mr6250260ioe.59.1432849972109;
        Thu, 28 May 2015 14:52:52 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:89d0:c49e:8012:77d2])
        by mx.google.com with ESMTPSA id e69sm2724900ioe.11.2015.05.28.14.52.51
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 28 May 2015 14:52:51 -0700 (PDT)
In-Reply-To: <xmqqegm3j9jo.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 26 May 2015 14:47:23 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270204>

Junio C Hamano <gitster@pobox.com> writes:

> * pt/pull-tests (2015-05-18) 8 commits
>  - t5520: check reflog action in fast-forward merge
>  - t5521: test --dry-run does not make any changes
>  - t5520: test --rebase failure on unborn branch with index
>  - t5520: test --rebase with multiple branches
>  - t5520: test work tree fast-forward when fetch updates head
>  - t5520: test for failure if index has unresolved entries
>  - t5520: test no merge candidates cases
>  - t5520: prevent field splitting in content comparisons
>
>  Add more test coverage to "git pull".

Sorry, but I lost track.  What's the doneness of this one?
