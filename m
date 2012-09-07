From: Stefan Naewe <stefan.naewe@gmail.com>
Subject: Re: [PATCH] ls-remote: document the '--get-url' option
Date: Fri, 7 Sep 2012 11:12:38 +0200
Message-ID: <CAJzBP5SODtFQKqS+uS5ev3-JLwN8Hhn9nfE-eY3P2QbBkkgV8A@mail.gmail.com>
References: <7v7gs63mio.fsf@alter.siamese.dyndns.org>
	<1347000079-7945-1-git-send-email-stefan.naewe@gmail.com>
	<m2pq5yxmn2.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Fri Sep 07 11:12:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9ucJ-000476-Ic
	for gcvg-git-2@plane.gmane.org; Fri, 07 Sep 2012 11:12:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759651Ab2IGJMk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Sep 2012 05:12:40 -0400
Received: from mail-gh0-f174.google.com ([209.85.160.174]:45658 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759324Ab2IGJMj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2012 05:12:39 -0400
Received: by ghrr11 with SMTP id r11so483923ghr.19
        for <git@vger.kernel.org>; Fri, 07 Sep 2012 02:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=YQoKMDROemLgqajYbJxbn7hVOtJOYrMnQsrVbZoFagc=;
        b=PHpJhRMEfqzoSEgSswkmY48utgk5DLELhnXFAQXtqkyqZhY/5JZWwqtO5dFeicLElb
         9p2mNkZeQ8b/ZD0xbgvjZK0Q8QkN9ul180tS4sgeKl37cp+v4uz4/PKCxXYyappzvZZU
         kZFE2FBdtyEaQP+xbDbdwrw66ofdzNaTJasWqLTJXFrLR/1ZvDP0OnBV+TLA/CA9GygB
         iHLoICayY9991LXpK7a8cH9qxeXCKiLTF0byHvdwqURRESO9eOaQGBRHSYP5W5yI4UH/
         sDPFFLuRb+FtvUYQVNHLgoyc404GjgGqmI6EdtwmGnaORtXv2a0wzonTvigaSz6zn3h/
         wfiA==
Received: by 10.236.108.202 with SMTP id q50mr4529779yhg.6.1347009158639; Fri,
 07 Sep 2012 02:12:38 -0700 (PDT)
Received: by 10.100.120.13 with HTTP; Fri, 7 Sep 2012 02:12:38 -0700 (PDT)
In-Reply-To: <m2pq5yxmn2.fsf@igel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204953>

On Fri, Sep 7, 2012 at 10:28 AM, Andreas Schwab <schwab@linux-m68k.org> wrote:
> Stefan Naewe <stefan.naewe@gmail.com> writes:
>
>> +--get-url::
>> +     Expand the URL of the given remote repository taking into account any
>> +     "url.<base>.insteadOf" config setting (See linkgit:git-config[1]).
>
> This should probably also mention that it suppresses the normal output.

Like this: http://cloud.github.com/downloads/snaewe/git/git-ls-remote.html
(I also added a simple example. I'll create a new patch if it's OK)

> (I wonder why this isn't a subcommand of git remote.)

Good question...

Stefan
-- 
----------------------------------------------------------------
python -c "print '73746566616e2e6e6165776540676d61696c2e636f6d'.decode('hex')"
