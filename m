From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] rebase -i: fix has_action
Date: Thu, 4 Aug 2011 14:15:35 +0200
Message-ID: <CAGdFq_j2ZuHLHT-M_+-apv5fe8CUh9JLQ9bZvx+v=QTb8+K9Rw@mail.gmail.com>
References: <1312450780-5021-1-git-send-email-nrubinstein@proformatique.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Noe Rubinstein <nrubinstein@proformatique.com>
X-From: git-owner@vger.kernel.org Thu Aug 04 14:16:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qowqb-0002y7-Ov
	for gcvg-git-2@lo.gmane.org; Thu, 04 Aug 2011 14:16:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753439Ab1HDMQR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Aug 2011 08:16:17 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:39510 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752764Ab1HDMQQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2011 08:16:16 -0400
Received: by gxk21 with SMTP id 21so992456gxk.19
        for <git@vger.kernel.org>; Thu, 04 Aug 2011 05:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ttiBAFIIP5HttCWWd7jYmJSwYzgez304C0EJbog07EI=;
        b=beuGwgIiamxCtCmUbgGGEhWqGSK9v/PbIL1lsUxSW7EDI+WLuSwB4UHmFLQXOSuqjE
         wxHC+YmREZ+V+ch2reb4gQ0a8WfxGcjtMA4/vkNMXBsQ+BJGgN3PkscDQ6UFeVK/+789
         VdAcskoAzK6h/J7jMBuLwnqo5nX+2T03comjg=
Received: by 10.142.153.5 with SMTP id a5mr797536wfe.121.1312460175171; Thu,
 04 Aug 2011 05:16:15 -0700 (PDT)
Received: by 10.68.71.162 with HTTP; Thu, 4 Aug 2011 05:15:35 -0700 (PDT)
In-Reply-To: <1312450780-5021-1-git-send-email-nrubinstein@proformatique.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178746>

Heya,

On Thu, Aug 4, 2011 at 11:39, Noe Rubinstein
<nrubinstein@proformatique.com> wrote:
> This patch fixes the bug by changing has_action to grep any line
> containing anything that is not a space nor a #.

Probably maint-worthy? Should this have a test too?

-- 
Cheers,

Sverre Rabbelier
