From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: Re: [PATCH v7 2/7] tests: paint known breakages in yellow
Date: Fri, 21 Dec 2012 17:59:52 +0100
Message-ID: <50D49588.60305@gmail.com>
References: <1356059558-23479-1-git-send-email-gitster@pobox.com> <1356059558-23479-3-git-send-email-gitster@pobox.com> <50D4230F.9080502@gmail.com> <7vd2y32ys0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Adam Spiers <git@adamspiers.org>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 21 18:00:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tm5xJ-0006mU-6W
	for gcvg-git-2@plane.gmane.org; Fri, 21 Dec 2012 18:00:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751504Ab2LURAA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2012 12:00:00 -0500
Received: from mail-bk0-f41.google.com ([209.85.214.41]:49212 "EHLO
	mail-bk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751091Ab2LUQ77 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Dec 2012 11:59:59 -0500
Received: by mail-bk0-f41.google.com with SMTP id jg9so2560655bkc.0
        for <git@vger.kernel.org>; Fri, 21 Dec 2012 08:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=UzVM7ZRr0Y3yQQRK9JoVik4Qubkc2ngqc+hiZj4WNfg=;
        b=oNtdSce2TiGAT+3FZHeo1+JsKZWxI2BmyUhUeYZd2YHAR39qbsgnuyP78DaIE8k8TA
         UA4dFD9YMEmq89AqT3bL34FVL1y0/rq+mSRKSnshGsAaIQzrKs76JiDkD3BUjEDAWozT
         vlDvvEJ2rDTzbuHkG4+hdvV3RBwLzkMGRXRzJVKcZP+ClC4VnRj0xI/Jtrgivi3eoVkV
         NtSIBw78VMb1PT94iHPHSrGxTFytOQKa7WzmD2W5EA8PMJctVaQKdYj1ZKYXxpTFcS8C
         Bjy2NQkMtVr8VP/2UDROhFWhd4mJ4vGgAIQ2btY51K/fcLl0uEvsSR/wrEsj6s3PZLZf
         Bk0A==
X-Received: by 10.204.131.76 with SMTP id w12mr6636564bks.44.1356109197719;
        Fri, 21 Dec 2012 08:59:57 -0800 (PST)
Received: from [192.168.178.21] (host137-94-dynamic.4-87-r.retail.telecomitalia.it. [87.4.94.137])
        by mx.google.com with ESMTPS id l17sm10683820bkw.12.2012.12.21.08.59.55
        (version=SSLv3 cipher=OTHER);
        Fri, 21 Dec 2012 08:59:56 -0800 (PST)
In-Reply-To: <7vd2y32ys0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211985>

On 12/21/2012 04:46 PM, Junio C Hamano wrote:
>
> [SNIP]
>
> The only thing the additional knowledge adds seems to be to give
> rationale for the old choice of "bold green"---it was not chosen
> from thin-air but can be viewed as following the automake/autotest
> scheme, and other systems cannot agree on what color to pick for
> this purpose.
> 
> I do not see a need to justify why we chose differently from
> automake/autotest; we could say something like:
> 
>     Yellow seems a more appropriate color than bold green when
>     considering the universal traffic lights coloring scheme, where
>     green conveys the impression that everything's OK, and amber that
>     something's not quite right.  This is in line with what 'prove'
>     uses, but different from 'automake/autotest' do.
> 
> but we are not in the business of choosing which is more correct
> between prove and automake/autotest, and I do not see how it adds
> much value to tell readers that color choices are not universally
> agreed upon across various test software suites---that's kind of
> known, isn't it?
> 
> So...
>
That is fine with me, I just pointed it out because I suspected not
everybody was aware of all these details.  If you decide they don't
matter, it's perfectly OK -- but at least now it's an informed
choice ;-)

Thanks,
  Stefano
