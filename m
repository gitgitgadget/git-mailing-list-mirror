From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH] diff: fix coloring of extended diff headers
Date: Sun, 9 May 2010 20:43:07 +0200
Message-ID: <AANLkTilFfkadPZd56OSGr1yDLVeSQ_G2jOxga1dK5NBD@mail.gmail.com>
References: <591c96c90ca049400a8c0df70f8b44061aeacba5.1272926169.git.bert.wesarg@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 09 20:43:17 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBBTA-0004I2-IZ
	for gcvg-git-2@lo.gmane.org; Sun, 09 May 2010 20:43:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751313Ab0EISnJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 May 2010 14:43:09 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:43671 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750967Ab0EISnI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 May 2010 14:43:08 -0400
Received: by gwj19 with SMTP id 19so1550112gwj.19
        for <git@vger.kernel.org>; Sun, 09 May 2010 11:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=M40Lh8zUBa+7GauxYWNQOR1NBhRvsMqoLESriSnYZwU=;
        b=hiN2gHpE/lg5ccMyHXIUpM9/gcfIfm2pl74yk26cZa4ciMFcyRlwh216o3khbLfcNH
         wHdiaSZYMisSfgNm7nd+nIC/8DwZJRSfpjT4IBLSiPW+uQtqOrQrQyK5+zLa7B33CqgX
         RGzGzPE4i1Zosp8B7JnSg1BHPnbqy+OUGaa6s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=h27grXVxo5GSdh03gzpwncXISeZ0xQWm4NZeicBPDW1FaNJHmqy+E6HITVwO4muEmz
         04madxYe9hYXTBFfTgrALkXgeuFQ7gmHR0UcJ+WGtHUCPkqBxqv5/PjEQZUvfSt7MMxs
         pGanXwHcKeMderE0f1Zduq6wwLe64lUiGL+rI=
Received: by 10.231.146.2 with SMTP id f2mr1416850ibv.23.1273430587084; Sun, 
	09 May 2010 11:43:07 -0700 (PDT)
Received: by 10.231.39.205 with HTTP; Sun, 9 May 2010 11:43:07 -0700 (PDT)
In-Reply-To: <591c96c90ca049400a8c0df70f8b44061aeacba5.1272926169.git.bert.wesarg@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146737>

On Tue, May 4, 2010 at 00:38, Bert Wesarg <bert.wesarg@googlemail.com> wrote:
> Coloring the extended headers where done as a whole not per line. less with
> option -R (which is the default from git) does not support this coloring
> mode because of performance reasons. The -r option would be an alternative
> but has problems with lines that are longer than the screen. Therefore
> stick to the idiom to color each line separately. The problem is, that the
> result of ill_metainfo() will also be used as an parameter to an external
> diff driver, so we need to disable coloring in this case.
>
> Because coloring is now done inside fill_metainfo() we can simply add this
> string to the diff header and therefore keep the last newline in the
> extended header. This results also into the fact that the external diff
> driver now gets this last newline too. Which is a change in behavior
> but a good one.

Ping.

Regards,
Bert
