From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [OT?] Executing Git from bash script invoked by cron
Date: Mon, 28 Jun 2010 23:22:09 +0200
Message-ID: <AANLkTim0fmxUJERuGP0hBhfD5ZtyKvo34PGQKJg0pCrT@mail.gmail.com>
References: <4C290D88.80306@cedarsoft.com> <1277759597-sup-9397@nixos>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>,
	Johannes Schneider <mailings@cedarsoft.com>
To: Marc Weber <marco-oweber@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jun 28 23:22:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTLml-0004hI-QC
	for gcvg-git-2@lo.gmane.org; Mon, 28 Jun 2010 23:22:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754168Ab0F1VWa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jun 2010 17:22:30 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:37116 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753380Ab0F1VWa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jun 2010 17:22:30 -0400
Received: by iwn7 with SMTP id 7so406712iwn.19
        for <git@vger.kernel.org>; Mon, 28 Jun 2010 14:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=RqNOkPtlPVREnQih6gRSmDxk2edUA9LiXdQe+qNv944=;
        b=FsUhMCeOMZovwBf05K1CRJg9+L2sA3FIqKWzwwwi+XmXu4xPtYfK6MRP6aKmFwmIbc
         aknlsXOa6ayl4d3xHCITTx6AoYG0lHyzYlfSW0K5H8V801Aada3YN1qGziqiAjwJWaC7
         h5vdg8hi2u1ClTPO3nrqk4ecIRnrlqxxiIlAE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=iZq4otMrnle+GxeVEW3bqeYcWV72jm+k+N2OFdEMkVeNol5GOgYq6HJrwgcOGmtwdH
         BG80cmzRSlfyniZOwgXr4reGjFMbfWNO6YH9Y1tFRrfuGVTZ2VUBKg/byYOS5l44UFQX
         SVcOKr1hXuBGVFgZnL+wnBQ+Uz06vwRLxQQJk=
Received: by 10.231.119.71 with SMTP id y7mr5337069ibq.158.1277760149320; Mon, 
	28 Jun 2010 14:22:29 -0700 (PDT)
Received: by 10.231.50.129 with HTTP; Mon, 28 Jun 2010 14:22:09 -0700 (PDT)
In-Reply-To: <1277759597-sup-9397@nixos>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149863>

Heya,

[Mark, please don't cull the cc list]

On Mon, Jun 28, 2010 at 23:17, Marc Weber <marco-oweber@gmx.de> wrote:
> b) if this still does not work use strace:
>
> sh -c 'strace -f-o /tmp/strace.log your quoted command &> /tmp/logfile'

If you have to result to strace with git, it will probably then be
helpful to use GIT_TRACE=1, it will at least tell you what commands
are being invoked by git in a semi-human-readable format.

-- 
Cheers,

Sverre Rabbelier
