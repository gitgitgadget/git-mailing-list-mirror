From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [RFC PATCH 1/2] New remote helper git-remote-fd
Date: Sat, 26 Jun 2010 16:33:05 +0200
Message-ID: <AANLkTinyn5gLa1UHsFVCPy2yTsP5O16yEq2uzelGszGt@mail.gmail.com>
References: <1277562017-3316-1-git-send-email-ilari.liusvaara@elisanet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Sat Jun 26 16:39:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OSWXC-0006Ty-Sm
	for gcvg-git-2@lo.gmane.org; Sat, 26 Jun 2010 16:39:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751591Ab0FZOd1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jun 2010 10:33:27 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:47369 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751093Ab0FZOd0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jun 2010 10:33:26 -0400
Received: by iwn41 with SMTP id 41so2946461iwn.19
        for <git@vger.kernel.org>; Sat, 26 Jun 2010 07:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=tfklhAUWY/ROTM8ogI6KVLG/PMUAhYj69woCC3/COc0=;
        b=dTgZHF8pANLjugsLgQUWJWj6TzxZ4nF/hGtBesUmK8e5Z5I6u+IPrtbZBrmj/9hgdV
         U+ZIgImJzp6LRdOKrejR1z7Q5xOROtvJPmttPaCH9z52RPU5b7mR59QDe0F5Pl2Z6Qu9
         om/bbcmJNQiiZjUmuzO2I95htwrThXrv2/HCI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=gR3R/6FHsyI1PwV0oY9su5UMLReIeBZXI5BBM5r9i+Bc965m8IkkYciK9O3BR7Q87k
         Kv7QNu63GSeLCGlFZYyCDaEdAohxbXTA6p0B+yzrp5rAkDUdLRVBpQJntJMkisVg/FhT
         kBKgvYhaEdL6nyjTZ+EWRAFyE7a0yoQimOUdY=
Received: by 10.231.183.19 with SMTP id ce19mr2381399ibb.35.1277562805103; 
	Sat, 26 Jun 2010 07:33:25 -0700 (PDT)
Received: by 10.231.50.129 with HTTP; Sat, 26 Jun 2010 07:33:05 -0700 (PDT)
In-Reply-To: <1277562017-3316-1-git-send-email-ilari.liusvaara@elisanet.fi>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149759>

Heya,

On Sat, Jun 26, 2010 at 16:20, Ilari Liusvaara
<ilari.liusvaara@elisanet.fi> wrote:
> This remote helper reflects the outgoing smart transport stream back to
> caller. This is useful if some frontend wants to handle the transport
> stream for some reason (e.g. offering more options for SSH).

I don't understand the intended use of either this helper, nor the one
in the next patch. Can you give a more concrete explanation?

-- 
Cheers,

Sverre Rabbelier
