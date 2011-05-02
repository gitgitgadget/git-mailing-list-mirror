From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH] grep: add known breakage of coloring when using extended patterns
Date: Mon, 2 May 2011 13:48:45 +0200
Message-ID: <BANLkTik+ARHyjbJLq-nfVh6gOSr1i=ANEw@mail.gmail.com>
References: <328649cbd9fe7f2ee5f43d1e860d712f4204bdc5.1304333975.git.bert.wesarg@googlemail.com>
	<4DBE9859.8030408@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon May 02 13:49:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QGrcg-0005e7-Cr
	for gcvg-git-2@lo.gmane.org; Mon, 02 May 2011 13:49:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753473Ab1EBLss (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2011 07:48:48 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:46802 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751461Ab1EBLsq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2011 07:48:46 -0400
Received: by eyx24 with SMTP id 24so1711706eyx.19
        for <git@vger.kernel.org>; Mon, 02 May 2011 04:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=tfpm+yKs/3gmf/s+jj85LJVtfcakSeIfKmwWCz4Qbko=;
        b=koVrM7LiQguncmvMi4chcuvGTZA928dGr46wvskSrVSjOt6x/JCd5DwLi7jG/wtvnz
         9YalKszgqXaeKOMSUM0qKnnnzdK4668GKPydZcV3+NzbNW+4yNg3P0bEATZBa4V0e56i
         Uy63PGXMvWVW7pam6S/1kNqrUooQN5zALem0w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=sXScix5DnKsOo9ZRCoJvDXabnUdoFUEDpeaTFbtrMwFfYoUBWN9lKByT1j2PfVIeiu
         Lt83faZd9tJoyl35VyMyQ85C2RyN8tUE4joU9fA/PKQvZ8KQC3BjQtZH5JharZlp00xI
         E+q30U61kLSH9oTuuT3yKar3eK40MuHdRN6qg=
Received: by 10.223.55.201 with SMTP id v9mr3418031fag.76.1304336925443; Mon,
 02 May 2011 04:48:45 -0700 (PDT)
Received: by 10.223.71.205 with HTTP; Mon, 2 May 2011 04:48:45 -0700 (PDT)
In-Reply-To: <4DBE9859.8030408@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172576>

On Mon, May 2, 2011 at 13:41, Johannes Sixt <j.sixt@viscovery.net> wrote:
> Am 5/2/2011 13:35, schrieb Bert Wesarg:
>> +test_expect_failure 'grep coloring does not honor boolean algebra' '
>
> I'm sure you meant to say 'grep coloring honors boolean algebra', no?

You're right, I'm not so good in double-negations.

Bert

>
> -- Hannes
>
