From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: What is missing from Git v2.0
Date: Tue, 22 Apr 2014 03:11:50 -0500
Message-ID: <5356244680af3_3d2216372ec4@nysa.notmuch>
References: <CAMP44s17h4Tjg+VaMF0atLep8t-0HVp4UDr1WE2wYnEuZ07eaQ@mail.gmail.com>
 <53557071.5040500@gmail.com>
 <xmqqtx9m8obr.fsf@gitster.dls.corp.google.com>
 <CAHGBnuMty-86jfUto=L3muhgEVwVE70FQQY2FJ1bn7AUjfEtLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Sebastian Schuberth <sschuberth@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 22 10:22:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcVy9-00040v-LX
	for gcvg-git-2@plane.gmane.org; Tue, 22 Apr 2014 10:22:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752715AbaDVIWR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2014 04:22:17 -0400
Received: from mail-ob0-f173.google.com ([209.85.214.173]:38643 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755095AbaDVIWO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2014 04:22:14 -0400
Received: by mail-ob0-f173.google.com with SMTP id wn1so5363438obc.18
        for <git@vger.kernel.org>; Tue, 22 Apr 2014 01:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=jXrygCpkjD6gCOdC2VT4Gh7Ud3pJP28HuVsWPKjB+6I=;
        b=GxVo0NPsKS4ZORSiwuBIdLy5cV+qT4RDE23MZ60B/eqQfKWfN6R0G1z2oZGvqyBQu3
         x3bcXlsWrIsiSGiWu2mJqbiVJ8dZpmL6t9o90I0kFw3GteDgPCxaFP55Od9oae9At1ZC
         KGUV7PR/wKumT92Cd5xoQJed6IFMoPrGU4/buQWYVTseapHw5JQJt8NdvcDMad5big85
         H4nBNNymlNAT5qZEj6h4wDy4/oDSVCQm1aX5F/ba+q8FXNB1N0sBzSGiOPKyUkME/IOG
         CGDxVo0oMiNmLzInZ9NVK9G1gUQwHFaG5OxMJinFS0Mpzk3VfceTws4ra12h2QygWvKh
         XeZQ==
X-Received: by 10.60.98.139 with SMTP id ei11mr10909608oeb.43.1398154934155;
        Tue, 22 Apr 2014 01:22:14 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id su13sm175106303oeb.9.2014.04.22.01.22.11
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Apr 2014 01:22:12 -0700 (PDT)
In-Reply-To: <CAHGBnuMty-86jfUto=L3muhgEVwVE70FQQY2FJ1bn7AUjfEtLQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246717>

Sebastian Schuberth wrote:
> On Mon, Apr 21, 2014 at 9:39 PM, Junio C Hamano <gitster@pobox.com> wrote:
> 
> >> If we don't standardize this now people will come up with their own
> >> definitions [1] [2] (and many others if you just search GitHub) which
> >> are again likely to differ (slightly), hindering interoperability.
> >
> > I am afraid that that ship has sailed long time ago, though.
> 
> That's most likely true, but it does not get better by postponing this
> even more. I still think there's value in introducing this now, Git
> still attracts new developers every day. In fact, I currently see a
> leap forwarding in the Windows world towards Git, caused by some
> rethinking and structural changes in some big companies.

Exactly. If one thinks in terms of years, sure, it might make sense to not
change the status quo created by years back. But think about Git in a decade or
two, at that point surely you would have wished that you had considered these
kinds of changes sooner.

Junio at some point suggested to think about features for v1.8.0 as if we were
starting from scratch[1]. I'd say if there has every been a time to add default
aliases after v1.0 it's certainly v2.0.

Our future users who might have not touched Git yet would certainly welcome
this.

[1] http://article.gmane.org/gmane.comp.version-control.git/165735

-- 
Felipe Contreras
