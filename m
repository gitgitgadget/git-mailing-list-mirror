From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/3] git config: clarify bool types
Date: Mon, 12 Oct 2009 13:03:35 +0300
Message-ID: <94a0d4530910120303y205e6cfeg80ba0dfd6ed5a045@mail.gmail.com>
References: <1255293973-17444-1-git-send-email-felipe.contreras@gmail.com>
	 <1255293973-17444-2-git-send-email-felipe.contreras@gmail.com>
	 <1255293973-17444-3-git-send-email-felipe.contreras@gmail.com>
	 <7v7hv1kxyg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 12 12:05:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxHmj-0006tT-RB
	for gcvg-git-2@lo.gmane.org; Mon, 12 Oct 2009 12:05:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754370AbZJLKFY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 06:05:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751209AbZJLKFX
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 06:05:23 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:5395 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750983AbZJLKFX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 06:05:23 -0400
Received: by fg-out-1718.google.com with SMTP id 16so396269fgg.1
        for <git@vger.kernel.org>; Mon, 12 Oct 2009 03:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=RozouGLIyM1xvus3SfHXSI9fkuFy1H3MtHP01qetE4o=;
        b=OzHkTtzf0ksU2fVxgTxBW+PmngYBC4jFqRJJmXHGSxphjX+UMdX24fmA/XyFHheX1R
         Z8ohHd5ue4K2rjXP9yYd5zUqzqDdyyHxw5RMVQV9dNWdFMXl5Ckaq/+RFodCXUCpOJPq
         swis8rVTRJn2nN2Y6actJrhVO2SACnARkF4XM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=ogFzSXQ3NAjRyVFtQAyDk/QPmiInXMPjwW77af4x27XA4jSKAzeQYeWHAtv/a1jaWh
         9F5RgFI0RMhOvyXLPg7eld8Dys2qN3PNaRmKZBh6/erpcYRZXKYGR3TW/0ln+xpsm55M
         QlXaJops3b2+M1pgiQp0MsIlk09vYzdtRAIyA=
Received: by 10.86.195.26 with SMTP id s26mr5068528fgf.23.1255341815389; Mon, 
	12 Oct 2009 03:03:35 -0700 (PDT)
In-Reply-To: <7v7hv1kxyg.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129998>

On Mon, Oct 12, 2009 at 8:01 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> The value is what it is, the --bool and --bool-or-int options don't
>> specify the value type, just how it is interpreted. For example: a value
>> of '1' can be interpreted as 'true'.
>
> It is not really about "interpreting", but about showing, isn't it?

Unless you are setting it, instead of reading it.

-- 
Felipe Contreras
