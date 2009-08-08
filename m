From: Frank Li <lznuaa@gmail.com>
Subject: Re: [ANNOUNCE] tortoisegit 0.9.1.0
Date: Sat, 8 Aug 2009 11:31:04 +0800
Message-ID: <1976ea660908072031pbe6d70dxa6d9716ce787abb@mail.gmail.com>
References: <1976ea660908050700u9b16a8ci169825b121f02cb9@mail.gmail.com>
	 <e1a5e9a00908062225y112984d9gc0486ebcda25ab57@mail.gmail.com>
	 <43d8ce650908062348x3bbfac30w6be13ffce43b33d9@mail.gmail.com>
	 <fabb9a1e0908070924gda3fb09k21d5585083a4c6c1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: John Tapsell <johnflux@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Tim Harper <timcharper@gmail.com>, git@vger.kernel.org,
	tortoisegit-dev <tortoisegit-dev@googlegroups.com>,
	tortoisegit-users@googlegroups.com,
	tortoisegit-announce@googlegroups.com, tortoisegit@googlegroups.com
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 08 05:31:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZceT-0004nx-Gm
	for gcvg-git-2@gmane.org; Sat, 08 Aug 2009 05:31:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932966AbZHHDbF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Aug 2009 23:31:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932892AbZHHDbF
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Aug 2009 23:31:05 -0400
Received: from qw-out-2122.google.com ([74.125.92.25]:4495 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932890AbZHHDbD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Aug 2009 23:31:03 -0400
Received: by qw-out-2122.google.com with SMTP id 8so792177qwh.37
        for <git@vger.kernel.org>; Fri, 07 Aug 2009 20:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=g/whCrjWeHGdcTYq7qsOK0LYUrSbVd9YUOqgZ1kTrCs=;
        b=PPHDzaPJwrlgP2KbEDpZBhwphr277tKWKXD2DOMPQEbClkLaJrXlilCPeb26F7smXX
         rqI9Q5nEO1BExJT4ARx4CRPGo6B+pJS/kRACly1vwDi8iGlCqtkhJwEsofOOIo6t9r6r
         gIUNY5w20/dszAYifomiE3VgoJnYgh1iuK0cs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=tJBDLKbvLdRhmQ0CZ3LSBa+l32I6Z/Vxf7TeE2Zw7cEKsmqDqUA1cNYVP6FUluUXBn
         rZ2QPBqq+mUafq9GOBdS4Mm+bpGmvssqwrgZvHKjzeTJ9c3Cs/fLQCbMA2r/YBcJK3Pw
         eH2ZsR8kdicZwOQI/2j0IoLdvSZ5R/xY+oIHA=
Received: by 10.224.74.8 with SMTP id s8mr1650077qaj.259.1249702264128; Fri, 
	07 Aug 2009 20:31:04 -0700 (PDT)
In-Reply-To: <fabb9a1e0908070924gda3fb09k21d5585083a4c6c1@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125239>

TortoiseGit.DLL that explorer plug-in is not biggest problem.
The biggest problem is TortoiseProc.exe, which is inclued all GUI,
such commit, diff, log view...

TortoiseGit.Dll just launch TortoiseProc.exe to do actuall operation.

git-cheetah just is equal TortoiseGit.DLL.

2009/8/8 Sverre Rabbelier <srabbelier@gmail.com>:
> Heya,
>
> On Thu, Aug 6, 2009 at 23:48, John Tapsell<johnflux@gmail.com> wrote:
>> How hard would it be to port this to KDE?
>
> Impossible.
>
>> What would be involved?
>
> Port all Windows specific code; instead, you should have a look at
> git-cheetah, which aims to do the same thing, only platform agnostic.
>
> --
> Cheers,
>
> Sverre Rabbelier
>
