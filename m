From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Git terminology: remote, add, track, stage, etc.
Date: Thu, 28 Oct 2010 20:50:56 +0530
Message-ID: <20101028152053.GA29091@kytes>
References: <8835ADF9-45E5-4A26-9F7F-A72ECC065BB2@gmail.com>
 <AANLkTimkovH9OysLSxA+=di89Xi+dTCYL5hRPmNaADDH@mail.gmail.com>
 <20101019175103.GA28847@kytes>
 <20101027150314.GB1136@kytes>
 <1288192595.15518.37.camel@drew-northup.unet.maine.edu>
 <vpqwrp3y5wp.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Drew Northup <drew.northup@maine.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Thore Husfeldt <thore.husfeldt@gmail.com>, git@vger.kernel.org,
	Scott Chacon <schacon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Oct 28 17:21:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBUIG-0002iT-T6
	for gcvg-git-2@lo.gmane.org; Thu, 28 Oct 2010 17:21:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755621Ab0J1PV2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Oct 2010 11:21:28 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:56209 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757093Ab0J1PV1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Oct 2010 11:21:27 -0400
Received: by vws13 with SMTP id 13so329300vws.19
        for <git@vger.kernel.org>; Thu, 28 Oct 2010 08:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Y+xh8TiYAfvNpDE2c039/DdZPqK3ioRk9fLwc5zfrWk=;
        b=FTR3ZZwo/DarzwL+GPSuSj0+i56t6HOv1+aa38geOMgO9zvIUiw2LTr3KUjLnwZLnD
         pc9uckfXsV3r3V58EK1DengNqBuAFo1PMhoGUw9gk0i18ITlwuTnRBYpdIBJP8Mzc1SO
         E0ix1Sc26tboLOmEGfenqWFgna4jLr0xFglIQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=AzDj/5rcKIilA9nVIYuAaZd0US7BCpMwxCMZfP+Tl60t6KrxdhXZnwYmRs89/uz6AS
         ADDRozjEwJLLZozqR/nDiEcPh3+LFI4XTHw89mGHSoIhPyXh8sO0PBG/LzvyygiCruww
         +oigxYuVh0y2YgwF9jk4Qqy77Y/Q20Ato5R9w=
Received: by 10.142.179.21 with SMTP id b21mr261132wff.432.1288279285159;
        Thu, 28 Oct 2010 08:21:25 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id p8sm15218258wff.16.2010.10.28.08.21.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 28 Oct 2010 08:21:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <vpqwrp3y5wp.fsf@bauges.imag.fr>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160181>

Hi Matthieu,

Matthieu Moy writes:
> Drew Northup <drew.northup@maine.edu> writes:
> 
> > Matthieu has been working on a more comprehensive set of documentation
> > patches
> 
> Right. I had missed your patches and our works overlapped.

Ah, I saw your huge series on the list. Looks like it needs to be
re-rolled after the reviews?

> > --which I'm pretty sure include all of the changes you just
> > mentioned.
> 
> Not all:
> 
> >> > Subject: [PATCH] Documentation: Consistently use the hyphenated "remote-tracking"
> 
> This (and other "synonyms" of remote-tracking) is addressed by my
> patch, but

Ok, we can drop this patch then- your version is more complete.

> >> > Subject: [PATCH] UI: Don't say "working directory" when we really
> >> > mean "working tree"
> 
> this isn't.

You might like to include it in your next re-roll or just leave it as
an independent patch for Junio to pick up.

-- Ram
