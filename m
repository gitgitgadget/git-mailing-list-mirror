From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH v2 09/12] t7406: use "git pull" instead of "git pull --rebase"
Date: Sun, 10 May 2015 16:19:48 +0800
Message-ID: <CACRoPnQdmaoNW_CoZmTz24SgLrQZjyTGWRpCKmWh3bTH92939g@mail.gmail.com>
References: <1430988248-18285-1-git-send-email-pyokagan@gmail.com>
	<1430988248-18285-10-git-send-email-pyokagan@gmail.com>
	<xmqqfv78qp13.fsf@gitster.dls.corp.google.com>
	<CACRoPnQ3zYsv63pNUtasS6y2HnWMYqwssF=yFA3OHVvF2Yb5Sw@mail.gmail.com>
	<xmqqpp6cnnyr.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Peter Hutterer <peter.hutterer@who-t.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 10 10:20:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YrMTD-0007lq-EY
	for gcvg-git-2@plane.gmane.org; Sun, 10 May 2015 10:20:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752119AbbEJITx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 May 2015 04:19:53 -0400
Received: from mail-lb0-f173.google.com ([209.85.217.173]:33600 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752072AbbEJITu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 May 2015 04:19:50 -0400
Received: by lbbzk7 with SMTP id zk7so76502908lbb.0
        for <git@vger.kernel.org>; Sun, 10 May 2015 01:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=so7C/wMxqYMdLTnTMKWrwgX6jGNRtlAfFQ08pmUEJfg=;
        b=xhIxTfe42ez/3qiMertycCpKV/H//SULz++3qthr00VzyQCr9uwJjnl6SOkaIGVF+4
         3KTl+/NYWpHWCuoOHLSzro3ZcqazqnZyfpZDgtvMFjCPWH3nFg3Nmd+nNS4nIWYvCGGY
         w5iso0d6aQixHwFe6v7uZeTkJOcEsSZ6PVnwXXzOU2wFuSiNNsltEfP5XzblRqTmzUZq
         BzyDy60PEcg7zGtQqAa2IzH7F5JvuHYhtDSy0ytZiIyFVlG1CXVqkJZH4fjPqzz4xXFv
         BGnQsWymBeIrVMEbExmQgHP/IiJnmn4abHfnmxPXBBDNpIJWiSU1ewqBXsVg+ISB+d/I
         jW4g==
X-Received: by 10.152.43.43 with SMTP id t11mr4013106lal.74.1431245988235;
 Sun, 10 May 2015 01:19:48 -0700 (PDT)
Received: by 10.112.74.133 with HTTP; Sun, 10 May 2015 01:19:48 -0700 (PDT)
In-Reply-To: <xmqqpp6cnnyr.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268727>

Hi Junio,

On Fri, May 8, 2015 at 4:15 AM, Junio C Hamano <gitster@pobox.com> wrote:
> I do not think touching this test which does not have anything to do
> with "git pull" in your series is sensible at all, and you shouldn't
> flip test_expect_success temporarily to _expect_failure, if that is
> what you have in mind.
>
> Just don't run unrelated tests while your series is in flux.

Yes, you are right, these patches are not related to the topic at all,
and I will drop them.

Just to make myself clear though, the issue I have is that
git-submodule and the various diff commands do not depend on
git-pull's functionality at all. If only git-pull breaks, these
command will continue to work perfectly. However, if all the tests in
t7406 and t4013 break as well, I would consider that misrepresenting
the problem.

Not that this is really a big problem anyway, the entire failing test
suites just surprised me, that's all. Sorry for the noise.

Thanks,
Paul
