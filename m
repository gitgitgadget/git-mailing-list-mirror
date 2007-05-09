From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: git rebase chokes on directory -> symlink -> directory
Date: Wed, 9 May 2007 09:50:34 +0200
Message-ID: <81b0412b0705090050i644a18c2g12c74462ab88163a@mail.gmail.com>
References: <463FCD7C.4020009@zytor.com> <20070508215009.GA2670@steel.home>
	 <46413565.3090503@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Wed May 09 09:50:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hlgwb-0002Yu-EY
	for gcvg-git@gmane.org; Wed, 09 May 2007 09:50:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750940AbXEIHug (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 03:50:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752004AbXEIHug
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 03:50:36 -0400
Received: from an-out-0708.google.com ([209.85.132.251]:45633 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750940AbXEIHuf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 03:50:35 -0400
Received: by an-out-0708.google.com with SMTP id d18so24795and
        for <git@vger.kernel.org>; Wed, 09 May 2007 00:50:34 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=trbPnG5fBekU6sJxxLMVvLPYoHJ5AcZYP7RIKIugGikVF1MjGvoFiCeL1E2fRFw3wkFcmzYy582pPqqo98tX/4l9cwlCN1USGUIm+VoK4oe4qWRP8EjIrjs6ugo1hneXtxFfIEneAUDioSb7V7Rkr9jARhr0JIPnYk25BEdG/3I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YvLM6tciiSYfBnp/yQf+3IzPM4alyScQW72y3fAEYVXrFwy8S+cQ307Fb5XhDN7xPb6s3PnEgz0LBBq4FFA/ao5tTWIfvrvaU26fjuYi9qmQQhel2e5Mtc9rz0Hu3fzBJP0Z+r/fppBoE/CS+YHVYv/OvYPHwswTQKU1GXODvgw=
Received: by 10.100.200.12 with SMTP id x12mr149488anf.1178697034685;
        Wed, 09 May 2007 00:50:34 -0700 (PDT)
Received: by 10.100.225.3 with HTTP; Wed, 9 May 2007 00:50:34 -0700 (PDT)
In-Reply-To: <46413565.3090503@zytor.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46677>

On 5/9/07, H. Peter Anvin <hpa@zytor.com> wrote:
>
> Mine stops already at the directory -> symlink checkin (the above is the
> symlink -> directory one), but your trick of using "git checkout" as a
> trick to resolve things helped for both... eventually :-/
>

Hmm. What Git version do you have?

> Either way, it's still a bug that it stops for either checkin, ...

Right. And because it is a bug, I'd like to have it fixed.
So, what did you do in that fixup?
