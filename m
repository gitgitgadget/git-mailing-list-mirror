From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 7/9] remote.c: teach branch_get() to treat symrefs other
 than HEAD
Date: Thu, 2 May 2013 20:07:09 +0530
Message-ID: <CALkWK0=FbbCferG+q4qymvsm-t_rfSBRZfp7t3kO=z-EF5QYuA@mail.gmail.com>
References: <1367501974-6879-1-git-send-email-artagnon@gmail.com> <1367501974-6879-8-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 02 16:37:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXudu-0004vV-Ue
	for gcvg-git-2@plane.gmane.org; Thu, 02 May 2013 16:37:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758866Ab3EBOhu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 May 2013 10:37:50 -0400
Received: from mail-ia0-f173.google.com ([209.85.210.173]:45244 "EHLO
	mail-ia0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758008Ab3EBOht (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 May 2013 10:37:49 -0400
Received: by mail-ia0-f173.google.com with SMTP id l25so518288iad.18
        for <git@vger.kernel.org>; Thu, 02 May 2013 07:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=DQFiOFYBenEYEvRTIiQiOedVJCFoNwAAg5LxlA1rnrc=;
        b=HPXpqzQeMtlxFxwn1tNYeePFAFMs3UWH1YbAnbl/J3EmTBpjrXkDbnQs1msy8UJvso
         DyxPni2xJlQQDX1dhH+DU0/PXVjiVaKam7QoI1j/HJyT94sujfAI1ayNYVP2ArKgtZFV
         /ZsLB2bW9fIL+FpJg7Mkr4lUGgqPORtZa7302PpDB8vhnm1VlksX4nT+GRrYkrHdLxjw
         5JsbzWO5GLOw499oYZhkHZyCvtQ0qrqT3lrI+sFQZLiENzwzUS/8vWmovE/ugpKde8qk
         S5VTfyJeryRm2215IrSvaxGyPI7WcME52ZB/cHR+JCjFN+c/74YTWgHjwWw1wZElCO2e
         EZPg==
X-Received: by 10.50.66.197 with SMTP id h5mr14892154igt.63.1367505469379;
 Thu, 02 May 2013 07:37:49 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Thu, 2 May 2013 07:37:09 -0700 (PDT)
In-Reply-To: <1367501974-6879-8-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223209>

Ramkumar Ramachandra wrote:
> [...]

So sorry about this, but this breaks some tests in t1507
(rev-parse-upstream).  I'm looking into this now.

In the meantime, reviewers can focus on the commit message.
