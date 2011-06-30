From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Undo last commit?
Date: Thu, 30 Jun 2011 10:20:40 +0530
Message-ID: <BANLkTim459-Jx2R9GpBdkck7PMAEbamJeA@mail.gmail.com>
References: <BANLkTinWujKYvx_fh2iBDOdMbywqzfgwUA@mail.gmail.com>
 <m31uyrutx7.fsf@localhost.localdomain> <20110619003718.GA5628@elie>
 <201106191237.55825.jnareb@gmail.com> <4DFF382A.5030206@micronengineering.it>
 <4E09DDAE.30801@ira.uka.de> <BANLkTimZN4swfY13zMjkCbAc9UsGSix02Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Holger Hellmuth <hellmuth@ira.uka.de>,
	Massimo Manca <massimo.manca@micronengineering.it>,
	Jakub Narebski <jnareb@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Ben Walton <bwalton@artsci.utoronto.ca>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: Mike <xandrani@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 30 06:51:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qc9DX-0007mk-Te
	for gcvg-git-2@lo.gmane.org; Thu, 30 Jun 2011 06:51:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751091Ab1F3EvD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jun 2011 00:51:03 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:65390 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750889Ab1F3EvB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2011 00:51:01 -0400
Received: by wyg8 with SMTP id 8so1287886wyg.19
        for <git@vger.kernel.org>; Wed, 29 Jun 2011 21:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=gxDqwef5QSVH2wvaOcclILCNnAJnACRcev3MJnhCLuY=;
        b=KJIRWv1+81zdP2VMbktSzpL62j+254lFhtLgs8bBz6Eg1O/IrD/GYASgCyuCf8YlNi
         CwZftGxWCrGdSVPIA10ZTK/Ds4RQ2MnGo6xowB7zjPsrHsL6V2AY2pNnK73rPOpdrPIy
         7c7YJWaYU043oVPJTwxmT+r/Gv8VbMdFoVxBY=
Received: by 10.216.187.136 with SMTP id y8mr258614wem.106.1309409460076; Wed,
 29 Jun 2011 21:51:00 -0700 (PDT)
Received: by 10.216.18.16 with HTTP; Wed, 29 Jun 2011 21:50:40 -0700 (PDT)
In-Reply-To: <BANLkTimZN4swfY13zMjkCbAc9UsGSix02Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176473>

Hi Mike,

Mike writes:
> I do think that git needs polishing in this way. It was designed by a
> very intelligent programmer... however they can sometimes be the worst
> at user interface design. I think a lot of people are missing out on
> how great git is because of the learning curve, and also the slightly
> odd naming conventions.
>
> "git reset --soft HEAD^" can't be picked up that quickly by a
> beginner, but git uncommit would be obvious! So I have to agree with
> Holger. Good design makes something intuitive. I have used DVD
> recorder / players that are so badly designed that I needed to read
> the instruction manual. Something complicated can be designed to such
> a degree that people rarely have to read a manual, and they can pick
> it up really quickly because it's obvious. If you disagree then you
> might need to learn something about good design because what I say
> isn't opinion it's a fact. Flame away :)

I completely agree with you.  Git's user interface can certainly be
improved -- we have had many many discussions on this topic (like
{1]).  Unfortunately, the way to go about doing it is not to implement
every little suggestion and introduce more inconsistencies;  Git is
very complex, and changing one little thing requires us to think about
how it'll affect everything else.  Yes, it does seem like a daunting
task, but the interface IS improving slowly and steadily.  You can
help by thinking about how a certain new feature will interact with
every component of Git, and participating in UI discussions.

-- Ram

[1]: http://thread.gmane.org/gmane.comp.version-control.git/175061
