From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: configure git to not push all remote tracking branches
Date: Fri, 9 Dec 2011 20:33:55 +0530
Message-ID: <CALkWK0m0f-AGLwKqiKx9Aozwr5oN6FrH5ehG03mmEpB7Di8PWQ@mail.gmail.com>
References: <CAPD5EOjsu-9=CCUJut_bGqv=asp8FeGqL2GhKewgw3SQsArk_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Justin Johnson <justin.johnson3@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 09 16:04:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZ1zr-0001I5-9B
	for gcvg-git-2@lo.gmane.org; Fri, 09 Dec 2011 16:04:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754483Ab1LIPES (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Dec 2011 10:04:18 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:51321 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753849Ab1LIPER (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Dec 2011 10:04:17 -0500
Received: by faar15 with SMTP id r15so806594faa.19
        for <git@vger.kernel.org>; Fri, 09 Dec 2011 07:04:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=iWlc2VXPnNYj6tRWmvkPaW2stB6OQLdCSEb2YiTSS6E=;
        b=MrsWYQhK0iGVzgyNunp1htMOHNhqStcL6w2v5xO3CevAclu4gWCwMHU+ydEzj3rsyx
         VI7iTecHH0kTYyxql2jb2Q/vL+1KGtDtZRyfpwBfs+vhY+T0pY8d2bomJxz3qPUkbGyz
         hC+Cd0Pawe8lBkjNDLG24ZeQasf2yWlC/HwbQ=
Received: by 10.180.90.6 with SMTP id bs6mr10816138wib.63.1323443056275; Fri,
 09 Dec 2011 07:04:16 -0800 (PST)
Received: by 10.216.51.141 with HTTP; Fri, 9 Dec 2011 07:03:55 -0800 (PST)
In-Reply-To: <CAPD5EOjsu-9=CCUJut_bGqv=asp8FeGqL2GhKewgw3SQsArk_A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186636>

Hi Justin,

Justin Johnson wrote:
> git push alternateorigin
> should not do anything, but
> git push alternateorigin mybranch
> should push just mybranch.

$ git config push.default nothing
Note: push.default defaults to "matching"

Cheers.

-- Ram
