From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH] git-clean: fix the description of the default behavior
Date: Thu, 4 Feb 2010 16:16:27 -0500
Message-ID: <76718491002041316x31f02e0bq5c47a2a96aadb6f4@mail.gmail.com>
References: <dafb1423c81bc2207d06cf2a97205bcbd9a4968e.1265299086.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Feb 04 22:16:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nd940-0000XT-74
	for gcvg-git-2@lo.gmane.org; Thu, 04 Feb 2010 22:16:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757838Ab0BDVQa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2010 16:16:30 -0500
Received: from mail-iw0-f189.google.com ([209.85.223.189]:61206 "EHLO
	mail-iw0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757431Ab0BDVQ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2010 16:16:29 -0500
Received: by iwn27 with SMTP id 27so181597iwn.5
        for <git@vger.kernel.org>; Thu, 04 Feb 2010 13:16:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=g8LcvfOBss/kNcUsiKpw/U211ruLrcH5ZgeCfXbN5+A=;
        b=IuUwPLzACmmsYGwoWPlCXRE2FDilT3nxGGRM8Ify1xr/bBFFkZCemNPAx9EnLF3C4Z
         BkhMP+UATXJyf9dmfVjiZ3FZ2Wzef2xMSpSqqtQaai9z8/hnFoQugUA3FN2ASOC8uVIk
         H6buUkhmAYxWXH8HDxJhqV15Iu0T+2D0+2bjQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=vmNRgrUgpVI/QkblcxqBo7+mbS+NwkwB0dZs1hsURHW6nfaQdfC2L6pkvCaV1R79lu
         X87NQwcBG1lDY3M0xBFo0GQ6Pb20zEYswzMx3iAhFKTRSq5FUu/dykd8f/3X5Kd5X3oL
         PqPBGBqOji5kbITrpLZqMqxhbNO5Qho69CDI0=
Received: by 10.231.166.68 with SMTP id l4mr781824iby.40.1265318187899; Thu, 
	04 Feb 2010 13:16:27 -0800 (PST)
In-Reply-To: <dafb1423c81bc2207d06cf2a97205bcbd9a4968e.1265299086.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139006>

On Thu, Feb 4, 2010 at 11:01 AM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> fatal: clean.requireForce defaults to true and -n or -f not given; refusing to clean

Bike shed:

fatal: clean.requireForce defaults to true and neither -n nor -f
given; refusing to clean

j.
