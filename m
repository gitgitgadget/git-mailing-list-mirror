From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git merge - "both added" conflict resolution
Date: Wed, 4 Aug 2010 15:59:16 -0500
Message-ID: <20100804205916.GC2920@burratino>
References: <AANLkTi=Hp6DsE75XbgehS2bucp-M9NXmGgYbvw0kp6j8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 04 23:00:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ogl4x-0002Xi-A6
	for gcvg-git-2@lo.gmane.org; Wed, 04 Aug 2010 23:00:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759049Ab0HDVAn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Aug 2010 17:00:43 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:63683 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759033Ab0HDVAl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Aug 2010 17:00:41 -0400
Received: by eya25 with SMTP id 25so2155135eya.19
        for <git@vger.kernel.org>; Wed, 04 Aug 2010 14:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=UQHKusiv/rUG/HqLE6RjeL34FcuHN/o1i+dQQ2X/3AU=;
        b=TUFHPtG+DdOkpARImXw3GR8E+Mufusxu54VRLc3AhCFzsTmeUWhjna8wrPFd5e5TaX
         UcaBuFC3xoqGymbrXDR7ygCHrZjcUH0O2NzCh0IBLF735vcUwVfxHnU+4W1rvioyq1tG
         s6TYgw5vNVnczrLvwWeTktfmpqsCBfdNSzRFk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=bVTuhDyxmuOPaByGA6KtDPPcIWSkmwxHeHmEnFabXPRfqhMfeaKIYm9OGTzcE1A85N
         KGv8OyOU6xF86iZt/EJ/RSU76yvt9rx8XD110J/wpU330HhLo6uN7T051gVxtHNQ5jXr
         FpULTZc5f8ZF/TsXdef10wKqLYkKtXl9RCGiI=
Received: by 10.213.32.135 with SMTP id c7mr7122856ebd.2.1280955640414;
        Wed, 04 Aug 2010 14:00:40 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id v59sm13453232eeh.4.2010.08.04.14.00.38
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 04 Aug 2010 14:00:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTi=Hp6DsE75XbgehS2bucp-M9NXmGgYbvw0kp6j8@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152603>

Hi Eugene,

Eugene Sajine wrote:

[in an add/add conflict]
>           when i resolve the conflict the build.xml returns to its
> last committed state of dest repo, so git cannot determine any
> changes.
> Therefore, i cannot execute git add for this file and i cannot commit
> my merge results

Could you explain further (preferrably with a simple example
transcript)?  I would think that after an add/add conflict,
a simple "git add" would mark the file resolved and allow
committing.
