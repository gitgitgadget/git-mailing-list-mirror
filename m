From: Michael Witten <mfwitten@gmail.com>
Subject: Re: Lack of detached signatures
Date: Wed, 28 Sep 2011 00:07:58 +0000
Message-ID: <CAMOZ1Bs2HW6e3V6sayVSm0NhC=0e5129ZR8YSGuZPnJw9H9TEA@mail.gmail.com>
References: <alpine.LNX.2.00.1109271742460.24832@bruno> <7vty7xttxh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Joseph Parmelee <jparmele@wildbear.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 28 02:08:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8hhS-00029w-33
	for gcvg-git-2@lo.gmane.org; Wed, 28 Sep 2011 02:08:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752186Ab1I1AI3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Sep 2011 20:08:29 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:52652 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751909Ab1I1AI2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Sep 2011 20:08:28 -0400
Received: by iaqq3 with SMTP id q3so6266801iaq.19
        for <git@vger.kernel.org>; Tue, 27 Sep 2011 17:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=qGK4mAfxOEtsO+rkqIF/tieJZu4TAhB8DCyuAUnvv8E=;
        b=D2IX7Sfahj+e7dWuzI0hP1PE+gOeLFuhAYZWa81aGIKdSUP1sSAF4+KZT65PMrLMCY
         3ub/TIIY8g+x1AunYpAliA8Ph7vAQ/NoFGVupDOkABEVxdoMp/nPSWhzLCBRKhfAj5s5
         VejDrE6QbW+SYxM62pRv34qDWFm2LBLZNH08s=
Received: by 10.42.134.4 with SMTP id j4mr10701840ict.135.1317168508084; Tue,
 27 Sep 2011 17:08:28 -0700 (PDT)
Received: by 10.42.171.194 with HTTP; Tue, 27 Sep 2011 17:07:58 -0700 (PDT)
In-Reply-To: <7vty7xttxh.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182281>

On Wed, Sep 28, 2011 at 00:03, Junio C Hamano <gitster@pobox.com> wrote:
> Joseph Parmelee <jparmele@wildbear.com> writes:
>
>> Under the present circumstances, and particularly considering the
>> sensitivity of the git code itself, I would suggest that you implement
>> signed detached digital signatures on all release tarballs.
>
> Well, signed tags are essentially detached signatures. People can verify
> tarballs against them if they wanted to, although it is a bit cumbersome.

Aren't tarballs used to get git on machines that don't yet have git?
