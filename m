From: "Stephen Sinclair" <radarsat1@gmail.com>
Subject: Re: Project Hosting with git ?
Date: Sat, 12 Jan 2008 12:54:00 -0500
Message-ID: <9b3e2dc20801120954k24f7ccb6vf019f30843ff1b84@mail.gmail.com>
References: <912ec82a0801120553u3621c991u7c4cb4793960159c@mail.gmail.com>
	 <9b3e2dc20801120845n15d59fe6q178ba257c12a28e0@mail.gmail.com>
	 <4788FBDE.6090903@gbarbier.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?Gr=E9goire_Barbier?=" <devel@gbarbier.org>
X-From: git-owner@vger.kernel.org Sat Jan 12 18:54:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDkYy-0001Qu-FP
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 18:54:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755427AbYALRyE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2008 12:54:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754219AbYALRyD
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jan 2008 12:54:03 -0500
Received: from rv-out-0910.google.com ([209.85.198.185]:42964 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753358AbYALRyA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2008 12:54:00 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1279521rvb.1
        for <git@vger.kernel.org>; Sat, 12 Jan 2008 09:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=X1kkU2bpik3EN+woWw4En1KOt5CkDzh6mIdCvBUHaF0=;
        b=I+GGGttAQnm2UbYadbFNGhQ19wja3mx+X6Z0HkTrVL71mAy9bTaDO+POEWizTCJ0KrSJOJkJ4KYKIdCrqGpTymBDpkpYgGuy1TTi+C6hJMrmxpWtRteuOfhWtCJ+DREE+rwOQ9ZAfoq+mMc1HCzXpoN6ZBCEdPktDTPKjBygO8g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=izCrO3whTr4aRjxtcJbX/lIkKV/5xiTtC/l4ccIRd13OF/UCL0VhT3d4bv+DJiXCX9YRCqB+Kl/JPLbLRoFS7+F1I9oQ8utwMMsByqoNtryXoyUKDn52zijjBGOkIg2KZGNKFEPUq/tyidNkxxaINr93m05yPMj9txH3A7qyZTY=
Received: by 10.141.51.15 with SMTP id d15mr2799824rvk.118.1200160440084;
        Sat, 12 Jan 2008 09:54:00 -0800 (PST)
Received: by 10.140.188.1 with HTTP; Sat, 12 Jan 2008 09:54:00 -0800 (PST)
In-Reply-To: <4788FBDE.6090903@gbarbier.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70337>

> I disagree: git does not work "fine" over http, it only works fine for
> fetch/pull.

You're taking me out of context.  I meant it works fine for public
hosting so that users can easily clone and create patches.  This is
the main motivation for publishing your repo, so in that sense it
"works fine".  (for me)
Since SF supports ssh, there's no reason to need http-push.  I wish
they would just provide some recent git binaries on the sourceforge
server, then we could git-push properly over ssh instead of using to
use scp or rsync.  I think that would be a good start. *shrug*

In any case, http-push over webdav would still require git binaries to
be installed somewhere on SF, so it's essentially the same problem.


Steve
