From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 0/4] remote-hg: more improvements
Date: Fri, 09 May 2014 12:59:57 -0500
Message-ID: <536d179d80c86_a7adc530c7a@nysa.notmuch>
References: <1399169814-20201-1-git-send-email-felipe.contreras@gmail.com>
 <xmqq8uqdbgqg.fsf@gitster.dls.corp.google.com>
 <xmqqha515ebt.fsf@gitster.dls.corp.google.com>
 <536adf96f37ec_3caaa612ec69@nysa.notmuch>
 <xmqqtx902k45.fsf@gitster.dls.corp.google.com>
 <536be16ba5ef1_3ce710a12ecdb@nysa.notmuch>
 <xmqqppjn29o3.fsf@gitster.dls.corp.google.com>
 <536c084ecb546_4f6fd2f30cdd@nysa.notmuch>
 <xmqqha4z27ly.fsf@gitster.dls.corp.google.com>
 <536c15cf8594b_6f3bb152ecb@nysa.notmuch>
 <xmqq61le27p5.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 09 20:00:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wip5g-0002MA-29
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 20:00:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754499AbaEISAF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2014 14:00:05 -0400
Received: from mail-yh0-f47.google.com ([209.85.213.47]:54756 "EHLO
	mail-yh0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751056AbaEISAE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2014 14:00:04 -0400
Received: by mail-yh0-f47.google.com with SMTP id z6so3675301yhz.34
        for <git@vger.kernel.org>; Fri, 09 May 2014 11:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=/fm9NZ8511nlLPKxs3gKIW3nt6mtEw/jzieH80rCVi8=;
        b=SXMo6hitGIBQ3T+ay/r1SzW4GiSD7wckMgXGOViYM9zy7c9gz8TczoMWvnEYIP488E
         mcojVmHL3KdX1jXhjfE9FTTUJwhU/IjPJnCiee/PsEikbClodYs6XQCULKHr+UB9rpt9
         /jsKF5OpkI0yBDSN34vnPC00M8gqoxvf6ormSYBZ7eoAYYGwJweIAfFmclg8AYtskF42
         UFkcG3nW98eAsNzkQdDQ5X2ix7z3q7GqRvgFGd7iBFbo9SdJrP1AdFI/kYyU+/vbFl7I
         oOVIRXV/dr8mbs03gmP8vZ3KxvpUo0zmmIZ7Az8H9MUvIGtY2c8w9000mTCtDvDBqMhI
         kzxA==
X-Received: by 10.236.148.244 with SMTP id v80mr17478640yhj.19.1399658403424;
        Fri, 09 May 2014 11:00:03 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id n5sm7138354yhn.43.2014.05.09.10.59.59
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 May 2014 11:00:00 -0700 (PDT)
In-Reply-To: <xmqq61le27p5.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248601>

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > Junio C Hamano wrote:
> >> Felipe Contreras <felipe.contreras@gmail.com> writes:
> >> 
> >> > I already said this multiple times, but let me be clear once more:
> >> >
> >> > MASTER HAS A REGRESSION (for all versions of Mercurial).
> >> 
> >> As you said, that is not a regression, isn't it?  It is an old
> >> breakage that existed even before 1.9 (was it 1.8.3 or something?)
> >
> > No. It does't happen in 1.9, it will happen in 2.0.
> >
> > That's a REGRESSION.
> 
> You earlier said in our exchange:
> 
>     > Wrong. The code in question was not recent, it was introdued in 1.8.3,
>     > more than one year ago.
> 
> and "git blame -L870,880 contrib/remote-helpers/git-remote-hg" does
> show that 68d4f4f3 (remote-hg: custom method to write tags,
> 2013-04-22) is the culplit that has introduced ManifestLookupError.

That is not a regression. It's not the issue I'm talking about.

> And it is in since 1.8.3.

That is a coincidence.

> How does it break 2.0 and without breaking 1.9?

I said it breaks ALL VERSIONS. You are looking at two issues that are
unrelated to the one I'm talking about.

> If this were a core part of the system the only sensible thing we
> can do at this point is to revert at this late stage of the cycle,
> but I do not think I have time to bisect and find that culprit, as
> today is when -rc3 has been scheduled to happen.

You won't be able to find the breakage.

Good luck with your tree.

-- 
Felipe Contreras
