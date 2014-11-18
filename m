From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] t0090: mark add-interactive test with PERL prerequisite
Date: Tue, 18 Nov 2014 10:51:48 -0800
Message-ID: <20141118185148.GF6527@google.com>
References: <20141118172231.GA16387@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 18 19:51:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqnsV-0003U6-Pl
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 19:51:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754131AbaKRSvs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2014 13:51:48 -0500
Received: from mail-ig0-f170.google.com ([209.85.213.170]:39208 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753736AbaKRSvr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2014 13:51:47 -0500
Received: by mail-ig0-f170.google.com with SMTP id r2so4537659igi.3
        for <git@vger.kernel.org>; Tue, 18 Nov 2014 10:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=BTyXCHDX/0kcJD5RyxgMWfpXeHv7QoRgsivpF9ILZsw=;
        b=cuFE5aUyLvkJSB87eGgLXmY26Wr1q43EB0nZI6VOrThPwg1f6eFsO+7gb2ZwTQBABM
         BNTr5wvAa+/68T1FO8iA34/7pmQSvBDno4PP9iV5SWrlQ5kbytzGE9ZhbTzbTJ0LAfVs
         E61xDSBaLukq+/Xh2qXIsLnMSModz0VuDhbTvqYkKKfRpTj2cdmYosBtXjvi0OUAs6LG
         GMrQBZuDvRWelRNgpJqDZ1rSGqLes3R/4zpX99R3pQh0GhgKN2Hk5R06e5ZweDOZB0NZ
         RaRYVUrn/a0ymb29Xom4nhPwDQt2j5OD6bsQgh0Ig/YuHvfPZiy7ELDdQ15qEep69SGJ
         pUcw==
X-Received: by 10.42.137.9 with SMTP id w9mr36649326ict.20.1416336707160;
        Tue, 18 Nov 2014 10:51:47 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:1d6d:1067:602d:d9c7])
        by mx.google.com with ESMTPSA id j142sm19380969ioe.16.2014.11.18.10.51.45
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 18 Nov 2014 10:51:45 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20141118172231.GA16387@peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:

> The add-interactive system is built in perl. If you build
> with NO_PERL, running "git commit --interactive" will exit
> with an error and the test will fail.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> Noticed by Michael while working around gitweb failures by setting
> NO_PERL. :)

Heh.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
