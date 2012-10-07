From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: "git am" crash (builtin/apply.c:2108) + small repro
Date: Sun, 7 Oct 2012 10:33:22 +0700
Message-ID: <CACsJy8B4xeLSDPC42JifZwC7VWTPRd2iZfnxtPhf7u3OzOm_6Q@mail.gmail.com>
References: <CAOKKMFG4JsNyMY7=SB6EuR8_GnpAu-ysH02J5pwD1cNzUgaieQ@mail.gmail.com>
 <CACsJy8B9NDmGnopoFEAA0T4mgG+54npYnbb_d4tihRNB=xrGnw@mail.gmail.com> <CAOKKMFFGz5Waz3OV4_uTgwDaL=S9NWAnLnACPzSkGpu_rrChvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Alexey Spiridonov <snarkmaster@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 07 05:34:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TKhd4-0006ng-Vj
	for gcvg-git-2@plane.gmane.org; Sun, 07 Oct 2012 05:34:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750845Ab2JGDdy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Oct 2012 23:33:54 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:56906 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750729Ab2JGDdx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Oct 2012 23:33:53 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so6891521iea.19
        for <git@vger.kernel.org>; Sat, 06 Oct 2012 20:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ybGgsieimLN50iTdP4ad0kmxPNwyVUBZArlY9GOFe5Q=;
        b=ZRTmGjA+8tQsbKj/h5s+lNlKkn7MvQRPFmKFm4yJ4TrI/lu6lq+tYMbJxF2KKEoSpP
         t26eWF4R/XFu5mMGlsddKWLoK4Y+8Pheto44aHbA4+0GLMfWWK4EDNE3JwORMF59QiQp
         cNbO6gTXqG1DrtQgyLYI0+icNHycCtOHG2zOwwV62XOX+ax1TK0fbByyuHh4GbmKGrbN
         oNSmiC6nIcEBHqizZ3vVMWlmf+LgMtGgU7Ry9NDsQrNCxaaPCW/LfsO4cCb+cjR9lObx
         DGJmgiq0Cb3ob/+U3rjrHdf9WAIWYVLd8BXszyQzIL2CYiBYIzOHnksCsoqtK9/S9GU8
         zb+g==
Received: by 10.50.220.129 with SMTP id pw1mr2695135igc.47.1349580832639; Sat,
 06 Oct 2012 20:33:52 -0700 (PDT)
Received: by 10.64.143.168 with HTTP; Sat, 6 Oct 2012 20:33:22 -0700 (PDT)
In-Reply-To: <CAOKKMFFGz5Waz3OV4_uTgwDaL=S9NWAnLnACPzSkGpu_rrChvQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207176>

On Wed, Oct 3, 2012 at 10:44 PM, Alexey Spiridonov
<snarkmaster@gmail.com> wrote:
> Thanks a lot for trying this.
>
> My hashes match. I just re-reproduced it on two flavors of Linux (64
> and 32-bit), with two different Git versions (see below). What
> platform are you using?

x86, 32 bit. Perhaps it has something to do with your configuration
(config files, hooks, attributes). Assuming you use standard
repository templates, you create new repo in your test so hooks and
attributes are out. Is there anything suspicuous in "git config -l"?
-- 
Duy
