From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] mergetool--lib: Allow custom commands to override built-ins
Date: Wed, 26 Sep 2012 15:33:18 +0530
Message-ID: <CALkWK0naJt840LfMNBM7EtdyLE5nmJeAsxG-Wttj8c84O5X7jA@mail.gmail.com>
References: <1348559291-71739-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Sylvain Rabot <srabot@steek.com>,
	K Gateway <kowloongateway1@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Mike Schuld <mike.schuld@foundant.com>,
	Stefan Kendall <stefankendall@gmail.com>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 26 12:03:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGoT8-0000ri-SP
	for gcvg-git-2@plane.gmane.org; Wed, 26 Sep 2012 12:03:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752991Ab2IZKDk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Sep 2012 06:03:40 -0400
Received: from mail-qc0-f180.google.com ([209.85.216.180]:50869 "EHLO
	mail-qc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752417Ab2IZKDj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Sep 2012 06:03:39 -0400
Received: by qcmv28 with SMTP id v28so355097qcm.11
        for <git@vger.kernel.org>; Wed, 26 Sep 2012 03:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=lX/bXZXJ86Jo8UwMcsMK5bEBlMh9M5NHPa2dyFbc7Lk=;
        b=I/uIIhqfdNx5DXePEdrt+1pETlniy+QwwV8nGdK2ZVFCh4qd/jCIDu5XHfHWpZPYOu
         TkBZ9H5lumfCLtJKUoJPwkJS0LbGOsfg6lnFO1csMVXX1Y7WcSQSMRbVmSuu/hgtKMh8
         QbyNn/18Lu1k+XJ+W1u23g780dyPv0T5VzI1ZOdfgXN3hXvCTtCOzwauvSzmdZx6Hs8T
         1Bm+U7t3JwQvX+soGNYuRxGE1evh016ARjWKGmKwO2+1MYmazY0qyOiedQI2X/wIVNAx
         PscDJ5A62U3fWUZfaIQr9vOL40hdHHLtiYVAzQNu8K3ftTe1ZzUSJlmw3H1YZNENNxgl
         WFRA==
Received: by 10.224.213.10 with SMTP id gu10mr932861qab.10.1348653818863; Wed,
 26 Sep 2012 03:03:38 -0700 (PDT)
Received: by 10.49.84.105 with HTTP; Wed, 26 Sep 2012 03:03:18 -0700 (PDT)
In-Reply-To: <1348559291-71739-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206402>

Hi David,

David Aguilar wrote:
>  diff_cmd () {
> -       merge_tool_cmd="$(get_merge_tool_cmd "$1")"
> -       if test -z "$merge_tool_cmd"
> -       then
> -               status=1
> -               break
> -       fi
> -       ( eval $merge_tool_cmd )
> -       status=$?
> +       status=1
>         return $status
>  }

Nit: Why not return 1, instead of setting $status and returning it?

Ram
