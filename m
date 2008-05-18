From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: [PATCH v2 3/5] git-submodule.sh: Add Custom argument input support to git submodule recurse subcommand
Date: Sun, 18 May 2008 17:34:31 +0200
Message-ID: <bd6139dc0805180834q57e1d4a0ieef2683ff82a9b54@mail.gmail.com>
References: <1209978582-5785-1-git-send-email-imyousuf@gmail.com>
	 <1209978582-5785-2-git-send-email-imyousuf@gmail.com>
	 <1209978582-5785-3-git-send-email-imyousuf@gmail.com>
	 <7v7idzxhwp.fsf@gitster.siamese.dyndns.org>
	 <bd6139dc0805180636o4c5141c5vee559290832a4f03@mail.gmail.com>
	 <alpine.DEB.1.00.0805181627320.30431@racer>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, imyousuf@gmail.com,
	git@vger.kernel.org,
	"Imran M Yousuf" <imyousuf@smartitengineering.com>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun May 18 17:35:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jxkuz-0000zd-0G
	for gcvg-git-2@gmane.org; Sun, 18 May 2008 17:35:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754201AbYERPee (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 May 2008 11:34:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754165AbYERPee
	(ORCPT <rfc822;git-outgoing>); Sun, 18 May 2008 11:34:34 -0400
Received: from wf-out-1314.google.com ([209.85.200.173]:1594 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754155AbYERPed (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 May 2008 11:34:33 -0400
Received: by wf-out-1314.google.com with SMTP id 27so999748wfd.4
        for <git@vger.kernel.org>; Sun, 18 May 2008 08:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=36qJXfEKZdxtYiT5SMyadjGxFTmbubyrqmKWHmNPcVw=;
        b=Z21oAu5eYcjMQh93k4HvSjpPDe6cLvVVAHrK6KlUnamJKVpERmkBIs+5ES1beoNOyvZ2GtPSwH4bLvsVrySmIdjrgLAC+TsC7nbY9nasBTR+Su/IUfP2/O7VSwotSAovN/sN/mpzbDL5VkFktUZ8NQKHEMgpZF4ruG0/GBwTFks=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fdOQim6cT2v/doQrcB2MU0qWTEsEmwPI31JHuacl1uHaIhL5Sa5n46yHk13nbzokOPsESps/AaxE2L9PLYraHi6ja0EX1WPp3ZC27IML8iWxg+b38fKFMTCiWZBbSCj5q8XfJg6rfJYRSkWnWlBh1I5yNqV3aAeggAIJ5uk6mCQ=
Received: by 10.143.6.19 with SMTP id j19mr2409535wfi.330.1211124871041;
        Sun, 18 May 2008 08:34:31 -0700 (PDT)
Received: by 10.143.33.6 with HTTP; Sun, 18 May 2008 08:34:31 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0805181627320.30431@racer>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82390>

On Sun, May 18, 2008 at 5:32 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> git-repack already relies on "find", and if you have no silly naming
> scheme *1*, you do not need "xargs".  Besides, we do ship xargs.exe.

Ok, awesome, sounds like a good solution to me then.

-- 
Cheers,

Sverre Rabbelier
