From: Robin Rosenberg <robin.rosenberg@gmail.com>
Subject: Re: [PATCH 00/22] Refactor to accept NUL in commit messages
Date: Sun, 23 Oct 2011 12:44:30 +0200
Message-ID: <4EA3F00E.9040006@gmail.com>
References: <1319277881-4128-1-git-send-email-pclouds@gmail.com> <20111022190914.GA1785@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?w4Z2YQ==?= =?UTF-8?B?ciBBcm5masO2csOw?= 
	<avarab@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Oct 23 12:44:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RHvXk-0007Pu-Hi
	for gcvg-git-2@lo.gmane.org; Sun, 23 Oct 2011 12:44:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753417Ab1JWKog (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Oct 2011 06:44:36 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:63317 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753024Ab1JWKof (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Oct 2011 06:44:35 -0400
Received: by bkbzt19 with SMTP id zt19so6864474bkb.19
        for <git@vger.kernel.org>; Sun, 23 Oct 2011 03:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=XSIcmDCxCLTJDGUjaZ9a7wbVpLLLN90EWE02+8QPL3s=;
        b=PO4KnawOspJZUJVrqHmxPLVzR1/VCDKl/xUBKVz6Yv2mbsW31jyfJ5qHov6o9RYgtj
         rkGWkr8/AeU0YQ9mzy8M4jWc13zfrxPQ2+eGQ1h/LjF43YPax4js2ZbHMrl5Nrpv/EjK
         dztg7qscCisNqgvgjfQ/kHFeK6AxI6lYT6r/c=
Received: by 10.204.152.195 with SMTP id h3mr14446336bkw.1.1319366673593;
        Sun, 23 Oct 2011 03:44:33 -0700 (PDT)
Received: from Robin-Rosenbergs-MacBook-Pro.local (h212n2fls34o828.telia.com. [213.67.13.212])
        by mx.google.com with ESMTPS id a27sm19592675bku.9.2011.10.23.03.44.31
        (version=SSLv3 cipher=OTHER);
        Sun, 23 Oct 2011 03:44:32 -0700 (PDT)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:8.0) Gecko/20111019 Thunderbird/8.0
In-Reply-To: <20111022190914.GA1785@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184135>

Jeff King skrev 2011-10-22 21.09:
> On Sat, Oct 22, 2011 at 09:04:19PM +1100, Nguyen Thai Ngoc Duy wrote:
>
>> This series helps pass commit message size up to output functions,
>> though it does not change any output functions to print ^@.
> Can we take a step back for a second and discuss what git _should_ do
> with commits that contain NUL?
Yes please. I don't think allowing NUL makes sense, but it makes sense
to state how NUL should be handled when anyone attempt it, so there
might be things to fix even if NUL is banned.

Are there any such commits in the wild?

-- robin
