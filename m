From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH 0/2] Teach 'git grep' about --open-files-in-pager=[<pager>]
Date: Fri, 26 Mar 2010 21:07:28 +0100
Message-ID: <36ca99e91003261307m68cb7238u8a5cbbb350c71c97@mail.gmail.com>
References: <alpine.DEB.1.00.1003261145500.7596@pacific.mpi-cbg.de>
	 <36ca99e91003260439x3d60b851g15b8652d50f61c06@mail.gmail.com>
	 <alpine.DEB.1.00.1003261714550.7596@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Mar 26 21:07:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvFoe-00056Z-Nf
	for gcvg-git-2@lo.gmane.org; Fri, 26 Mar 2010 21:07:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752990Ab0CZUHb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Mar 2010 16:07:31 -0400
Received: from mail-fx0-f223.google.com ([209.85.220.223]:49077 "EHLO
	mail-fx0-f223.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752385Ab0CZUHa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Mar 2010 16:07:30 -0400
Received: by fxm23 with SMTP id 23so2448883fxm.21
        for <git@vger.kernel.org>; Fri, 26 Mar 2010 13:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type;
        bh=7r284kLMutNhM2dsv+z2iZa7XMzv7HudFTq8iWGtlX0=;
        b=Gvo7v44eLczi4Sl72cflTCpgD5j2b5I8d415QsvBCCgYwFTR2fjT5a+yJdEMnhDEjk
         hvTy4/lwvTcgbQqyd4801bEGk/114TQKR+cAvo2vJTPl/6Quass/67Sx3p2Vq7FfXnSX
         WYN4VP6RLe6JjsCFxXwCTm81ZUL67Lblo90kc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=f0oOjLPGk790WgnMTNKMRk3vxDTFh2UjVKDWU42ccAbAFNmWkH8FA4g4krI3o4p+XN
         F2gNKTvijnRvM2D3QfH6LZRXVjs+6K2UpKuk4G0gUhCLQDxPU0E53Jg400kYmWVjQaRW
         JzTvF+BsEwxk2FsBpyHQqXE0t5GEWDwm6zsw0=
Received: by 10.223.105.137 with HTTP; Fri, 26 Mar 2010 13:07:28 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.1003261714550.7596@pacific.mpi-cbg.de>
Received: by 10.223.29.199 with SMTP id r7mr1394360fac.73.1269634048986; Fri, 
	26 Mar 2010 13:07:28 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143276>

Hi,

On Fri, Mar 26, 2010 at 17:18, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>> I have also the feeling that -O potion does not like pager with
>> arguments, be it from GIT_PAGER, PAGER, or from the command line.
>
> You are correct. That's why I said "-O[<pager>]" and not
> "-O[<pager-with-arguments-that-cause-whitespace-problems-especially-with-spaces-in-directory-names-so-you-need-to-make-a-script-wrapper-anyway>]"

I don't know how common it is to have arguments for the pager in
GIT_PAGER or PAGER or whether git actually support this, but your
first patch definitely does not work with this, regardless of your
-O[<pager>] addition of the second patch.

Bert
