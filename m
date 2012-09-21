From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: How do I run tests under Valgrind?
Date: Sat, 22 Sep 2012 02:16:07 +0530
Message-ID: <CALkWK0=ZCCoNhtvf0VyLGbcssLOKF5FYKf83xYki4fr69b2LFg@mail.gmail.com>
References: <CALkWK0m_9OsAfG_pF3hUDW+EKCyZCn9NiDKKEW6AEOMmAw=yuA@mail.gmail.com>
 <20120917172022.GA1179@sigill.intra.peff.net> <CALkWK0m378ApSwa1xiYUqEjMny5m0wt3KacqdDRU1qt=cw6k8g@mail.gmail.com>
 <20120917173531.GB1179@sigill.intra.peff.net> <CALkWK0kDPGY_3v5SLPtyf+azUwA7msvQOvA+MaCgueZ71i2yGw@mail.gmail.com>
 <20120917174439.GD1179@sigill.intra.peff.net> <CALkWK0mkBbY7dUyaZAqqKE3ZMfE_xU6em_KCOKM9nsTjUP-9pA@mail.gmail.com>
 <20120917182957.GF1179@sigill.intra.peff.net> <CALkWK0=nMxNfmAaBTmXeADQubTayC_2_ut5Nq3QXba9yfQr9yA@mail.gmail.com>
 <CALkWK0kWvrirPjXXzBBBQxKDcwpd_+nQ2eeT6SE8gDFW5T7WFQ@mail.gmail.com>
 <505CCA55.6030609@gmail.com> <CALkWK0mk6m44J8nuqVUvgxWE+RoRtg+uAewyYjwDRFS+fDkNRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>
To: Stefano Lattarini <stefano.lattarini@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 21 22:46:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TFA7U-00021F-9h
	for gcvg-git-2@plane.gmane.org; Fri, 21 Sep 2012 22:46:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932493Ab2IUUq3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2012 16:46:29 -0400
Received: from mail-qa0-f46.google.com ([209.85.216.46]:40936 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757828Ab2IUUq2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2012 16:46:28 -0400
Received: by qaas11 with SMTP id s11so1599587qaa.19
        for <git@vger.kernel.org>; Fri, 21 Sep 2012 13:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=3LlRTum+q5hWoS9zF9gkK0YIA/QJeZ0wfYLnRb7H94c=;
        b=ka7MwZMwGR1K0uCo1KqYWdviS94gQEFYoKk0CTCehkl8oks/cidgMrjZbFDBVnfI3k
         7SRBxCO71xldwrSkngZIughAC1BcHlKybw69ONeCjQ8YxwVyLMsb3aI+sJmVotkNQbeP
         SSrf0+u/BWzzTbifXIMrvixwkz4bSQUT+80hmgvBL45fheeRycBlRdhVQSwLlGEYgsuW
         77R3O6FlkiZSGExnnWrXw5XHLQ8w4VSe0L8ziDbafU83rWU9lbkU8/UCvgwBpumzAaHh
         Kpapd0o4AENKSMrsgsajpDVlIe3bnGJPKd6mPT1rF0zEyFgyy3LBDjtoQCUnUKgzAZZU
         L7oA==
Received: by 10.229.136.17 with SMTP id p17mr4124249qct.86.1348260387446; Fri,
 21 Sep 2012 13:46:27 -0700 (PDT)
Received: by 10.49.84.105 with HTTP; Fri, 21 Sep 2012 13:46:07 -0700 (PDT)
In-Reply-To: <CALkWK0mk6m44J8nuqVUvgxWE+RoRtg+uAewyYjwDRFS+fDkNRw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206160>

Hi again,

Ramkumar Ramachandra wrote:
> ... but didn't we set $IFS for this purpose?  The following segment of
> code works:

I'm sorry, it doesn't.  That is the problem.

Ram
