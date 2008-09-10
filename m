From: "Dotan Barak" <dotanba@gmail.com>
Subject: Re: [PATCH] Rename dynamic memory allocation functions to their "x" version
Date: Wed, 10 Sep 2008 09:02:04 +0300
Message-ID: <2f3bf9a60809092302u1b8616e6pee3c54003896671c@mail.gmail.com>
References: <200809092157.10185.dotanba@gmail.com>
	 <7vprnczlkx.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 10 08:03:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdInL-00025V-Ut
	for gcvg-git-2@gmane.org; Wed, 10 Sep 2008 08:03:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751542AbYIJGCI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2008 02:02:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751581AbYIJGCH
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Sep 2008 02:02:07 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:9357 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750859AbYIJGCG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2008 02:02:06 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2042974fgg.17
        for <git@vger.kernel.org>; Tue, 09 Sep 2008 23:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=4YuZ3CRTXVdCyI8YzVMFsN5n2aQKbKWJoM05yTLEp3w=;
        b=Ovoc3NQKWt4nMQ5oCMlsXsVGef98O/0ls57QaoiB7D3nAOvESRcLoxJyXFz6H73qFk
         osXTbRyp6wUC1zMBb6x99+gyjeq6ubyWHE/MmIeZgGi271zEin068aP4IYDNfFaLYgFm
         Jc+YbHoX7AkHr3Tf2H2G5PkJR64tHle5beug8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=H2MDYlRLWbuS32FneBaANxsXu1qx4CGm9/iFZc6t8TcfIvGGkJxzfjYflP0zt2pECM
         5VCwG08QFActbWGZd9URskLurdJgxAwUeKO/oGRy1+HRCLXJh7+vLJfxE0UKoF7W5Q1T
         SaLvABEneTm5B0zpj6SD8AzPmYKOP10R3mtGA=
Received: by 10.181.33.8 with SMTP id l8mr422745bkj.28.1221026524582;
        Tue, 09 Sep 2008 23:02:04 -0700 (PDT)
Received: by 10.181.9.17 with HTTP; Tue, 9 Sep 2008 23:02:04 -0700 (PDT)
In-Reply-To: <7vprnczlkx.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95485>

On Wed, Sep 10, 2008 at 7:11 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Dotan Barak <dotanba@gmail.com> writes:
>
>> In places that the standard malloc/strdup is used without checking
>> if the allocation was successful, I replaced it to xmalloc/xstrdup
>> which check the memory allocation result.
>>
>> Signed-off-by: Dotan Barak <dotanba@gmail.com>
>
> Looks good.  Will apply, but I'd retitle it (it is not "rename").
>
Yes, you are right, i guess "replace" is better ...

Next time..
;)

Dotan

> Thanks.
>
>
