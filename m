From: David Aguilar <davvid@gmail.com>
Subject: Re: Conflict markers in mergetool $LOCAL ?
Date: Tue, 17 Aug 2010 02:30:23 -0700
Message-ID: <20100817093008.GA26357@gmail.com>
References: <loom.20100817T054731-955@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Seth House <seth@eseth.com>
X-From: git-owner@vger.kernel.org Tue Aug 17 11:23:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlIOW-0000N2-5p
	for gcvg-git-2@lo.gmane.org; Tue, 17 Aug 2010 11:23:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755451Ab0HQJXj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Aug 2010 05:23:39 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:46923 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752241Ab0HQJXi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Aug 2010 05:23:38 -0400
Received: by pzk26 with SMTP id 26so2273767pzk.19
        for <git@vger.kernel.org>; Tue, 17 Aug 2010 02:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=2GZk8jNJwkolepJNoEXS1WlmtSHFGhV3giPz0kdmazU=;
        b=fb9AjrzH7bQqPSz3oHGQPMcIPIXFoguWi2FTfjmvHcA4cM6O7cZCrsUNVcgIL5Gd88
         2h1Qz/ZOHcku1TYZllzj15gCsihRDrL7xzIqbJqpewIIp/Tocsn7J7ti7b+zZZ2H5yZh
         Ceam7xFKO9F9pC6e9W83oP/AH+KfBgzBabSeU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=nwOTtXvHzCc2Kv4s602OJ0KYVr+inGYWvOiSHvBW/WBkHw1zemar2csv3hAL6ysTm/
         KtYF+usbm50XZomhobsD14F0argZiJU3AALV6F4r9l92PxmxM8+LHe9JouveGxYgUbpb
         rkl068lvAFUPiW/S0R7d6s3OiAOizB+LvVXp8=
Received: by 10.142.136.1 with SMTP id j1mr5544119wfd.343.1282037018008;
        Tue, 17 Aug 2010 02:23:38 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id b19sm411872wff.7.2010.08.17.02.23.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 17 Aug 2010 02:23:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <loom.20100817T054731-955@post.gmane.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153735>

On Tue, Aug 17, 2010 at 04:34:20AM +0000, Seth House wrote:
> [...]
> For small conflicts, I like the conflict markers and simply editing the
> conflicted file with Vim. For files with lots of conflicts I would like to use
> vimdiff but I wouldn't expect the conflict markers to appear there -- it's
> redundant information in a 3-way merge.
> 
> Is there a better Git Way (TM) that I'm missing? Is my Git setup borked
> somehow?
> 
> I have the following in my ~/.gitconfig and a stock Git installation on Arch
> Linux.
> 
> [merge]
>     tool = vimdiff


What happens if you remove this section?:

> [mergetool "vimdiff"]
>     cmd = vimdiff
>     trustExitCode = true

mergetool has built-in support for vimdiff.
You shouldn't need to define mergetool.vimdiff.cmd.

Does that change anything?

-- 

	David
