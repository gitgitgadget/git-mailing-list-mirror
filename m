From: "Mark Desnoyer" <mdesnoyer@gmail.com>
Subject: Re: Files not deleted when merging after a rename
Date: Tue, 22 Jan 2008 21:08:21 -0500
Message-ID: <d997e2110801221808r22f19ec9qc1c452e13c7698df@mail.gmail.com>
References: <d997e2110801211145o5fe0a1bbpb1e32dd71b70568e@mail.gmail.com>
	 <20080121212015.GB5263@steel.home>
	 <d997e2110801211345x6ee35d48s2038fbd773149110@mail.gmail.com>
	 <20080122072825.GA2971@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 23 03:08:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHV2q-00031q-Su
	for gcvg-git-2@gmane.org; Wed, 23 Jan 2008 03:08:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752057AbYAWCIX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2008 21:08:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751897AbYAWCIX
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jan 2008 21:08:23 -0500
Received: from wa-out-1112.google.com ([209.85.146.181]:14976 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751858AbYAWCIW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2008 21:08:22 -0500
Received: by wa-out-1112.google.com with SMTP id v27so4746139wah.23
        for <git@vger.kernel.org>; Tue, 22 Jan 2008 18:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=fMRjG64pKPPm6peRIDz8u/IzVEzM10qDLqQknY7hRZs=;
        b=IPtbwZOQF3p/9yi3Gks45ZxTSYShZJdOgzgeRgXQP8/S+veAkF3ss22LcApPcXqwTeXtRUYXVHi2wpdt3dOfPjwpofKXUY3Qb/cIvyV1XJexZP6yTtMm77gsaV/axXCcmWLAyMMINTVoeyb1vZCED2+ZyC8nLApM72OwiFCiX28=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ROt60LvWnM8kPMNOPWkqFyZevT6WKIVhFnrzGKdSDH0kgPiS8RSwoy6+V7ywlSDYT515mFCNcUT7+9vl+Syq7DvYxPuvCheB55/27jdmt3Ml8/EJOXBqOe7DtcsownW3Wtib8kxhtem1DolHWXqig0mmBjiqNEh1BBWwXF9yltE=
Received: by 10.114.121.1 with SMTP id t1mr6165108wac.67.1201054101494;
        Tue, 22 Jan 2008 18:08:21 -0800 (PST)
Received: by 10.114.174.11 with HTTP; Tue, 22 Jan 2008 18:08:21 -0800 (PST)
In-Reply-To: <20080122072825.GA2971@steel.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71492>

Definitely not Winblows. I try to avoid it even with a 10ft pole. I'm
running Ubuntu 7.10.

Could you define "exclusively tracked files"? I'm not sure what you mean here.

-Mark

On Jan 22, 2008 2:28 AM, Alex Riesen <raa.lkml@gmail.com> wrote:
> Mark Desnoyer, Mon, Jan 21, 2008 22:45:40 +0100:
> > Alex,
> >
> > The directory did not have any untracked files in it. Looking a little
> > more carefully, I realized that there were subdirectories in foo/bar/.
>
> Were these subdirectories containing exclusively tracked files?
> Or is it Winblows and some process was blocking the deletion?
>
>
