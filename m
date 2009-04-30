From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] git config: error when editing a repo config and not 
	being in one
Date: Thu, 30 Apr 2009 12:11:57 +0300
Message-ID: <94a0d4530904300211j57903a3ei782b4e3e2f967c8a@mail.gmail.com>
References: <alpine.DEB.1.00.0904300043030.10279@pacific.mpi-cbg.de>
	 <1241045387-30181-1-git-send-email-felipe.contreras@gmail.com>
	 <alpine.DEB.1.00.0904301036380.6621@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Teemu Likonen <tlikonen@iki.fi>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Apr 30 11:12:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzSJb-0007M0-Lk
	for gcvg-git-2@gmane.org; Thu, 30 Apr 2009 11:12:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759434AbZD3JMA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Apr 2009 05:12:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754170AbZD3JL7
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Apr 2009 05:11:59 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:48275 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753904AbZD3JL7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Apr 2009 05:11:59 -0400
Received: by fg-out-1718.google.com with SMTP id 16so537585fgg.17
        for <git@vger.kernel.org>; Thu, 30 Apr 2009 02:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ORFrtmV8FSk8r5upB8T3WWNEoztTx0FW3TMSjnc52wE=;
        b=hcQWQuBgjgrTCMDO8rJaIVIGphIv/zxruW3u4r46guXmioSecdhbY53euLIUxJxbXV
         DMwR355ZxRruDd1F+qHSjz0R/ui5ZqtapX5nqPCI/beksfLhRQqFhm/cluwiOGnu7GCK
         gtmilJJwxQG8Qpe6GSfamYEQUv3N5tmdwSjeQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=XwvrztuS0klY96OK7yE4zBPJmgVvlq8KTQ2z558Mvc2xEO4hPWRmJbRWFA+TEhcANT
         OYAFnv7PUfKHikhv+SQfHs9zt31HD0IAgqf9cRmgg3UT1QMeEFD9NlPx4Flep+bWLW+r
         UHkyUwCgjaow3llCJxO3fetL0WOeVK/2RKdYU=
Received: by 10.86.49.13 with SMTP id w13mr1621786fgw.38.1241082718013; Thu, 
	30 Apr 2009 02:11:58 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0904301036380.6621@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118006>

On Thu, Apr 30, 2009 at 11:37 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Thu, 30 Apr 2009, Felipe Contreras wrote:
>
>> Let's throw an error on this specific case. If the user specifies the
>> config file, he must know what he is doing.
>>
>> Teemu Likonen pointed this out.
>>
>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>
> I would have Acked it, but Junio already applied it ;-)

:)

Just for the record, where is people supposed to learn about 'nongit'?
Apparently it's not mentioned in the documentation.

-- 
Felipe Contreras
