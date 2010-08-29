From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [RFC PATCH 0/2] Teach fetch and pull to recursively fetch
 submodules too
Date: Sun, 29 Aug 2010 17:29:41 +0000
Message-ID: <AANLkTimyGy5-wmx7NLu53neu5ScqZw291sUP1+WLUHwX@mail.gmail.com>
References: <4C7A819B.3000403@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Sun Aug 29 19:30:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oplhw-0002Rv-JA
	for gcvg-git-2@lo.gmane.org; Sun, 29 Aug 2010 19:30:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753828Ab0H2RaJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Aug 2010 13:30:09 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:45723 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753795Ab0H2RaI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Aug 2010 13:30:08 -0400
Received: by iwn5 with SMTP id 5so4231335iwn.19
        for <git@vger.kernel.org>; Sun, 29 Aug 2010 10:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=2VH7G7QRXA2fCM2m+0BKSDxQ4Da78z6vnrb7WNPnfks=;
        b=QVaC3PuOAkJsKBTcoWvsOv1D93Vru/qEW8R6EWIaUBbOkgYcolYUvq0BN5fpqSfdWn
         HvgaIF8nRjOEgocl4jNU0dGpNyO8tG4n3yXe4T3YX+DzHsEmT/D6GIp0BFVCwmZ4UM3E
         I46/J/BU5TUKWUxRvt7EyIdmQ0v5L9Fhye70A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=IXyUNcckj3zrk2KEqxuFkL14f2QB8kjbaGToM5tvV2NHKgcDQONz7/Jy/dkb84uRPB
         K/kwjuMhAssDeDkeTsQgVl/2bAzAa3E3NmwaLjiV7ZwFOxDTFZmlk/AWeb2ebGaTaLWa
         YuuhGN7Abr3knIZBUjWwf8s8WkBoekneJJPaY=
Received: by 10.231.174.206 with SMTP id u14mr4215416ibz.103.1283102981508;
 Sun, 29 Aug 2010 10:29:41 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Sun, 29 Aug 2010 10:29:41 -0700 (PDT)
In-Reply-To: <4C7A819B.3000403@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154697>

On Sun, Aug 29, 2010 at 15:49, Jens Lehmann <Jens.Lehmann@web.de> wrote:

> Opinions?

I'm not familiar with this area, but I couldn't see anything wrong
with it. However I wonder if we're going to make --recursive the
default for pull/fetch whether it shouldn't be made the default for
clone while we're at it.
