From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: git bug(?) for commit baf18fc261ca475343fe3cb9cd2c0dded4bc1bb7
Date: Mon, 7 Nov 2011 18:21:14 +0700
Message-ID: <CACsJy8Aw4_O_GMiK_D=HTENfxGUXTTzCHqM7FkriqU+mQtVWtA@mail.gmail.com>
References: <BC404302028E4B6F8F2C27DC8E63545F@gmail.com> <CACsJy8C25qurZwTLuuZ8X4EUzg-NP_qwFjcPTZoEs7QOOS-WBA@mail.gmail.com>
 <841269128C1D4788816CA66A33ED39E5@gmail.com> <20111107104128.GA2964@do> <EF1B195E54C9411A91CCF9A21C5FADC2@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Tony Wang <wwwjfy@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 07 12:21:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNNGy-0008Pz-9u
	for gcvg-git-2@lo.gmane.org; Mon, 07 Nov 2011 12:21:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754201Ab1KGLVr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Nov 2011 06:21:47 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:55929 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753534Ab1KGLVr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Nov 2011 06:21:47 -0500
Received: by bke11 with SMTP id 11so3479103bke.19
        for <git@vger.kernel.org>; Mon, 07 Nov 2011 03:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=bs0uJOS3NvwTIs05e0rLroYa0oeHMQILIAadyIZ/eV0=;
        b=sLEZYKofwe0yESWaLSEk+acHKsDq2RIrPNKRrBS0X2noqar/z87Ma655XurG9D2O9M
         a8betHZ+SG7+s8CqrB/k1RW2lBf4NRxaVFMKPNPLQT1/ATKHdNqFyyyI4S7qrMbs5So2
         +uL63baAjR80d1WsLCiF4Wq/TlzJ5TbfYryhE=
Received: by 10.204.143.74 with SMTP id t10mr8168937bku.45.1320664905131; Mon,
 07 Nov 2011 03:21:45 -0800 (PST)
Received: by 10.205.134.1 with HTTP; Mon, 7 Nov 2011 03:21:14 -0800 (PST)
In-Reply-To: <EF1B195E54C9411A91CCF9A21C5FADC2@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184975>

On Mon, Nov 7, 2011 at 6:02 PM, Tony Wang <wwwjfy@gmail.com> wrote:
> Yes! It works.
> I do learn from it, thanks!
> But seems it's possible the potential problem exists somewhere else.

Sure. There are 58 resolve_ref() call sites. I'll go through and send
proper patches later.
-- 
Duy
