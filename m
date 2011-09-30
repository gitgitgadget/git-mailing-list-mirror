From: Pang Yan Han <pangyanhan@gmail.com>
Subject: Re: [PATCH/RFCv3 2/2] receive-pack: don't pass non-existent refs to
 post-{receive,update} hooks in push deletions
Date: Fri, 30 Sep 2011 21:29:03 +0800
Message-ID: <20110930132903.GA1622@myhost>
References: <20110928153935.GA7800@myhost>
 <7vsjngxphv.fsf@alter.siamese.dyndns.org>
 <20110928230809.GA1798@myhost>
 <7vk48sxn5g.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sitaram Chamarty <sitaramc@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 30 15:32:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9dC6-0001Fa-8c
	for gcvg-git-2@lo.gmane.org; Fri, 30 Sep 2011 15:32:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756547Ab1I3Nb6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Sep 2011 09:31:58 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:39718 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752619Ab1I3Nb5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Sep 2011 09:31:57 -0400
Received: by yxl31 with SMTP id 31so1561368yxl.19
        for <git@vger.kernel.org>; Fri, 30 Sep 2011 06:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Gd3KKX2qrUm/z8aXp0h59tBrfBNK3isAfoWw+lVh8Bo=;
        b=uejLrNo5J7vyM1qYQ4Fz3QS8a+AVJLlHFpW3q7Tw98QRxl5tiutCLHkygSnUHO4Fqq
         2fycfbsO0zW6nI2V5dD60X7diFVXga8PuV3Hw8bamWX/HKbpcGv2+JMpRDcLsSTFsNoR
         mIEs2cgPJrrXpGC3GWoDvFMl9lfzhJwtFnDZc=
Received: by 10.236.184.198 with SMTP id s46mr72816125yhm.23.1317389516922;
        Fri, 30 Sep 2011 06:31:56 -0700 (PDT)
Received: from localhost (bb116-14-102-23.singnet.com.sg. [116.14.102.23])
        by mx.google.com with ESMTPS id p8sm6386841yhe.17.2011.09.30.06.31.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 30 Sep 2011 06:31:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vk48sxn5g.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182482>

On Wed, Sep 28, 2011 at 04:28:11PM -0700, Junio C Hamano wrote:
> Pang Yan Han <pangyanhan@gmail.com> writes:
> 
> > I am unable to reply this until much later, but are the tests in this patch ok?
> > It's the first time I'm writing test cases for git.
> 
> I'll squash in a bit more updates and later publish the result.
> Thanks.

Hi Junio,

Thank you for correcting my many amateur mistakes!

Sorry for asking, but do I need to reroll this with the fixup in
origin/ph/push-to-delete-nothing ? Is the commit message fine especially
in light of the changes in the fixup?

Thanks.
