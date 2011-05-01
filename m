From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Add --info-path and --man-path options to git.
Date: Sun, 1 May 2011 18:53:32 -0500
Message-ID: <20110501235332.GD11550@elie>
References: <1304237785-56101-1-git-send-email-jon.seymour@gmail.com>
 <7vbozmthhy.fsf@alter.siamese.dyndns.org>
 <20110501234833.GC11550@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jon Seymour <jon.seymour@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 02 01:53:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QGgSM-0008LY-M7
	for gcvg-git-2@lo.gmane.org; Mon, 02 May 2011 01:53:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753466Ab1EAXxi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 May 2011 19:53:38 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:63138 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751354Ab1EAXxh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2011 19:53:37 -0400
Received: by iyb14 with SMTP id 14so4284214iyb.19
        for <git@vger.kernel.org>; Sun, 01 May 2011 16:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=TE/CzZDO/SurIZGGTrInMI3RIgQJlZil1qoXYt61qNk=;
        b=orW78iokdfZRoEFNGNrenlpgMUtbWN9BFEjVmb3fh4I9gyeGdq2dHsyDq3HtNe/JrC
         odiVoULyd2DEbPX73v4WtHX+a9N5SmK+xWu2Km4oWNmo2sKYjfnk0syvrPyLsIb/nvRN
         zIkL95lUVEqRoYoyv6+osmySyXJBBgiTsx/CI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=cjeUm3bVRyPcH1yC7GF2CzhpPrDiWn0ESzRiwR6vWR/L2AmzkN/iSv7S3rboxSJk16
         2srmVLfYbrrPG8+FcZ1AD3wS9IBIEI7V3Rra5ulk4D8p7COz/+6Oryi4E4d2K+mM38IO
         j1mgTA3nx2MUdgUTQ3ZQu2toSsMvQNy3Gsc7U=
Received: by 10.231.216.168 with SMTP id hi40mr5727301ibb.196.1304294016965;
        Sun, 01 May 2011 16:53:36 -0700 (PDT)
Received: from elie (adsl-69-209-62-211.dsl.chcgil.ameritech.net [69.209.62.211])
        by mx.google.com with ESMTPS id 19sm2122014ibx.52.2011.05.01.16.53.35
        (version=SSLv3 cipher=OTHER);
        Sun, 01 May 2011 16:53:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110501234833.GC11550@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172552>

Hi again,

Two quick corrections.

Jonathan Nieder wrote:

> So if "git gui" were to gain a
> documentation viewer widget instead of relying on git web--browse, it
> would need the HTML path.

Actually, it already uses the HTML path. :)

> So while I can't see the harm in exposing --info-path and --man-path,
> the current patch seems to do an incomplete job of documenting them.
> Perhaps this is about finding the documentation corresponding to a
> particular copy of git when a machine has multiple copies?

It seems Jon's and my mails crossed.  Here's another use case for
--man-path: if your frontend wants to fall back to HTML documentation
without spawning a man pager when the manpages are not installed, it
needs to know where to look.

(See also gitgui-0.6.0~32, git-gui: Offer quick access to the HTML
formatted documentation, 2007-01-28)
