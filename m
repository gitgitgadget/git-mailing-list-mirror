From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: teach git diff -v/--invert-match?
Date: Mon, 25 Aug 2008 11:41:37 +0200
Message-ID: <48B27E51.2020709@gnu.org>
References: <48AED264.60600@visi.com> <20080822193947.GA31322@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Brian Ericson <bme@visi.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Aug 25 11:43:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXYb7-0001vj-7X
	for gcvg-git-2@gmane.org; Mon, 25 Aug 2008 11:42:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752682AbYHYJlp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2008 05:41:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756162AbYHYJln
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Aug 2008 05:41:43 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:15900 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756015AbYHYJlm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2008 05:41:42 -0400
Received: by fg-out-1718.google.com with SMTP id 19so929346fgg.17
        for <git@vger.kernel.org>; Mon, 25 Aug 2008 02:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding:sender;
        bh=geYgKtDhT2YB8GgnjcaU7i5bO4OaLx4G1xWKQ25GoL8=;
        b=IXZ4JW1C6R39kuS3VomN0+07vYQ4CKZ9iGFtVL/sZjZjRYkhLgIQ/m2sZGG4vKc3ZW
         X/bqY5JJwSlifEhUEtFEpw5Iu0C8WXNPfR8bcbOx40yVTMuF8T8CjhTcqNnM2K3bRLG3
         7qAG9awSOww7BEhTGEHa6agiLoak/NxpOksdw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :sender;
        b=uRP1YhmGcukW86H9UBlbcxjgOMqWXTzIAE1LNlE/YuWNeCttob5DOe46BZRjISQugg
         Bg2DZlqPN3kdpqPuZ/CcxKUtbwgNEcA4pS7CLXxb9xe25x1DamYwoQb+Ps5XN7DdQ4tZ
         JdyfC/0qqnEdQIrB0L8WyQH+pQmw7WSkomSJ8=
Received: by 10.86.71.1 with SMTP id t1mr3187441fga.36.1219657300837;
        Mon, 25 Aug 2008 02:41:40 -0700 (PDT)
Received: from scientist-2.mobile.usilu.net ( [195.176.179.202])
        by mx.google.com with ESMTPS id 12sm4546012fgg.0.2008.08.25.02.41.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 25 Aug 2008 02:41:39 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.16 (Macintosh/20080707)
In-Reply-To: <20080822193947.GA31322@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> I would have thought "-v" meant "match any changes which do not have
> this pattern". But you want "match any changes that have any line which
> does not have this pattern."

Yours could be "-L/--without-match" (in grep, -L/--files-without-match
only prints the names of files containing no match).

Paolo
