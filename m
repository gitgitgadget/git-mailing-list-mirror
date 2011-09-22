From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [PATCH] Clarify that '--tags' fetches tags only
Date: Thu, 22 Sep 2011 00:13:21 +0000
Message-ID: <CAMOZ1BuSd52woX0utOQ84gbCzBkZg3ATKnE+7G_BrD5_hUQSiQ@mail.gmail.com>
References: <1314997486-29996-1-git-send-email-anatol.pomozov@gmail.com> <1316649176-32352-1-git-send-email-anatol.pomozov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, gitster@pobox.com, computerdruid@gmail.com
To: Anatol Pomozov <anatol.pomozov@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 22 02:13:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6WvN-0004Ya-U1
	for gcvg-git-2@lo.gmane.org; Thu, 22 Sep 2011 02:13:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751290Ab1IVANw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Sep 2011 20:13:52 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:41445 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751167Ab1IVANv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Sep 2011 20:13:51 -0400
Received: by iaqq3 with SMTP id q3so2211924iaq.19
        for <git@vger.kernel.org>; Wed, 21 Sep 2011 17:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=J6zfblXLzFp7OBri0xMhnN9akHrgEqUBg6AjR5pkj0E=;
        b=PA8e6uz+S1u90mvBlntZbq9FCOnImoN87WqP6h4oLZilt3c1GQz64vilGfleLD66mc
         GtG1gwKavochXAqM98Of2P8149zNXJY3qm7ET4PripIs19RgOBCYcuDVUUuyOo21pwOf
         Itcvs+CRQPbD4sbjCR7XHaHqr7vxLDBtj2CeM=
Received: by 10.42.97.8 with SMTP id l8mr1011423icn.3.1316650431044; Wed, 21
 Sep 2011 17:13:51 -0700 (PDT)
Received: by 10.42.171.194 with HTTP; Wed, 21 Sep 2011 17:13:21 -0700 (PDT)
In-Reply-To: <1316649176-32352-1-git-send-email-anatol.pomozov@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181869>

On Wed, Sep 21, 2011 at 23:52, Anatol Pomozov <anatol.pomozov@gmail.com> wrote:
> +       linkgit:git-config[1]. Note that if this option is specified
> +       then only tags are fetched, refs under refs/heads/* stay unchanged.

Note that if this option is specified, then only tags
are fetched; refs under refs/heads/* are not changed.
