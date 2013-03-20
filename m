From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/6] t5516 (fetch-push): update test description
Date: Wed, 20 Mar 2013 11:22:13 -0700
Message-ID: <20130320182213.GI3655@google.com>
References: <1363783501-27981-1-git-send-email-artagnon@gmail.com>
 <1363783501-27981-3-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 20 19:22:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UINev-0006BK-Tj
	for gcvg-git-2@plane.gmane.org; Wed, 20 Mar 2013 19:22:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755844Ab3CTSWS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Mar 2013 14:22:18 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:33745 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754926Ab3CTSWS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Mar 2013 14:22:18 -0400
Received: by mail-pd0-f181.google.com with SMTP id q10so712504pdj.40
        for <git@vger.kernel.org>; Wed, 20 Mar 2013 11:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=FbfANhyrax9tBIkzeuLm5iT9xkPdnXY6v9bQfIeA1Bk=;
        b=e7ZtjCIqRVUzaHtCDXLivLXVFcLs9B3LCo84hPdbBLwUxVBPl+OJXKspTP8d4FF4mS
         qJ58gCgdKPYzfdae50Z2aMPulwPhyTyKTab22Y+YU5HaQ/cpHAQhNuz43qBHp0TNqXBO
         YiwynQW/PwPMwiwy0CYLLRGnItrb2wIKOj2MRTb0NTY8NvIPZebQmhTGpMZS8UbQr56G
         SBRVHrMTDYeEquYLkOCwP0YbzggzpRQGGmnr8hE5TIZOJ2M5OgdiDmwRkLnK/AYVwmkz
         OSwKxmwZco348HyWXGa5OJE19rlXXQ0Fq37H/DgEY9nDnymmgzVHbVRchq+sgv4C/E50
         Hv6w==
X-Received: by 10.66.234.198 with SMTP id ug6mr140888pac.43.1363803737606;
        Wed, 20 Mar 2013 11:22:17 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id pg7sm2947354pbc.5.2013.03.20.11.22.15
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 20 Mar 2013 11:22:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1363783501-27981-3-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218637>

Ramkumar Ramachandra wrote:

> --- a/t/t5516-fetch-push.sh
> +++ b/t/t5516-fetch-push.sh
> @@ -1,6 +1,6 @@
>  #!/bin/sh
>  
> -test_description='fetching and pushing, with or without wildcard'
> +test_description='fetching and pushing'

I'm not thrilled with the description before or after.  Would it make
sense to do something like the following?

	test_description='Tests of basic fetch/push functionality.
	
	These tests create small test repositories and fetch from and
	push to them, testing:

	 * commandline syntax
	 * refspecs and default refspecs
	 * fast-forward detection and overriding fast-forward detection
	 * configuration (insteadOf, pushInsteadOf, [remote "name"] push,
	   etc)
	 * hooks
	 * --porcelain output format
	 * hiderefs
	'
