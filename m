From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 00/19] Index-v5
Date: Sun, 14 Jul 2013 09:59:00 +0700
Message-ID: <CACsJy8AhmYBjzqPtF3f9Gk8hq2bk8-PtFCto9_4AkRePomvhAQ@mail.gmail.com>
References: <1373650024-3001-1-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Thomas Rast <trast@inf.ethz.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 14 04:59:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyCXO-0005X5-K3
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jul 2013 04:59:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752211Ab3GNC7c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Jul 2013 22:59:32 -0400
Received: from mail-ob0-f177.google.com ([209.85.214.177]:51525 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752192Ab3GNC7b (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jul 2013 22:59:31 -0400
Received: by mail-ob0-f177.google.com with SMTP id ta17so12652074obb.36
        for <git@vger.kernel.org>; Sat, 13 Jul 2013 19:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=IAjUtwCo0e62wv4gPANXPcDke/6C/fjL3Af7J4CE3BI=;
        b=IgbalS9DyFnmqEKNOd8jhqaB5TD3HgWt4+Jo11cMiQmo/6+g3HL92o6eqb4mv4Q+3x
         YSIJMQUNsEr3OA/Pb4PEQY243oaqx8uysC3ctk9VvUuloNZZ7QTp/WVJk9OXvsdVY7Co
         m8W1CcCYdCZIdrbPTnts3kWTaq6PNdAHbCgSMy7iLr76NNuuj+S8tK9F2KRdhNdkBYed
         nSUxGH85MKY5VQEO9Ii2LXqUC+TdM9T9X5bT/GAmEeQQdOq14RYKgSwQpVia3woDdT2M
         RSwGX6l0Tis4tMtEwjuwVIXFGmEWv+tjfmig6xNMcXUGVZBDLHXojjwnoEgvfBjCLxMU
         6KEA==
X-Received: by 10.60.54.232 with SMTP id m8mr39769249oep.35.1373770770742;
 Sat, 13 Jul 2013 19:59:30 -0700 (PDT)
Received: by 10.76.88.230 with HTTP; Sat, 13 Jul 2013 19:59:00 -0700 (PDT)
In-Reply-To: <1373650024-3001-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230300>

On Sat, Jul 13, 2013 at 12:26 AM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
>  t/perf/p0003-index.sh                            |   59 +
>  t/t2104-update-index-skip-worktree.sh            |    1 +

For such a big code addition, the test part seems modest. Speaking
from my experience, I rarely run perf tests and "make test" does not
activate v5 code at all. A few more tests would be nice. The good news
is I changed default index version to 5 and ran "make test", all
passed.
--
Duy
