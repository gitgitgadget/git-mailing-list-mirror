From: Fabian Ruch <bafain@gmail.com>
Subject: Re: [PATCH v1 00/19] Enable options --signoff, --reset-author for
 pick, reword
Date: Mon, 04 Aug 2014 10:37:33 +0200
Message-ID: <53DF464D.5020403@gmail.com>
References: <53A258D2.7080806@gmail.com> <cover.1406589435.git.bafain@gmail.com> <20140802135255.GA4185@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Aug 04 10:37:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XEDm2-00066e-HV
	for gcvg-git-2@plane.gmane.org; Mon, 04 Aug 2014 10:37:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751809AbaHDIhi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2014 04:37:38 -0400
Received: from mail-wi0-f182.google.com ([209.85.212.182]:51502 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751796AbaHDIhh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2014 04:37:37 -0400
Received: by mail-wi0-f182.google.com with SMTP id d1so4563162wiv.15
        for <git@vger.kernel.org>; Mon, 04 Aug 2014 01:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=WcM5b/pTSOakkfAKlkXQR0A2c1BwipRtinq+FJdfo2o=;
        b=CHpmUVgz/LWShnmQf7ahT+/m0HDZGuI5GH4CqQnFOGDk5Skrh9JBgvL+2QtlNBVAaO
         e0RM9NNmCUrkWfITY3OODVaohG23XbxoNTTHt1vQ4Q5wkFugmHbg+didA7mEjfDFoj3D
         OzY12pDKFFUSd2lVfHZH6zkPkBiGtDqix7UIkZ5ZGq76r5nlwqm/id5YU6/6z08uO0w1
         L6mSg2+O/wQOyCZ3pHm4IHdtqqXLGQkqc28Fs76wOU6Tqp567qPHMGwk9Fogz3XO6hJH
         fa+NV1ENQynRjh1Ak5y+GjMwRvkI8JnHt6i4KTezbvh6jDdSJXZxBlKQAURcxE37cize
         zZig==
X-Received: by 10.180.19.200 with SMTP id h8mr27966061wie.32.1407141456470;
        Mon, 04 Aug 2014 01:37:36 -0700 (PDT)
Received: from client.googlemail.com (nat-wh-nan.rz.uni-karlsruhe.de. [141.70.81.135])
        by mx.google.com with ESMTPSA id wi9sm41862296wjc.23.2014.08.04.01.37.34
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 04 Aug 2014 01:37:35 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <20140802135255.GA4185@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254733>

Hi Peff,

Jeff King writes:
> On Tue, Jul 29, 2014 at 01:18:00AM +0200, Fabian Ruch wrote:
>> this is a reroll of the patch series that enables rudimentary support
>> of line options for git-rebase's to-do list commands and reimplements
>> the well-known commands `reword` and `squash` in terms of a
>> parameterised `do_pick`.
> 
> I just finished reading over the whole series (which is my first real
> exposure to it). With the exception of the comments I already sent, it
> looks pretty reasonable to me.
> 
> Thanks for splitting it and writing good commit messages; that made it
> relatively easy to follow what was going on.

Thanks a lot for taking the time.

Your review revealed more shortcomings of the patch series. Now that the
replay of root commits is logged, the log is dumped on the console even
in non-verbose mode. And, I must admit that the fact that `--no-edit`
hasn't been a (documented) feature of git-commit for all time didn't
struck me at all as a possible reason for using `-C`, which is a little
embarrassing.

I will include more details in separate replies to your comments later.

   Fabian
