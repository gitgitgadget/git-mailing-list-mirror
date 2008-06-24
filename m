From: Steven Walter <stevenrwalter@gmail.com>
Subject: Re: why is git destructive by default? (i suggest it not be!)
Date: Tue, 24 Jun 2008 18:21:05 -0400
Message-ID: <20080624222105.GA24549@dervierte>
References: <m31w2mlki4.fsf@localhost.localdomain> <willow-jeske-01l61=64jMFEDjCiBE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Boaz Harrosh <bharrosh@panasas.com>, git@vger.kernel.org
To: David Jeske <jeske@google.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 00:22:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBGu6-0000IY-Sf
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 00:22:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752521AbYFXWVK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 18:21:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752043AbYFXWVJ
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 18:21:09 -0400
Received: from wf-out-1314.google.com ([209.85.200.173]:17869 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751981AbYFXWVI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 18:21:08 -0400
Received: by wf-out-1314.google.com with SMTP id 27so2643202wfd.4
        for <git@vger.kernel.org>; Tue, 24 Jun 2008 15:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=HYqW0Nx/l6LBZzQP1Q9xEUAZmx+BuiCmY87jPTApIcE=;
        b=Ag7S7Wy0Rk5VElqw9pR94VmU/4hLBANbbZb29ALN36L62Q3/7PBfaAlE4k0ZMYAV2n
         X5Yl3sh1G5RCFvkAkxafO9nr+xUg+Sv9o+Uin4v5Yqg7bkYH+qK9Od88ENxSfni2OuM9
         rCuXglLZ6A836LVOE/rzM1af86Kp0V+0nGk+0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=L17L8EdMGyt5Z4wL8TxxjYrUvKDIsav2wo0G+u2lNX7e5nCUi0JKse9ldKRE12I5Sc
         rfxFK6iXeifLw2LodXTj+C/DIOMn+wkZZKQOOsLnE+e4SYqh91QpTZ4guqMDzda65igX
         Wd5rVX0M95SAfwqWNPYB4E61uXkJe35ZFdJlA=
Received: by 10.142.218.6 with SMTP id q6mr6401581wfg.186.1214346068042;
        Tue, 24 Jun 2008 15:21:08 -0700 (PDT)
Received: from dasbrennen.isa-geek.org ( [76.177.32.143])
        by mx.google.com with ESMTPS id 4sm8932282yxq.8.2008.06.24.15.21.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Jun 2008 15:21:07 -0700 (PDT)
Received: by dasbrennen.isa-geek.org (Postfix, from userid 1000)
	id 3B83C11A68; Tue, 24 Jun 2008 18:21:05 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <willow-jeske-01l61=64jMFEDjCiBE>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86157>

On Tue, Jun 24, 2008 at 08:04:30PM -0000, David Jeske wrote:
> I'm not talking about switching "git reset --hard" to "git reset -f". I'm
> talking about requiring a "-f" option to "git reset --hard" when it would
> destroy or dangle information.

I think you're asking for something like the following...
-- 
-Steven Walter <stevenrwalter@gmail.com>
Freedom is the freedom to say that 2 + 2 = 4
B2F1 0ECC E605 7321 E818  7A65 FC81 9777 DC28 9E8F 
