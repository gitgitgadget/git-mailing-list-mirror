From: Stefan Beller <sbeller@google.com>
Subject: Re: t7300-clean.sh fails "not ok 32 - should avoid cleaning possible
 submodules" on debian jessie
Date: Tue, 7 Jun 2016 08:46:01 -0700
Message-ID: <CAGZ79kYb0+=fr_wp4FOMdCcNL2O0D9ktJLDqGs6DueRg+7aO9w@mail.gmail.com>
References: <5756856A.4020406@debian.org> <alpine.DEB.2.20.1606071229500.28610@virtualbox>
 <5756C6F4.5050300@debian.org> <CAGZ79ka5J9xEW=ps6kM6Gm2NU67_hv792-dJThf=GOd0tZG-Mw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Pirate Praveen <praveen@debian.org>
X-From: git-owner@vger.kernel.org Tue Jun 07 17:51:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAJCj-0002ZH-RO
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 17:46:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755724AbcFGPqF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2016 11:46:05 -0400
Received: from mail-qg0-f52.google.com ([209.85.192.52]:34190 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750893AbcFGPqE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2016 11:46:04 -0400
Received: by mail-qg0-f52.google.com with SMTP id p34so60303830qgp.1
        for <git@vger.kernel.org>; Tue, 07 Jun 2016 08:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=BD467X7R7f8gP8iZbgVV8U3WZh0WKdNV5XPFPBLI0yQ=;
        b=UCN5S1+mhbXevJZBe1G16YrNNrYNjFtTMEj6gQga7ZnqYGdW5GC5kG5BFqEHo9I80k
         FbqIQzOqgv+Denovic/xL+8ITuXBWsVi24lQ+x8PaJMYl896obCTM6CIL/vcLEql09n1
         qeo4Wr2JP5SEDH1RtfpzudJmJ249x+6TpAXO5E2pHxEXqlV7BoxhQMo0fUH9kaUFBFQ6
         l1nyR+9RdZJQd2wYCj7AZiMmnCsyoGLQOsQEtYHiFcEpjPq6UKZPH5OOO7i7oiUWVGDG
         BjfX+YM1MVXNv+wD1bkfcg7Ry1pRG9Xwgv07E9I246xGV3Mhb043eDqxuLVCHygm+Log
         X6Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=BD467X7R7f8gP8iZbgVV8U3WZh0WKdNV5XPFPBLI0yQ=;
        b=hyY8obv7B/iZtlHmkYLQukyZadBHfz31FYrziiQCE9UZTkHAIKZJ7zIVOcjkGtQTnh
         TK5zsJB8t9M68VuMvzxmwU0jGlJBrAr4qcf70rmP2Rqh1WQAo3v805u0e/tIHIfvIVcS
         Wq6pwyKwHG5ODz0MPN+Kfd3FH56cuufDa7J1N2651yeZj8EY2ZOVfJk2cSqypQqEvjTH
         brrtmqD2CMeNPmQL1oWzD3c4Dz6mefbdB0JFM4lm6rZ6MKq3JX2KcRzpZhfakpF9F+pB
         KS3gs65t2ber1n8oqm66iJwtBRUy13p2n/upBuNKhykmg74TfwzhEAHUOHgMQgAbHKR/
         hsAA==
X-Gm-Message-State: ALyK8tLnbKEUgN6t7XWY31dinTxNyzUMmE39UzjdnIecGNdIR56w7P+V9Qg6rCxO95ySMTCbuSjUBHwjGKX8DsFn
X-Received: by 10.140.81.145 with SMTP id f17mr106479qgd.84.1465314362218;
 Tue, 07 Jun 2016 08:46:02 -0700 (PDT)
Received: by 10.200.55.212 with HTTP; Tue, 7 Jun 2016 08:46:01 -0700 (PDT)
In-Reply-To: <CAGZ79ka5J9xEW=ps6kM6Gm2NU67_hv792-dJThf=GOd0tZG-Mw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296694>

On Tue, Jun 7, 2016 at 8:43 AM, Stefan Beller <sbeller@google.com> wrote:
> (Are you telling me that patch is faulty?)

The patch is not part of v2.8.1 but part of v2.8.3,
so take a later version, or cherry-pick that patch manually.
