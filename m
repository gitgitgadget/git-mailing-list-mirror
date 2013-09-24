From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/2] fetch: add missing documentation
Date: Tue, 24 Sep 2013 00:23:21 -0500
Message-ID: <CAMP44s1FFTS=wOcWBfqg3zt3TO-aM83oXHcGwBcwvt_HnXrn8g@mail.gmail.com>
References: <1379772563-11000-1-git-send-email-felipe.contreras@gmail.com>
	<1379772563-11000-2-git-send-email-felipe.contreras@gmail.com>
	<20130924050343.GF2766@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 24 07:23:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOL6I-0007SP-8t
	for gcvg-git-2@plane.gmane.org; Tue, 24 Sep 2013 07:23:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750788Ab3IXFXp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Sep 2013 01:23:45 -0400
Received: from mail-lb0-f173.google.com ([209.85.217.173]:54998 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750706Ab3IXFXn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Sep 2013 01:23:43 -0400
Received: by mail-lb0-f173.google.com with SMTP id o14so3373711lbi.18
        for <git@vger.kernel.org>; Mon, 23 Sep 2013 22:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=pv49J+xuSIkaZODg0vK9JryjOz+1/X81FcW9AFTH2ME=;
        b=ldmuVlHCncYW6n9TAJ0LXxiFlV485EIzzz0zXQA9iV8E6V/2ZGC8JFGMvnCTw+6vKM
         DgjWFL/0IFrmfiXC922oUXsM/kJtuVmnjdpf71gjJs2z62tZkPv/WbbOnz8qa2cXaDIw
         3SYwMgYNs2OkhESd6SAQgtGWNmSDl9Xfl2EKv7FlDEZMJrYEpFLhRkpHUv4w+yN/hXaj
         Jg5MKk9jbSFhh9r9Tunq+d0JkUudg/68cFe7RaH66hpTlfpQLLtXLXL5E21bqLB0KUJe
         Rt6I6MchvrmdQacKndOkqhiw07ncBPUNYGpRYKdrdOxW/YOKijZaMq6bHRSYnsz/JQtO
         xcdg==
X-Received: by 10.112.198.39 with SMTP id iz7mr9397555lbc.24.1380000201427;
 Mon, 23 Sep 2013 22:23:21 -0700 (PDT)
Received: by 10.114.91.230 with HTTP; Mon, 23 Sep 2013 22:23:21 -0700 (PDT)
In-Reply-To: <20130924050343.GF2766@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235261>

On Tue, Sep 24, 2013 at 12:03 AM, Jeff King <peff@peff.net> wrote:
> On Sat, Sep 21, 2013 at 09:09:22AM -0500, Felipe Contreras wrote:
>
>> There's no mention of the 'origin' default, or the fact that the
>> upstream tracking branch remote is used.
>
> Sounds like a good thing to mention.
>
>> diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.txt
>> index e08a028..7e75dc4 100644
>> --- a/Documentation/git-fetch.txt
>> +++ b/Documentation/git-fetch.txt
>> @@ -37,6 +37,9 @@ or from several repositories at once if <group> is given and
>>  there is a remotes.<group> entry in the configuration file.
>>  (See linkgit:git-config[1]).
>>
>> +When no remote is specified, by the default the `origin` remote will be used,
>
> s/the (default the)/\1/

Right.

>> +unless there's an upstream branch configured for the current branch.
>
> Should this be "upstream remote" rather than "upstream branch"? I don't
> think we should be looking at branch.*.merge at all for git-fetch.

As a general user, how do I configure the "upstream remote"?

-- 
Felipe Contreras
