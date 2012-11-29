From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Millisecond precision in timestamps?
Date: Thu, 29 Nov 2012 08:22:14 +0100
Message-ID: <CAMP44s3ShoR7iR5QLYn_u+u_nNGnS1jumpt+iseWYKx0PX9UEA@mail.gmail.com>
References: <20121127204828.577264065F@snark.thyrsus.com>
	<CAJo=hJtZ+n+D4pOmeNApDeLNyZYeqnEDDYJWwSj_wLauQ+w4hQ@mail.gmail.com>
	<7vzk22lmz9.fsf@alter.siamese.dyndns.org>
	<20121127230419.GA26080@thyrsus.com>
	<CAJo=hJtOqRHcjWH1F71Qc5zvPkUAe+u1RrcC2pt_xQwLSUY0yg@mail.gmail.com>
	<20121128001231.GA27971@thyrsus.com>
	<CAMP44s3hpuxbo7mfKAD2trOkezPrV3nKYpNAzXOs3sQym102LQ@mail.gmail.com>
	<CAJo=hJuskvYaNTtCcTSqvU8YwEU=HwRpb_sqW-BSxfSr7xE57A@mail.gmail.com>
	<20121128011750.GA23498@sigill.intra.peff.net>
	<7v7gp6i3rx.fsf@alter.siamese.dyndns.org>
	<CABYiQpmEpdf3L56NYSvPWovNOs_ifqj5QctuPSMoygHyMrz8+g@mail.gmail.com>
	<CAMP44s3MPMySnwjWjzo4aRX05u05xratgiyiYJUYPmnV2WK6kQ@mail.gmail.com>
	<CABYiQpnEZECU5Vj5JzMimtw-CAJQz2d=3rii4gM6d37wCnO5AA@mail.gmail.com>
	<E4C993F4-B7A4-4CB6-A9EA-BFE98BE3A381@gmail.com>
	<7va9u0sx26.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Steven Michalske <smichalske@gmail.com>,
	Thomas Berg <merlin66b@gmail.com>, Jeff King <peff@peff.net>,
	Shawn Pearce <spearce@spearce.org>,
	Eric Raymond <esr@thyrsus.com>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 29 08:22:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdyS7-0003H5-DH
	for gcvg-git-2@plane.gmane.org; Thu, 29 Nov 2012 08:22:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751127Ab2K2HWQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2012 02:22:16 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:45769 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751062Ab2K2HWP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2012 02:22:15 -0500
Received: by mail-ob0-f174.google.com with SMTP id wc20so12744443obb.19
        for <git@vger.kernel.org>; Wed, 28 Nov 2012 23:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=LwZucs8RR1qEcruJ5As5uE7tYSBs4acyw/kGUfWR0AE=;
        b=izhPTZYwxKEeFsyInYFaU8rj2Hx+aoAOIL74ndouSG+ERU8GM7uZeCqe7H3vCl+IuE
         lFAmRSMUHUypQatZbnCW2TfOT4UZFRmqMMM0o5xdOvYaLL+9c+fFOzywYMxFI/5LrGEF
         JF2TzcGyRdy5MmDMo3CrW0T5aUz9j0p/tAcf81dk/gYxJzKbPoG5PmXJR81KIkL0cTDH
         DMuKe7w7DgHDmaR/+CeX0k4E0/xTfN9cCE9PlUy/hM2ordSMiGCS0Lh0VDWMBxD8K9KC
         ltT6Hg9YZ3y+GzdUfsqEccVYGcPRiiIejMZWkKblP7fALflOBIHwMiUsxM4+75aJEqqz
         Yq8w==
Received: by 10.182.98.19 with SMTP id ee19mr7044589obb.90.1354173735065; Wed,
 28 Nov 2012 23:22:15 -0800 (PST)
Received: by 10.60.32.196 with HTTP; Wed, 28 Nov 2012 23:22:14 -0800 (PST)
In-Reply-To: <7va9u0sx26.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210816>

On Thu, Nov 29, 2012 at 8:11 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Steven Michalske <smichalske@gmail.com> writes:
>
>> Would having arbitrary key value pairs be useful in the git data
>> model?
>
> My answer to the question is that it is harmful to the data model,
> but the benefit of going against the data model _may_ outweigh the
> downside.  It is all relative.

If git doesn't provide the capability, people will keep using the
commit message to store that extra information, which I would think is
even more harmful. An standard 'commit-extra' note or something would
help deal with that.

Cheers.

-- 
Felipe Contreras
