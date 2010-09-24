From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [RFC PATCHv2 13/16] t7001 (mv): add missing &&
Date: Fri, 24 Sep 2010 23:00:37 +0000
Message-ID: <AANLkTi=kBx5Ek-KRd8Mtc0GZp6T3YxWzSEC=vZDYK1BT@mail.gmail.com>
References: <1285366976-22216-1-git-send-email-newren@gmail.com>
	<1285366976-22216-14-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 25 01:00:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzHG3-00046n-6Y
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 01:00:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758408Ab0IXXAi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 19:00:38 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:52108 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758375Ab0IXXAi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 19:00:38 -0400
Received: by iwn5 with SMTP id 5so2745749iwn.19
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 16:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=aEoY2OabklE64yw3Ax/yJG34X9fD7qjzjf83LeQ5Y9M=;
        b=uA5e1JbuJM3Yg9ctiJJZW4rEXdZcqgTMyldX2oa0fESnt0WMcihIpm2q/aPIo0H5bO
         T6WgBFOiV3itAFSgQ/nXDPutRPtcTi84prNKjvuS8gsOXfFB1acMUxAfDVFA294Ijq0L
         C7l9fO4CgDtvfPSFwqjm2hg3w+iKmECjKG2eQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=b4adRglsxDNbW+HZHBhvSobEny7v3W/Yv7tYjf13Lv2ndYv75kIIcDf3WxTHzgt45u
         1HFH/ckQwulE11eclrXTQz/Zl8o5i6n0yPgT6YMrSdkZDkZZyrP1QD6Y8OHxMoQEqTyF
         pN8q4W1q6pCVWWKJDwYbJETXZ0+4vmmG7LOAs=
Received: by 10.231.148.85 with SMTP id o21mr4632518ibv.26.1285369237535; Fri,
 24 Sep 2010 16:00:37 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Fri, 24 Sep 2010 16:00:37 -0700 (PDT)
In-Reply-To: <1285366976-22216-14-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157099>

On Fri, Sep 24, 2010 at 22:22, Elijah Newren <newren@gmail.com> wrote:
> FIXME: I believe the mv was meant to fail here so I added a test_must_fail;
> was that the right change?

Yeah, you can't mv an untracked file.
