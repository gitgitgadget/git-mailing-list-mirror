From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] git_open_noatime(): drop unused parameter
Date: Sun, 15 May 2011 12:21:01 -0700
Message-ID: <BANLkTikWPzje0oXPqSRAtpWZ2g6vn5NyVQ@mail.gmail.com>
References: <7voc33pyeq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 15 21:21:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLgsa-0008PG-OC
	for gcvg-git-2@lo.gmane.org; Sun, 15 May 2011 21:21:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751567Ab1EOTVX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 May 2011 15:21:23 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:64079 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751279Ab1EOTVW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2011 15:21:22 -0400
Received: by vxi39 with SMTP id 39so2753890vxi.19
        for <git@vger.kernel.org>; Sun, 15 May 2011 12:21:21 -0700 (PDT)
Received: by 10.52.181.98 with SMTP id dv2mr2955090vdc.33.1305487281086; Sun,
 15 May 2011 12:21:21 -0700 (PDT)
Received: by 10.52.157.73 with HTTP; Sun, 15 May 2011 12:21:01 -0700 (PDT)
In-Reply-To: <7voc33pyeq.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173648>

On Sun, May 15, 2011 at 12:16, Junio C Hamano <gitster@pobox.com> wrote:
> Since commit c793430 (Limit file descriptors used by packs, 2011-02-28),
> the extra parameter added in f2e872aa (Work around EMFILE when there are
> too many pack files, 2010-11-01) is not used anymore.
>
> Remove it.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

Thanks for cleaning this up.

Acked-by: Shawn O. Pearce <spearce@spearce.org>

-- 
Shawn.
