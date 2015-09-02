From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/6] Make "local" orthogonal to date format
Date: Wed, 02 Sep 2015 13:29:08 -0700
Message-ID: <xmqqfv2wmup7.fsf@gitster.mtv.corp.google.com>
References: <20150901083731.GE30659@serenity.lan>
	<cover.1441144343.git.john@keeping.me.uk>
	<20150901224431.GA9353@sigill.intra.peff.net>
	<20150902074826.GK30659@serenity.lan>
	<20150902080529.GA19248@sigill.intra.peff.net>
	<xmqq4mjcq2ac.fsf@gitster.mtv.corp.google.com>
	<20150902194946.GL30659@serenity.lan>
	<xmqqk2s8mvig.fsf@gitster.mtv.corp.google.com>
	<20150902202148.GM30659@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Wed Sep 02 22:29:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXEeh-00078v-9b
	for gcvg-git-2@plane.gmane.org; Wed, 02 Sep 2015 22:29:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756032AbbIBU3L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2015 16:29:11 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:33858 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756025AbbIBU3K (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2015 16:29:10 -0400
Received: by padhy1 with SMTP id hy1so22145090pad.1
        for <git@vger.kernel.org>; Wed, 02 Sep 2015 13:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=RjchOWnyM1Q7Dq48mJ6HgUbyZQKwqOQzhZF76DvycGE=;
        b=YHC10DFvI1dO9qFhPTomLWKJSL2uRh/vHhxT24mAyrRmqLPEdES8UJ3jhytado49CV
         6toyVmFHUHDcHlZ7Kb710hGmvZi+tl2vkWRo+LCSwWC28nZQ0BjGw7zY/HTxPIlDZKIY
         1lSOFdOwIluS+yHeYbOHc6oCD9nRJgtKjQeBrdNU4Db3U0ZSdo8JT1yrECJU8V/oCMRL
         a+Lm6TSf1IafhVSZrvU1NLxsvVLcoMIwucK1FgCvHVePMrXRafozNPtyXXbAQRKOFhrK
         VBaUTLAB7Q4VotiISqfuKp8qbvziNwCmKPPwt7MtMHLHoUAX9eGtzCRixljQIwDFfJ80
         3TnQ==
X-Received: by 10.68.249.36 with SMTP id yr4mr59176510pbc.18.1441225749620;
        Wed, 02 Sep 2015 13:29:09 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:2414:9e5f:bc96:1638])
        by smtp.gmail.com with ESMTPSA id am4sm22610064pbd.58.2015.09.02.13.29.08
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 02 Sep 2015 13:29:09 -0700 (PDT)
In-Reply-To: <20150902202148.GM30659@serenity.lan> (John Keeping's message of
	"Wed, 2 Sep 2015 21:21:48 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277121>

John Keeping <john@keeping.me.uk> writes:

> In which case, should we just support it now?
>
> Normally I'd suggest banning controversial options on the basis that
> it's easier in the future to allow something that was previously banned
> than change the meaning of an options, but in this case I can't see any
> other meaning for these options than that described above.

My usual stance is the same as yours, and I agree that there is no
other sane and useful behaviour for "relative-local" to do the same
as "relative".

As we'll go into pre-release feature freeze soonish, we have enough
time to add missing support to the code (the new feature won't have
to make the upcoming 2.6 wait).

Thanks.
