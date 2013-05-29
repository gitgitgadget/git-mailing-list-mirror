From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v2 7/8] revert/cherry-pick: add --quiet option
Date: Wed, 29 May 2013 19:02:47 +0530
Message-ID: <CALkWK0=VieCwZS4ua-eyg3t-cqC2Y+ifa-G7gwJ=Mxt0cfoD1g@mail.gmail.com>
References: <1369799788-24803-1-git-send-email-felipe.contreras@gmail.com>
 <1369799788-24803-8-git-send-email-felipe.contreras@gmail.com>
 <CALkWK0=QyznWZt4sJCok9OZxjrdjtMTtpStA8LHdCCbn0Oi6TA@mail.gmail.com> <CAMP44s0M8dg_8ke3p1wJtnPrjdtH0L-D3ZgnPPCSKH0Mx0Z=GA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@inf.ethz.ch>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 29 15:33:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhgVW-0000wJ-S6
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 15:33:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966020Ab3E2Nda (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 09:33:30 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:47498 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935145Ab3E2Nd2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 09:33:28 -0400
Received: by mail-ie0-f177.google.com with SMTP id 9so23474027iec.8
        for <git@vger.kernel.org>; Wed, 29 May 2013 06:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=kxSj9+/9vN2uLUxnvx/SEZVBdWeIwiQJzJ6v1piLQ08=;
        b=mfsYqm/QrYF59SU4G5/9K9ad4DwNTfbkq7HnGGag3uie8SP5GOMmIsV7aRX96LDUTU
         DeY5Jq7nOb7iQzFNp1WR7bvnaGSglOsq59kZ/4kW/1PymBlkQuqT/NV+dmICApbcqpGS
         0b170Cv2owUwCFZBPW6IAYnX/TBfNGoOunUUgHBhRy4B6ov6PmY22CKRF1Oskf13/LLV
         Y5POmrAP92k+JFNQgPomDaqR8Cify1V8Fc0vf4Na1DG05S1n/5th+e3MiurJ1PNUqwrV
         uEe9YOvisEmZ5CUmgQDjkjbV8sFMTvYJROplr8lHTtex61rIPUvBYh5hJUY/qMHtyLHN
         lwTg==
X-Received: by 10.50.141.230 with SMTP id rr6mr9330933igb.89.1369834408413;
 Wed, 29 May 2013 06:33:28 -0700 (PDT)
Received: by 10.64.226.135 with HTTP; Wed, 29 May 2013 06:32:47 -0700 (PDT)
In-Reply-To: <CAMP44s0M8dg_8ke3p1wJtnPrjdtH0L-D3ZgnPPCSKH0Mx0Z=GA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225818>

Felipe Contreras wrote:
> Did you miss the -q option passed to 'git commit'?

Ah, yes.

It would help if you mentioned:

    Introduce --quiet to suppress warning about skipped commits (when
using --skip-empty) and output from 'git commit'.

in the commit message.

Thanks.
