From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 00/16] Make Gnome Credential helper more Gnome-y and
 support ancient distros
Date: Mon, 23 Sep 2013 15:15:30 -0500
Message-ID: <CAMP44s2G9=eheeyhXB06cH6mDL_nx3OkZics0bTLzRpxYiXt9Q@mail.gmail.com>
References: <1379962157-1338-1-git-send-email-bcasey@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, John Szakmeister <john@szakmeister.net>,
	pah@qo.cx, Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <bcasey@nvidia.com>
X-From: git-owner@vger.kernel.org Mon Sep 23 22:15:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOCXg-0003p9-JM
	for gcvg-git-2@plane.gmane.org; Mon, 23 Sep 2013 22:15:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753477Ab3IWUPc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Sep 2013 16:15:32 -0400
Received: from mail-lb0-f175.google.com ([209.85.217.175]:39851 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753471Ab3IWUPc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Sep 2013 16:15:32 -0400
Received: by mail-lb0-f175.google.com with SMTP id y6so3037935lbh.34
        for <git@vger.kernel.org>; Mon, 23 Sep 2013 13:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=r7Qc8LlUuMZxpTLHDZtgStdu9viYjE/L2kX+MyMFOno=;
        b=JS/JGO/kNYMYqiOtfKrxCKo3TSVTUR4CbXYB1WzFvJWseMGeCL55EqMuWV2tY5ND9M
         CXruyW1NWf8cZX6GJtAiWdlBKcyt3AzS9zU5AIw4mB0jPXssj73biKw0We0+8kGJvdpe
         2vlaNYdT+Em8utAXnE/C28qnm60MczNASabTT7z6Ziwy+19cfOu6QVJU5snHRMAbya74
         F3g43WqfnWL17Et11dx250ESkfwx3+pxZFlCSEWRxwBzHxjjf3BAAF1CI5z+s/BIv/lL
         6spRAMD31658NsHhGae65DZphcFZDZtbjmwvp1CY2+qSApZvGQ+e/SCDBfGfe0ygBISO
         dasg==
X-Received: by 10.152.23.5 with SMTP id i5mr10103170laf.8.1379967330737; Mon,
 23 Sep 2013 13:15:30 -0700 (PDT)
Received: by 10.114.91.230 with HTTP; Mon, 23 Sep 2013 13:15:30 -0700 (PDT)
In-Reply-To: <1379962157-1338-1-git-send-email-bcasey@nvidia.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235238>

On Mon, Sep 23, 2013 at 1:49 PM, Brandon Casey <bcasey@nvidia.com> wrote:
> From: Brandon Casey <drafnel@gmail.com>
>
> Mostly unchanged.
>
> Inserts a patch to fix the style issues for block statements.
> i.e. use "if ()" instead of "if()"
>
> A couple early patches were reordered to improve logical flow.
>
> Updated the comment in the last patch to hopefully improve clarity
> wrt RHEL 4.X
>
> The only functional change is in 14/16 "report failure to store".
> We should accept GNOME_KEYRING_RESULT_CANCELLED as a successful
> return and _not_ produce an error message.
>
> Interdiff follows...

I'm familiar with GLib and I looked at the patches, they look good to me.

-- 
Felipe Contreras
