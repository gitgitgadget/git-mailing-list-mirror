From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH v4 3/4] Allow hiding renames of individual files involved
 in a directory rename.
Date: Mon, 4 Oct 2010 01:06:13 +0200
Message-ID: <AANLkTi=S0AkNdajK5MM60HUxHPG1R=Tp_iL8S8Ds4P+j@mail.gmail.com>
References: <1286138529-6780-1-git-send-email-ydirson@altern.org>
 <1286138529-6780-2-git-send-email-ydirson@altern.org> <1286138529-6780-3-git-send-email-ydirson@altern.org>
 <1286138529-6780-4-git-send-email-ydirson@altern.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Yann Dirson <ydirson@free.fr>
To: Yann Dirson <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Mon Oct 04 01:06:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2Xdh-0006sW-6r
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 01:06:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751265Ab0JCXGf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Oct 2010 19:06:35 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:49075 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751045Ab0JCXGf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Oct 2010 19:06:35 -0400
Received: by iwn5 with SMTP id 5so6161307iwn.19
        for <git@vger.kernel.org>; Sun, 03 Oct 2010 16:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=luc5nya2NYbWOTAwFEHZhdPX5jPn15gvEiLno5RKco8=;
        b=ZeT3pocCGrg2SQz37jb1zO+Dpyxeh7R16PtIZNodeuV2NGMNO7yUJ6HjqhLG5AGsUV
         lb6hPR4J8KiBI9Camh0wPIdP+JoFfd3VbyrqFuCWZN6P0pSqpBYqK/y+ZBP4hDkomDhm
         7Bf6ycp7ssTBe6IF/w/A538z0LW90XWGWC60E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=RQDClcTKtVYTrMxu8UqtYEuNuGdrh9ZhO1VZvK3tPHh7E0UVwnxXIQhkD8qCdppuNl
         ne+eJAOCbUcM1vIUQXf2inTcaAVA0CNcMAFABNLMH6EPdNUkh0eInPxZR+UPXhkRSYVR
         VfwWziFJPO8h2v1kkQI5OgwyuTR2e/Z2uJDIk=
Received: by 10.231.149.12 with SMTP id r12mr9123593ibv.185.1286147194586;
 Sun, 03 Oct 2010 16:06:34 -0700 (PDT)
Received: by 10.231.33.138 with HTTP; Sun, 3 Oct 2010 16:06:13 -0700 (PDT)
In-Reply-To: <1286138529-6780-4-git-send-email-ydirson@altern.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157942>

Heya,

On Sun, Oct 3, 2010 at 22:42, Yann Dirson <ydirson@altern.org> wrote:
> This makes it much easier to a human reader to spot content changes
> in a commit that also moves a whole subtree.

I'd like to use this by default (but only for regular 'git diff', 'git
log', etc., not for 'git format-patch') if/when it gets merged, can
has config option?

-- 
Cheers,

Sverre Rabbelier
