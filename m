From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] Makefile: don't include git version file on 'make clean'
Date: Sun, 25 Jul 2010 12:34:29 +0000
Message-ID: <AANLkTinjmUEHxnGI2kRBwN17689MEwRRX_1uOQx-ZaHY@mail.gmail.com>
References: <1279943627-11053-1-git-send-email-Lynn.Lin@emc.com>
	<AANLkTilYXdVI_fqG5ZvPEABTXt7fTps3ZbPiiWgVnDxS@mail.gmail.com>
	<4C4BFAA3.3050700@digium.com>
	<7F48A44C0E1FBF48B00D4DA49C85432E54F998@CORPUSMX100A.corp.emc.com>
	<AANLkTilHrEImfhl0YTqj0MgXFTzYmJMJrUTKkflGFwpp@mail.gmail.com>
	<7F48A44C0E1FBF48B00D4DA49C85432E54F99A@CORPUSMX100A.corp.emc.com>
	<AANLkTilhoF670uZ1WbosZP9TNbXect2A3gELRJL0ZZIn@mail.gmail.com>
	<m2d3ubojfr.fsf@igel.home>
	<AANLkTilK_8wVQG6s8pUrscwd7ZnvgGyjOjJP41uXYfEl@mail.gmail.com>
	<7F48A44C0E1FBF48B00D4DA49C85432E54F99D@CORPUSMX100A.corp.emc.com>
	<7F48A44C0E1FBF48B00D4DA49C85432E54F99F@CORPUSMX100A.corp.emc.com>
	<7F48A44C0E1FBF48B00D4DA49C85432E54F9A0@CORPUSMX100A.corp.emc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: schwab@linux-m68k.org, kpfleming@digium.com, git@vger.kernel.org
To: lynn.lin@emc.com
X-From: git-owner@vger.kernel.org Sun Jul 25 14:34:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Od0Pd-000173-8X
	for gcvg-git-2@lo.gmane.org; Sun, 25 Jul 2010 14:34:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752730Ab0GYMec (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jul 2010 08:34:32 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:43178 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751881Ab0GYMeb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jul 2010 08:34:31 -0400
Received: by iwn7 with SMTP id 7so1875230iwn.19
        for <git@vger.kernel.org>; Sun, 25 Jul 2010 05:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=QCEjFNAQHrRr5FN3FV6fa9pfdF0jnkh96xB0AAK/TBE=;
        b=AXBrXJShlJzKhQiJ3jv6iN5oXfuRsUd0bIkZjv38MaXOT+zzWW2AWcr5de7b2Xr002
         FUSycwvSQECx4b3iLuoYxDJvHUarq5Kb1FxX/7DS/qcFCVG4ZyckyEnDF8idJ7+PpYoG
         gI+l9ro/90/EO+huVMKuxoJ+evnlXB0EG+YL8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=hApxQNBA51+W6VOJrBk8iIOH6tNUWmjakb40QlFDSzjmbzQ3zsynSYC+wKGbwsg9Dh
         poTtJhOLVJ5Ar97TpGjbCG4sxKu7WU9fEX9tYKDqacKtx64j4+KRxfhKDy9115PeDGRL
         TGgZRq5hJQe21LSWMxAT0ZvUxP2CnXjFUQvJU=
Received: by 10.231.170.79 with SMTP id c15mr7033704ibz.82.1280061269201; Sun, 
	25 Jul 2010 05:34:29 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Sun, 25 Jul 2010 05:34:29 -0700 (PDT)
In-Reply-To: <7F48A44C0E1FBF48B00D4DA49C85432E54F9A0@CORPUSMX100A.corp.emc.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151737>

On Sun, Jul 25, 2010 at 12:29,  <lynn.lin@emc.com> wrote:

> My patch is to don't call GIT-VERSION-FILE target when you run 'make clean'

Yes, but as I demonstrated it gets called anyway. Presumably because
of the $(MAKE) -C ... clean rules. But I haven't looked into it.
