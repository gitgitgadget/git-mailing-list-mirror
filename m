From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] git-verify-pack.txt: fix inconsistent spelling of "packfile"
Date: Wed, 20 May 2015 21:54:24 -0700
Message-ID: <xmqqr3qaledb.fsf@gitster.dls.corp.google.com>
References: <1431845814-2541-1-git-send-email-ps@pks.im>
	<xmqqwq04745w.fsf@gitster.dls.corp.google.com>
	<20150519222427.GA994@peff.net>
	<xmqqmw0znjfc.fsf@gitster.dls.corp.google.com>
	<xmqqd21vnid6.fsf@gitster.dls.corp.google.com>
	<20150520194906.GA8421@peff.net>
	<xmqqzj4ylvto.fsf@gitster.dls.corp.google.com>
	<20150521020402.GA11619@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 21 06:54:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvIV5-0004va-RP
	for gcvg-git-2@plane.gmane.org; Thu, 21 May 2015 06:54:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751331AbbEUEy1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2015 00:54:27 -0400
Received: from mail-ig0-f182.google.com ([209.85.213.182]:35948 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750870AbbEUEy0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 00:54:26 -0400
Received: by igbpi8 with SMTP id pi8so930060igb.1
        for <git@vger.kernel.org>; Wed, 20 May 2015 21:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=nozGElWeI0gdBt/XsSTY+tjdm9WuZxQTfbrUXfJb5K0=;
        b=K0LhLSbE0ijIUbu9lhaBqWipVdQ5b5k4GGSP3Ki3e7G3snSfw+YXL5/wUIPdCYnHjj
         r9Xknur9uLfs0ZLKq1vh7kdkaVUVAHW42BGRxPR1Qlu5am79VhEzsKJ3yu5xvTHkyyLQ
         ifI52+ONowgVEECdUp8FSPKEwcJdYs7O8ScIvN1hA4x6+ebH6+IuM7K1/xUlFU4udvyn
         WBzzztRa8mpntUIw4oQfdnYvi5LWbS8OxToYRh8vo5QrmNyEC30CogeVSKdrq1walkC7
         WBq4FXglXbk8ZNhX8z0+FdCnoGXgZPvo7swQoiyLUirj2JBM3J2Gweqz9BsznTenKGva
         1Img==
X-Received: by 10.107.14.78 with SMTP id 75mr1015061ioo.15.1432184066000;
        Wed, 20 May 2015 21:54:26 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:c1e1:e830:c078:d79d])
        by mx.google.com with ESMTPSA id k74sm14057757iok.30.2015.05.20.21.54.24
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 20 May 2015 21:54:25 -0700 (PDT)
In-Reply-To: <20150521020402.GA11619@peff.net> (Jeff King's message of "Wed,
	20 May 2015 22:04:03 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269557>

Jeff King <peff@peff.net> writes:

> Yeah, I agree they should agree with the EBNF. And my inclination is for
> "packfile", as it is refering to the concept of the on-the-wire packfile
> data (there is no "file ending in .pack" in this context).
>
> Which I guess argues for a further patch.

I'm fine with that, then.

If I had a time machine, I would have used "pack data" (or "pack
stream") vs "pack file" (or ".pack file") to differentiatee (as the
pack-protocol is not about transferring any "file", but just carries
"pack data"), but that is a rename with more cost than warranted for
a minuscule gain at this point.
