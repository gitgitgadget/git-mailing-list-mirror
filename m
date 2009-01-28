From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] Add --ff-only flag to git-merge
Date: Wed, 28 Jan 2009 15:35:48 +0100
Message-ID: <bd6139dc0901280635q6b6d538axede045de121f72b6@mail.gmail.com>
References: <1233147238-30082-1-git-send-email-nothingmuch@woobling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Yuval Kogman <nothingmuch@woobling.org>
X-From: git-owner@vger.kernel.org Wed Jan 28 15:37:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSBXX-0002br-9V
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 15:37:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751241AbZA1Ofu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 09:35:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751172AbZA1Ofu
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 09:35:50 -0500
Received: from yw-out-2324.google.com ([74.125.46.28]:41040 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750951AbZA1Oft (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 09:35:49 -0500
Received: by yw-out-2324.google.com with SMTP id 9so2994470ywe.1
        for <git@vger.kernel.org>; Wed, 28 Jan 2009 06:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=r3x12mD6PygNbwbQlrMvAkz1qfgDMLD6pXxB5JK2wm8=;
        b=a+/029srJnqwFMKgTD8xDcVxqrDSTpNRDRidh9wMJa43MfFgsz4FhnGXm+YnEMox00
         LqQ6BIW2ktsf6CNw1JZa9diix7IpnHrxp2YKndMauAyKdkuGjgLZw0NSd+4hpzA73jN9
         RStDs4ncpiy4Qx0KKI98dq1lkBbO+Gqi9fmJ8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=Pz2AN0q/DJEEpxgNFm8JFC177AwmYY3TRSKlft5r8+G9S4hC1kYz9STFa0qmAT7d9L
         QW58ciDYFNb1PMiNDyYhcOGnIweox7qiChgJN0q5GEgSaEmhDGrvoDTBCZWXSo5lxrfL
         B8NHBgAVRGSY/TytxrVwYzARfSzFJlzZ3oyIk=
Received: by 10.150.152.17 with SMTP id z17mr1544959ybd.54.1233153348185; Wed, 
	28 Jan 2009 06:35:48 -0800 (PST)
In-Reply-To: <1233147238-30082-1-git-send-email-nothingmuch@woobling.org>
X-Google-Sender-Auth: 9089549497a47c40
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107538>

On Wed, Jan 28, 2009 at 13:53, Yuval Kogman <nothingmuch@woobling.org> wrote:
> This patch adds an --ff-only flag to git-merge. When specified git-merge
> will exit with an error whenver a merge will not be a simple fast
> forward, similar to the default behavior of git push.

I like! This calls for a new alias 'git config alias.integrate "merge
--no-ff"', thanks!
*hopes this hits next soon*

-- 
Cheers,

Sverre Rabbelier
