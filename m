From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Add Gitweb support for LZMA compressed snapshots
Date: Fri, 31 Jul 2009 15:45:02 +0000
Message-ID: <94a0d4530907310845k51dbafbfy8e240467113dfc16@mail.gmail.com>
References: <E0C39B59-E2C5-4C28-9570-D33FEA2A44EB@uwaterloo.ca>
	 <m3r5vy1siq.fsf@localhost.localdomain>
	 <alpine.DEB.1.00.0907301042300.7467@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	Mark A Rada <marada@uwaterloo.ca>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jul 31 17:45:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWuIE-0008Co-3m
	for gcvg-git-2@gmane.org; Fri, 31 Jul 2009 17:45:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751761AbZGaPpF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 31 Jul 2009 11:45:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751719AbZGaPpF
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Jul 2009 11:45:05 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:43547 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751669AbZGaPpE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 31 Jul 2009 11:45:04 -0400
Received: by fg-out-1718.google.com with SMTP id e21so629746fga.17
        for <git@vger.kernel.org>; Fri, 31 Jul 2009 08:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=iHoAOvVKpmtykEQds4bJwCwrDglB89unV8QA5RAaTUA=;
        b=IT2xPj2pBdecUjl7SFKrN9NGQaOt5knG5v9TyLMn+WZLegz0cWhrIbw6aen/I4/vF1
         FyxsvBKyZOe5qNtCrqx5EYSvZWb0TrkoUpH0PHeBkD/zrecRXrQJJ39cFrNKllB+af5H
         +G9P/rafe1eM3jYvgp2afysM0uB/jU5oeFYE0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=jmTWe0ZV7lbuAN59+OMHia97zrI9Me8+3Zk6zyNDP7omtiXeL5xs5OofgFC2iHocf4
         A1uv1Yay7NZiGOSd20m9W+NHVeUdoSSmOHiiiqKFAAjyRY/78stn2g20tSCDf0k4TRza
         caHHSfDQ4wSEV+5z+MvNXi/aaBmmAoxy+FyTs=
Received: by 10.86.31.14 with SMTP id e14mr893508fge.79.1249055103639; Fri, 31 
	Jul 2009 08:45:03 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0907301042300.7467@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124571>

On Thu, Jul 30, 2009 at 8:43 AM, Johannes
Schindelin<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Thu, 30 Jul 2009, Jakub Narebski wrote:
>
>> BTW. I wonder if it would be good idea to add support for this forma=
t
>> directly to git-archive... =C2=A0OTOH it would mean additional depen=
dency.
>
> I don't think it would be a good idea; we do not have bzip2 support
> either.

bzip2 has no advantages whatsoever. AFAIK xz is superior to other
formats and it would be nice to see git make a technological stance
encouraging xz.

> The only reason we have inbuilt gzip and zip support is because the f=
ormat
> is so similar to Git's own compression.

Personally I don't see the point of having zip support.

--=20
=46elipe Contreras
