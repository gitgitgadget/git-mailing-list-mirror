From: Eugene Sajine <euguess@gmail.com>
Subject: Re: global hooks - once again
Date: Tue, 6 Jul 2010 11:32:35 -0400
Message-ID: <AANLkTik-CHI2D4HYn1T2ExsyE7G3kKX4LwHf0eQRrfP1@mail.gmail.com>
References: <AANLkTikXJS5QCXMXgsOfkYn9cMBQV6o23tds5YG3A_OI@mail.gmail.com>
	<7v630x1yl8.fsf@alter.siamese.dyndns.org>
	<AANLkTikMEDUI7d5Mzwm8r43zCYTqefyI06PHOMvT1iLz@mail.gmail.com>
	<A612847CFE53224C91B23E3A5B48BAC744940F6E57@xmail3.se.axis.com>
	<AANLkTimSvwo50Q9jsbKkzvplSPE82fNJJDSFmZVw3r5o@mail.gmail.com>
	<AANLkTilZcuYxb6ASgJq82JVdgcRcuak5PvYXZF6fcojm@mail.gmail.com>
	<A612847CFE53224C91B23E3A5B48BAC744940F7000@xmail3.se.axis.com>
	<AANLkTinCFP18B8PQoGREt-izxGSlUb3IzitxK4aeiFRD@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Peter Kjellerstedt <peter.kjellerstedt@axis.com>,
	Alex Riesen <raa.lkml@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: demerphq <demerphq@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 06 17:32:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWA8Z-0007mx-95
	for gcvg-git-2@lo.gmane.org; Tue, 06 Jul 2010 17:32:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752938Ab0GFPci (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jul 2010 11:32:38 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:33828 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751126Ab0GFPci (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jul 2010 11:32:38 -0400
Received: by pxi14 with SMTP id 14so2201742pxi.19
        for <git@vger.kernel.org>; Tue, 06 Jul 2010 08:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=rtyS5ZbiFGY8ejS5a7FkVb9QM6sdh6Dyh7bAcoLK4C0=;
        b=OxuHG4WJOILPoZXpeAAcIME8VLnvqHsZHCjjp+cmrWf141JBQ66YkcL7kFATRHCBbH
         c/E0hd7zAKQZu1hcIRF5Y2Jp1tRIAxOvGcciqeRIBSepNCRslrX+YxV/umc9+YTg+uDv
         GJvCVVwCLJQ/5BRRKogrOngifn8y9s0BNCRLE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=LZgLQKT35pJ0uyIGLBftCEf5tnKXG1y+7SNM5tSA664tM4ItmGNt5g7UiA22scPNGg
         QiQU6etW5zNp/WERrZI1LXm6soyyWlou0xMFa7R8zZWX6Wk7Um2bfYNctqSgTFkzxAb3
         6N3ShGtWrm9CD83i1FGDevMdtiG5auCiIqLGQ=
Received: by 10.229.189.147 with SMTP id de19mr2789690qcb.216.1278430355397; 
	Tue, 06 Jul 2010 08:32:35 -0700 (PDT)
Received: by 10.229.212.209 with HTTP; Tue, 6 Jul 2010 08:32:35 -0700 (PDT)
In-Reply-To: <AANLkTinCFP18B8PQoGREt-izxGSlUb3IzitxK4aeiFRD@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150364>

> For instance i can imagine that boxes that devs actively work on would
> have no global setting, and central version control boxes would have
> it.
>
> cheers,
> Yves
>

I suppose the default configuration is not suggesting any system or
global level hooks folders defined in proposed solution. If some admin
or SCM makes a decision about system level hooks - he has to know what
he's doing - that's is pretty much it. But it might be very
comfortable way to set up some rules or enforce policies.
OTOH user level (--global) hooks are going to be responsible for what
user does all the time and wants to automate.


Thanks,
Eugene
