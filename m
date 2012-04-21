From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] Documentation: explain push.default option a bit more
Date: Fri, 20 Apr 2012 22:42:37 -0700
Message-ID: <xmqqbomlzlma.fsf@junio.mtv.corp.google.com>
References: <vpqfwbye9re.fsf@bauges.imag.fr>
	<1334933944-13446-1-git-send-email-Matthieu.Moy@imag.fr>
	<1334933944-13446-2-git-send-email-Matthieu.Moy@imag.fr>
	<20120420201357.GA13103@sigill.intra.peff.net>
	<xmqq62cum6tf.fsf@junio.mtv.corp.google.com>
	<4F922ECC.4040103@alum.mit.edu>
	<xmqqpqb1zpzz.fsf@junio.mtv.corp.google.com>
	<4F923F3A.7050701@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Matthieu Moy <Matthieu.Moy@imag.fr>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sat Apr 21 07:51:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SLTDu-0004sz-Nz
	for gcvg-git-2@plane.gmane.org; Sat, 21 Apr 2012 07:51:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752593Ab2DUFu7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Apr 2012 01:50:59 -0400
Received: from mail-qc0-f202.google.com ([209.85.216.202]:43234 "EHLO
	mail-qc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751425Ab2DUFu6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Apr 2012 01:50:58 -0400
Received: by qcsp5 with SMTP id p5so1181887qcs.1
        for <git@vger.kernel.org>; Fri, 20 Apr 2012 22:50:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:x-gm-message-state;
        bh=4gx71l/g2tOhA4fZdo1f5BnYYCw1iIJpD3RHk0mS8i0=;
        b=gBsLRQJKniqM4OpTLZDRQS815D65ifeopWP0D2S1C0w0IHsG8sQfIJ5xB6nkGSKkjq
         lEzPuCejxIgIfy9yS4rEb1OinkuznfVwzIT7QjtMe07F6+qW2HUG4rLfFaHaMAd4Rb6u
         5UdwyMXyLe9Ovx7Day5meFlL0Qr4qV0NeDZPiPW2/QozaK0CvP+bQ7jDc4n/kCp/v9cD
         J7jetceHS3ckLSf7Ph8FieCga1zmJHHxxgoCUJdDYqE4ErVCMcQUoJG+jW/kZnGTPH96
         9Or+ZLgSPOhWJXzAjieGLosTC5e2Rgjd0ZYZlmWK1Y0o/v8Xf+wYXOnYHqWBj+qhOUaO
         P3wg==
Received: by 10.101.179.5 with SMTP id g5mr3217267anp.12.1334986958367;
        Fri, 20 Apr 2012 22:42:38 -0700 (PDT)
Received: by 10.101.179.5 with SMTP id g5mr3217246anp.12.1334986958213;
        Fri, 20 Apr 2012 22:42:38 -0700 (PDT)
Received: from wpzn4.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id y36si7588061yhg.2.2012.04.20.22.42.38
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Fri, 20 Apr 2012 22:42:38 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by wpzn4.hot.corp.google.com (Postfix) with ESMTP id 1FDF01E004D;
	Fri, 20 Apr 2012 22:42:38 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id BBFFCE120A; Fri, 20 Apr 2012 22:42:37 -0700 (PDT)
In-Reply-To: <4F923F3A.7050701@alum.mit.edu> (Michael Haggerty's message of
	"Sat, 21 Apr 2012 07:01:46 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQngBKhqeA+nGNBwxdkXmI9A/1zXFEr//7jtrkUYXK7TIs0ko67stF5468az9m6+QYdobnZLQce+mjfMBrZWylZbLSL7eIHz8b14e0DvlFllkhsmGFXvCKS1C+TNvE6875fkq0sKU3ABmQMP5gl/9nqLtgwGLjd84xbmVR/xPmRuOy3H5CU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196043>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> only means "nuclear", I suggest that the word be avoided in this
> explanation.  Perhaps
>
>>      * `matching` - push all branches having the same name in both ends.
>>        This is for those who prepare all the branches into a publishable
>>        shape and push them out atomically, and suitable when pushing to a
>>        non-shared repository. [...]
>
> could be changed to
>
>>      * `matching` - push all branches having the same name in both ends.
>>        This allows those who prepare all the branches into a publishable
>>        shape to push them out to a non-shared repository with a single
>>        command. [...]

Sounds good.
