From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/3] bisect: document that --no-checkout is the default
 for bare repositories
Date: Sun, 7 Aug 2011 08:43:47 -0500
Message-ID: <20110807134347.GB10748@elie.gateway.2wire.net>
References: <1312714240-23647-1-git-send-email-jon.seymour@gmail.com>
 <1312714240-23647-4-git-send-email-jon.seymour@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, chriscool@tuxfamily.org,
	j6t@kdbg.org, jnareb@gmail.com
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 07 15:44:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qq3e4-0005R6-8e
	for gcvg-git-2@lo.gmane.org; Sun, 07 Aug 2011 15:44:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753233Ab1HGNnz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Aug 2011 09:43:55 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:57240 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753122Ab1HGNnz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Aug 2011 09:43:55 -0400
Received: by iye16 with SMTP id 16so7138022iye.1
        for <git@vger.kernel.org>; Sun, 07 Aug 2011 06:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=c8trBMvFBlpcHO23myS6DTQCWoULB0OnFh163gfl2C8=;
        b=GUrb8GL/Wff9VBngk/n2xfLmez/kbBDZW7RTY7jMH4V4i2Ox/1wHDTCGyfWeUI3WtJ
         PiW5Ci4FMN0Jx21IJjsk5jhHoRJbysEdjFvPJ/iNcp2t6IVIN9DOouCDPS5wk4Z816eN
         +1RwMccbMmuj16PfmUqvI8EEcAedNHJcReRWY=
Received: by 10.42.18.136 with SMTP id x8mr878449ica.31.1312724634609;
        Sun, 07 Aug 2011 06:43:54 -0700 (PDT)
Received: from elie.gateway.2wire.net (adsl-69-209-49-224.dsl.chcgil.ameritech.net [69.209.49.224])
        by mx.google.com with ESMTPS id d8sm5147382icy.9.2011.08.07.06.43.52
        (version=SSLv3 cipher=OTHER);
        Sun, 07 Aug 2011 06:43:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1312714240-23647-4-git-send-email-jon.seymour@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178917>

Jon Seymour wrote:

> Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
> ---
>  Documentation/git-bisect.txt |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
> index 41e6ca8..e4f46bc 100644
> --- a/Documentation/git-bisect.txt
> +++ b/Documentation/git-bisect.txt
> @@ -273,6 +273,8 @@ it point to the commit that should be tested.
>  +
>  This option may be useful when the test you would perform in each step
>  does not require a checked out tree.
> ++
> +If the repository is bare, `--no-checkout` is assumed.

Thanks.  I think this should be squashed with patches 1 and 2, though I
don't mind it having been split out for review.

The whole series looks good, even given the tiny nitpicks in patch 2 I
mentioned. :)
