From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [OT?] Executing Git from bash script invoked by cron
Date: Mon, 28 Jun 2010 23:05:20 +0200
Message-ID: <AANLkTimHw_UcpiJdiVaz8pyYH6jhHa_x2DS1vTNlreau@mail.gmail.com>
References: <4C290D88.80306@cedarsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Johannes Schneider <mailings@cedarsoft.com>
X-From: git-owner@vger.kernel.org Mon Jun 28 23:05:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTLWZ-0003HP-9i
	for gcvg-git-2@lo.gmane.org; Mon, 28 Jun 2010 23:05:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752863Ab0F1VFq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jun 2010 17:05:46 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:59432 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751478Ab0F1VFp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jun 2010 17:05:45 -0400
Received: by iwn7 with SMTP id 7so391679iwn.19
        for <git@vger.kernel.org>; Mon, 28 Jun 2010 14:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=QKbRV/mwE4ou5ogQMvhOwFT8t7P9oU7rT59EQL5rf7w=;
        b=rpML+zRHPurRkJ0+Fu1TZ3VUMuCCGSARARZT3Xto313ulq/QE8wOQdR7cwOiXZYYz1
         Qg/DRpg3RG9YY7YIZbng0YeI1AOJ8cgnO81r4G4T9LBTWlJFUneS2yvxYMF9VHysNNEX
         Bv+KW5dw/yQXlc1TgqrETmGBXoUVMDvBywMRU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=xTPetM2LAw/W0tPZ9O/OFN9kEDcZHf/1tL2auD6jG63Iqpc1pXTOODZ96KVsYpEGyT
         k0HC/Wc8YpZwHSl86dPpAU4dH9D/qyejVm+Kh1KtiKjNpxCRkBYSGM2Zg7Kw2ROmXfQz
         qJE9cUbjpjmKluvmTY2s0S1ZExIyWWdRnetCs=
Received: by 10.231.168.200 with SMTP id v8mr5006485iby.33.1277759140437; Mon, 
	28 Jun 2010 14:05:40 -0700 (PDT)
Received: by 10.231.50.129 with HTTP; Mon, 28 Jun 2010 14:05:20 -0700 (PDT)
In-Reply-To: <4C290D88.80306@cedarsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149861>

Heya,

On Mon, Jun 28, 2010 at 23:00, Johannes Schneider
<mailings@cedarsoft.com> wrote:
> But the same script executed by cron, does not work. Git push does
> simply nothing. No output, no push, nothing.

Very silly question, does the cron version have anything to push? IIRC
'git push' doesn't output anything if there's nothing to push? Try
running 'git push --verbose' instead.

-- 
Cheers,

Sverre Rabbelier
