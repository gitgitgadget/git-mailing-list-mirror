From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH 1/4] ls-remote: document --quiet option
Date: Sun, 17 Jan 2016 18:13:54 +0100
Message-ID: <20160117171354.GC7100@hank>
References: <1453028643-13978-1-git-send-email-t.gummerer@gmail.com>
 <1453028643-13978-2-git-send-email-t.gummerer@gmail.com>
 <20160117144726.GB15519@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: bturner@atlassian.com, gitster@pobox.com, pedrorijo91@gmail.com,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jan 17 18:13:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aKqtf-000730-JI
	for gcvg-git-2@plane.gmane.org; Sun, 17 Jan 2016 18:13:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751361AbcAQRNi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jan 2016 12:13:38 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35007 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751778AbcAQRN3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jan 2016 12:13:29 -0500
Received: by mail-wm0-f68.google.com with SMTP id 123so5031059wmz.2
        for <git@vger.kernel.org>; Sun, 17 Jan 2016 09:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=AAVWkQL2zpth5ML6VhyldtqJNvKUoaUdHQfv8BANkbg=;
        b=ytAQ1HtTYxfoPu60/3mlZA5mmgpVeCrL91BXG8hkMxZHUw9Mq33QlNRceNHiI0NtIN
         YkqMNv3JxIR3PTjQD+W4YJKjue6BR/8JWRXO8iaj+lvNc0/ItbapFS/ZrxBFV+b+5Pjw
         oT71zoOtLVE95enVIUJQ3tsgElqV3LGUa2jb315xrKE6R9chUgkVUIupwZ7ZbUzlDBVO
         y0pRG6qfGCy0VdDB95KY3UHQQuGFWUJRGrSCK+MdxwycyOr6JbLn8//lAiuiKJPS2zqs
         nm3NdlYJGc4/RV0hT4xGjCwbkN42Zwnuu/9b8uA6QislvggFmk1Ql2Wdd42Td1eVq6YP
         TYSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=AAVWkQL2zpth5ML6VhyldtqJNvKUoaUdHQfv8BANkbg=;
        b=GkyuDYGLaMMpyTMl86Sxuf0h3HXoDj0H0B6Il7sYcl5ZwxEhLNURuEXryru0MP93Kz
         prXZ/fLb+ARwWD+Q75qblLMxgoAGrtRYSq6+lmKuH9vV204MJeya4TExYk97ee8J2vJa
         Ji7x/9IjyaobbETMwr3UqXOM9bGQluxBUaieov/eD/xgef08sgAFwMcr1RykIvXhCXlk
         si4oefQ/HC02L858i96bxgrm05W43FhnMVbAWvaE8LchnqK/YrUCJclidBrzpflnZKLI
         wZFbBrFVF3W59XAA0fnNtG96HTmwjLNIm8pCXVhCw8B5JpdxgPvNTPOSnQgO0Z0ACRpx
         xOQA==
X-Gm-Message-State: ALoCoQnhnfTyL57TN4LxZwMPH43WJjAkucsEQxi7/DbyE1raOaW4oSCBHutnem5HwipmPIyH0xGKo9cNfLyF0JcsnN5H8H2NaQ==
X-Received: by 10.194.123.167 with SMTP id mb7mr23897528wjb.0.1453050808194;
        Sun, 17 Jan 2016 09:13:28 -0800 (PST)
Received: from localhost ([95.233.44.41])
        by smtp.gmail.com with ESMTPSA id w80sm11958058wme.17.2016.01.17.09.13.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Jan 2016 09:13:26 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20160117144726.GB15519@sigill.intra.peff.net>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284261>

On 01/17, Jeff King wrote:
> On Sun, Jan 17, 2016 at 12:03:59PM +0100, Thomas Gummerer wrote:
>
> > cefb2a5e3 ("ls-remote: print URL when no repo is specified") added a
> > quiet option to ls-remote, but didn't add it to the documentation.  Add
> > it.
>
> Great. I love it when a patch series starts by tidying up the area.
>
> The patch looks obviously correct. Should we do the same for "--refs",
> which looks like the only other undocumented option (aside from --exec,
> but I think that's just for historical compatibility).

Sounds like a good idea.  I will add a patch for that.

>
> -Peff

--
Thomas
