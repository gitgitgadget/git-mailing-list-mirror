From: =?UTF-8?Q?Nikola_Kne=C5=BEevi=C4=87?= <laladelausanne@gmail.com>
Subject: Re: format-patch problem when using relative
Date: Wed, 26 Nov 2008 19:58:34 +0100
Message-ID: <06D676E3-6C24-4ACC-9874-8B19549BC3A1@gmail.com>
References: <17081052-4480-4971-9F38-BD5C48087379@gmail.com> <20081126180154.GA7584@coredump.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 26 19:59:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5PcD-0002b8-3O
	for gcvg-git-2@gmane.org; Wed, 26 Nov 2008 19:59:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752609AbYKZS6k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Nov 2008 13:58:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752595AbYKZS6k
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Nov 2008 13:58:40 -0500
Received: from yw-out-2324.google.com ([74.125.46.28]:5716 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752567AbYKZS6j (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Nov 2008 13:58:39 -0500
Received: by yw-out-2324.google.com with SMTP id 9so307392ywe.1
        for <git@vger.kernel.org>; Wed, 26 Nov 2008 10:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:references:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:mime-version
         :subject:date:cc:x-mailer;
        bh=1bwQyjR9LMlFq/kq6hoxXvMoMD/jQ42ZlkPjcQ2O5NE=;
        b=raiWVGDW/pJm1UnkqzUHs1QJ/JcPvee9I8RyjCFPCccet8R0/svKCQzBEsKs8fRWmw
         U7+sZeOrXpvEMWXRAmiQaJjWt/tDHi5mK7JSnJ5eKBS0COYTxPpmimGkvllPIbqLZ/az
         8FHv/YqQEbl1X275bOSHguV7tEFhiGmocWTKw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=references:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:cc:x-mailer;
        b=wbFZB0+uzwg8viyLuw59XZGey9eMkwCAePRiuVLX/UFfsi2pZK4XnKequ3MsNi0ImA
         HmdPM0poeu7ZSXUYmuL7nNpvN2Ey0os2a5k8TGIoXaVdXcuQ1SI8g7rFWoIV4IkCbjKS
         IoraXmfOQ/bHr5DszczWdwGoe2cA9fZdgMviM=
Received: by 10.103.170.6 with SMTP id x6mr2269486muo.13.1227725917850;
        Wed, 26 Nov 2008 10:58:37 -0800 (PST)
Received: from ?192.168.1.11? (dyn.83-228-192-131.dsl.vtx.ch [83.228.192.131])
        by mx.google.com with ESMTPS id b9sm1005238mug.30.2008.11.26.10.58.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 26 Nov 2008 10:58:37 -0800 (PST)
In-Reply-To: <20081126180154.GA7584@coredump.intra.peff.net>
X-Mailer: Apple Mail (2.929.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101757>

On 26 Nov 2008, at 19:01 , Jeff King wrote:

> So I think what you really want is:
>
>  git format-patch --relative=click click/master myclick -- click
>
> to limit the path pruning to the 'click' directory.

Yes, that did the trick. Also, when I think about it, it makes sense -  
do checks relative to a path, but prune using path.

Thanks,
Nikola
