From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] Git v2.4.0-rc2
Date: Wed, 15 Apr 2015 22:53:39 -0700
Message-ID: <CAPc5daXYgub5-qG2S7LdTuUAnut4B-qaSeQMNJpoGzORdvZpcA@mail.gmail.com>
References: <xmqqlhhu1iv7.fsf@gitster.dls.corp.google.com> <CAGyf7-H_Njn8poGKnvgjq+0bKhHfs7S7qaFkDHsqa4NVUjt4EA@mail.gmail.com>
 <20150416022216.GA30991@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Bryan Turner <bturner@atlassian.com>,
	Git Users <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 16 07:54:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YickY-0006Jl-C2
	for gcvg-git-2@plane.gmane.org; Thu, 16 Apr 2015 07:54:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751793AbbDPFyB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2015 01:54:01 -0400
Received: from mail-ob0-f178.google.com ([209.85.214.178]:33236 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750946AbbDPFyA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2015 01:54:00 -0400
Received: by oblw8 with SMTP id w8so35553384obl.0
        for <git@vger.kernel.org>; Wed, 15 Apr 2015 22:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=/GYgU/Rp//nxIsAFT6XEPTNLFa7WOzfqB3OtPZwQ3Po=;
        b=McDi84tQX+SFRtNp2hOOBHxvoQQAEIbbxnDk72iaJWbtH9Tec9R5P2ieyURJ38rJLA
         rWq+nVrmHM3MsYfg4H4455bMqxdxS8sZ/ENJXIjHd7z49ZuPkejFNE3uLz3Yz7jalNo1
         IULoGxxgZd2DeBtuLCLiyHal32AVr9XQhlSUiGkCFbXwiVUyRkRL4/B43Kp9sBDDmC3P
         wQOc12ZKpkN0usgn++LH/a9WAlcDhjbWrOzWZNeAXxTEHne7wUBPvsyGaPaEHMzu3C3/
         gkN24BvxsjZZfaV9/6pfq2U7ZVD4IO/SPHLD7mL8hhtmSrc8zATGhjClUCy5Xgg1t2Qp
         3PKA==
X-Received: by 10.202.200.209 with SMTP id y200mr18559629oif.20.1429163639592;
 Wed, 15 Apr 2015 22:53:59 -0700 (PDT)
Received: by 10.202.197.18 with HTTP; Wed, 15 Apr 2015 22:53:39 -0700 (PDT)
In-Reply-To: <20150416022216.GA30991@peff.net>
X-Google-Sender-Auth: clHB0khb89cWFC5YfjyWt0y4C3Y
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267249>

On Wed, Apr 15, 2015 at 7:22 PM, Jeff King <peff@peff.net> wrote:
>
> In the meantime, unless somebody is planning to jump on this topic
> immediately (I am not), I think we can revert 2bf15a3330a from master.
> It's definitely fixing _a_ problem, but it's one we've lived with for
> many years already.

Yeah, I agree. Nobody should be reading the output to find CONFLICT
anyway (isn't "ls-files -u" for these scripts?), but the current error/info
levels do look inconsistent.
