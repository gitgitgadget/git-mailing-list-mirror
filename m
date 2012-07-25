From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: Re: [PATCH v4 5/7] i18n: am: mark more strings for translation
Date: Wed, 25 Jul 2012 11:59:20 +0200
Message-ID: <500FC378.5090706@gmail.com>
References: <cover.1343188013.git.worldhello.net@gmail.com> <b4afad7f9c0b8ae32c04f8aa55a21c72b4ae5013.1343188013.git.worldhello.net@gmail.com> <915b2821410c2348817a469e7be05be497cf1d06.1343188013.git.worldhello.net@gmail.com> <79fe36e1c66cec02eb54c48390d59bb1714c4736.1343188013.git.worldhello.net@gmail.com> <aea1284d5d0d441c8c85af3961d8c9062c2412e0.1343188013.git.worldhello.net@gmail.com> <1493bd09efd0ba6e1d56500305d989047da245ec.1343188013.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 25 11:59:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StyNU-0003ex-HQ
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jul 2012 11:59:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754273Ab2GYJ7c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jul 2012 05:59:32 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:35207 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753622Ab2GYJ7b (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2012 05:59:31 -0400
Received: by bkwj10 with SMTP id j10so368693bkw.19
        for <git@vger.kernel.org>; Wed, 25 Jul 2012 02:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=qnAm+exrU146R3k+QbKz5fRxhWrgiCQi694mdmRMkuE=;
        b=QJUdLnyeaPC0odxM/TnCic/9S3Xohj/AcVH4R6hbFulrBIaeHOe9CNZgxFTxBiGNod
         FN1Fx8QAKDHwT7KLgwLE3IUmSJ5Jr1Dpa3aJB/XbsjZ1j6SAyd0Cu8wS0Iqc4F3mtkXF
         +51RC7hfn6qx5kBRKrZ43P6pA2sg2aSzTdK+iZAjqtc2YKqWych9ZzdppbeOtsBZxvVj
         szmdbVJF0NX/NUcJxqe6jetQZoyIoP4zhR/vUgUeiCPx5EBDcx3zpeiUMseTKXPlIqZ/
         0IboTMZFF3xokXuV0Y8hgcthcN/K8WwLwsYvTlln2+7Qc4mktfRYIetxEOWHOdIUEj6W
         zv9w==
Received: by 10.204.154.73 with SMTP id n9mr11638099bkw.113.1343210370007;
        Wed, 25 Jul 2012 02:59:30 -0700 (PDT)
Received: from [192.168.178.21] (host105-96-dynamic.4-87-r.retail.telecomitalia.it. [87.4.96.105])
        by mx.google.com with ESMTPS id t23sm12355939bks.4.2012.07.25.02.59.27
        (version=SSLv3 cipher=OTHER);
        Wed, 25 Jul 2012 02:59:28 -0700 (PDT)
In-Reply-To: <1493bd09efd0ba6e1d56500305d989047da245ec.1343188013.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202145>

Sorry to be so nit-picky, but ...

On 07/25/2012 05:53 AM, Jiang Xin wrote:
> Mark strings in 'git-am.sh' for translation. In the last chunk, I
> changed '$1' to '-b/--binary' for this reason:
> 
>  * First, if there is a variable in the l10n message, we could not use
>    gettext. Because the variable will be expanded (evaluated) and will
>    never match the entry in the po file.
> 
>  * Second, if there is a positional parameter ($1, $2,...) in the
>    message, we could not use eval_gettext either. Because
>    eval_gettext may be a wapper for gettext, and the positional
>    parameter would loose it's original context.
>
... here you should s/it's/its/.

Regards,
  Stefano
