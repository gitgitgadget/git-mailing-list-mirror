From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: bash completion lacks options
Date: Mon, 7 Sep 2015 17:34:09 +0200
Message-ID: <CACBZZX4aZo_hn07Pho2GtBVNWm7WHLbV6xSi_r-BjW97QWNqEg@mail.gmail.com>
References: <20150907150757.GA6720@aepfle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>
To: Olaf Hering <olaf@aepfle.de>
X-From: git-owner@vger.kernel.org Mon Sep 07 17:34:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZYyRF-0006N6-CK
	for gcvg-git-2@plane.gmane.org; Mon, 07 Sep 2015 17:34:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752794AbbIGPe3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Sep 2015 11:34:29 -0400
Received: from mail-qg0-f41.google.com ([209.85.192.41]:34045 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750818AbbIGPe3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Sep 2015 11:34:29 -0400
Received: by qgez77 with SMTP id z77so64459590qge.1
        for <git@vger.kernel.org>; Mon, 07 Sep 2015 08:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=oWi4cAfiLNaJ8Lx8Wzus0AkReaFw8oDVezvCLI4A1oA=;
        b=l59XX7GUn17WFVdz3gGYErY/EAIJf0nFvScoQHmB5ZOxAeSF1RfJgilnVo8oeKYt+o
         X2LSpcjUQ6Br5CCzAsMISNFLjnLbt+lSForZADm1eXFfua203ZQ29Gx2Tht5fyIb6t3c
         DR5AaaEOlVoT8Szg0iy/wGkHOWFJeDMXBGuU+d29irg5IGBW9sTiDNMzt0foDsQ0n3C9
         73Hd2Hs9rDfQlbb3F/NwdMVx0zYkdrYWR6YcO456XgS2+jW21aJpoPogVJTY+S+HZyh/
         I7HCLH+pqgMldInjfHVnsuKLB0CHEYGUuXeFFbs1OF66rDnWXTxeAS69vrSXfLRXicIc
         ZUZQ==
X-Received: by 10.140.83.202 with SMTP id j68mr8439015qgd.46.1441640068543;
 Mon, 07 Sep 2015 08:34:28 -0700 (PDT)
Received: by 10.55.24.209 with HTTP; Mon, 7 Sep 2015 08:34:09 -0700 (PDT)
In-Reply-To: <20150907150757.GA6720@aepfle.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277466>

On Mon, Sep 7, 2015 at 5:07 PM, Olaf Hering <olaf@aepfle.de> wrote:
> "git send-email --f<tab>" lacks --find-renames and others. Is the list
> of possible options maintained manually?

Yes, see contrib/completion/git-completion.bash.

There's no code for send-email there, you (or someone) could submit a patch! :)

> Perhaps this should be
> automated by placing the long strings in an ELF section, then filling
> variables like $__git_format_patch_options from such ELF section.
> An example how this was done in libguestfs is here (see daemon/daemon.h):
> https://github.com/libguestfs/libguestfs/commit/0306c98d319d189281af3c15101c8d343e400f13

This is an interesting approach, but wouldn't help with git-send-email
in particular, it's a Perl script, so there's no ELF section to parse.
