From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: What's cooking in git.git (Feb 2014, #06; Wed, 19)
Date: Fri, 21 Feb 2014 11:18:34 -0500
Message-ID: <CALkWK0ktd1c-KGc6AqqYNE=_skQGdA0bu4T7yx-2iiPOibSfuA@mail.gmail.com>
References: <xmqqppmi7pbn.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 21 17:19:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WGsos-0002qV-2G
	for gcvg-git-2@plane.gmane.org; Fri, 21 Feb 2014 17:19:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755964AbaBUQTQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Feb 2014 11:19:16 -0500
Received: from mail-oa0-f47.google.com ([209.85.219.47]:35030 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755810AbaBUQTP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Feb 2014 11:19:15 -0500
Received: by mail-oa0-f47.google.com with SMTP id m1so4567597oag.34
        for <git@vger.kernel.org>; Fri, 21 Feb 2014 08:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=kFRSjKAn6xLzxKNa1cFoH3dobKuK0rDWf3RDQ2ipln0=;
        b=y61og65H+B46BUgWIpU+C6M5irDcVjfdml+5mwDVwBnrIaQZ07iY5nEmMpp0kliAki
         7GdVTjB39V5hdaPPUfatThBAfw9myFu49IdxnWdmoNAhL9LOMlFVtw526T9VeOLUHshq
         /i7jU/qvCTlodhoezTrGNhjL5AlYrFrTPbOf4MgNItxRGgYDDA159mY0f5stwmyc+BqR
         k8WUBDGW9RoDh46IWZywjj1ufnSRVB4yxdr0bbyGu9LbaVGh8qF2ULAkZBOSj0EGlHE3
         TDgvNNOzeXt0HKSstOOwt7PcwkhQcIQcSGAm9GTGonta7oJnllqLu2OA7O7CZU5jTSCt
         3r5g==
X-Received: by 10.42.40.83 with SMTP id k19mr3610970ice.3.1392999554483; Fri,
 21 Feb 2014 08:19:14 -0800 (PST)
Received: by 10.64.10.42 with HTTP; Fri, 21 Feb 2014 08:18:34 -0800 (PST)
In-Reply-To: <xmqqppmi7pbn.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242468>

Junio C Hamano wrote:
> * jk/branch-at-publish-rebased (2014-01-17) 5 commits
>  - t1507 (rev-parse-upstream): fix typo in test title
>  - implement @{publish} shorthand
>  - branch_get: provide per-branch pushremote pointers
>  - branch_get: return early on error
>  - sha1_name: refactor upstream_mark
>
>  Give an easier access to the tracking branches from "other" side in
>  a triangular workflow by introducing B@{publish} that works in a
>  similar way to how B@{upstream} does.
>
>  Meant to be used as a basis for whatever Ram wants to build on.
>
>  Will hold.

Since I've decided that I don't have the time to work on this, we've
added this to the list of project ideas for GSoC 2014
(http://git.github.io/SoC-2014-Ideas.html). Hopefully, a student will
come along and volunteer to finish this.
