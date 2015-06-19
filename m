From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH/WIP v3 10/31] am: refresh the index at start
Date: Fri, 19 Jun 2015 16:07:05 +0800
Message-ID: <CACRoPnRRPLRTsLkKem3QsGiLV3BpEBXNdrtoDHWfXfoR2yCDYg@mail.gmail.com>
References: <1434626743-8552-1-git-send-email-pyokagan@gmail.com>
	<1434626743-8552-11-git-send-email-pyokagan@gmail.com>
	<xmqqlhfgd7vf.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 19 10:07:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5rKb-0000oh-RN
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 10:07:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932164AbbFSIHL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2015 04:07:11 -0400
Received: from mail-la0-f50.google.com ([209.85.215.50]:33453 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752787AbbFSIHH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2015 04:07:07 -0400
Received: by laka10 with SMTP id a10so69379536lak.0
        for <git@vger.kernel.org>; Fri, 19 Jun 2015 01:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=xiWP0lUnEzjAe8aXPCpOZmexkAX57gZHKZccGBCfzp8=;
        b=C8fd1NdoGb2lnNIgMp4EgE1dzvgJjB2mA8Pfs22otzk4nx9gABq52sD+Q2UhVAlW4o
         QpOEg9VSjBx0SpShF/QCdkyr/CWH8NAuXphKf4hR4luHNTxusAsf7Bq6PUfbuxaR8vOB
         zbDcvd6Z5obEImCTfg0u6ot5sjgCUzAksHOsbx4XuA3ElDL/Yek1ET+Z58Ywh+yK63/2
         F6wsIX+tk9YuCtrk0/p0QGQpn1pITv7hhDoWCoi4UXXGRP84LXwt6ZCdk4GuA8CRnqFW
         +xEutZyI9mk5mmPWU9kh3vWCUJLfKoBJATkhFzr9C1UHwTxc4oYy0X0eAFnD1ecGYI5K
         IUGw==
X-Received: by 10.112.199.133 with SMTP id jk5mr17054078lbc.32.1434701225416;
 Fri, 19 Jun 2015 01:07:05 -0700 (PDT)
Received: by 10.112.74.133 with HTTP; Fri, 19 Jun 2015 01:07:05 -0700 (PDT)
In-Reply-To: <xmqqlhfgd7vf.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272107>

On Fri, Jun 19, 2015 at 5:28 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Paul Tan <pyokagan@gmail.com> writes:
>
>> If a file is unchanged but stat-dirty, git-apply may erroneously fail to
>> apply patches, thinking that they conflict with a dirty working tree.
>>
>> As such, since 2a6f08a (am: refresh the index at start and --resolved,
>> 2011-08-15), git-am will refresh the index before applying patches.
>> Re-implement this behavior.
>
> Good.
>
> I would actually have expected to see this as part of 08/31, though.

Ah right, makes sense since this patch is primarily about git-apply.

I've squashed this patch into 08/31.

Regards,
Paul
