From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [TopGit PATCH] tg-graph: print dependency graph like git log 
	--graph
Date: Tue, 19 May 2009 13:48:01 +0200
Message-ID: <36ca99e90905190448k64ee18afw8abc49bd90ecb58f@mail.gmail.com>
References: <1242711875-25666-1-git-send-email-bert.wesarg@googlemail.com>
	 <20090519102742.GA28702@noris.de>
	 <36ca99e90905190337y63aeb98ag59ff37688f75ba96@mail.gmail.com>
	 <20090519110800.GB28702@noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org,
	martin f krafft <madduck@debian.org>,
	Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>,
	Adam Simpkins <adam@adamsimpkins.net>
To: Michael Radziej <mir@noris.de>
X-From: git-owner@vger.kernel.org Tue May 19 13:48:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6Nno-0006xV-UY
	for gcvg-git-2@gmane.org; Tue, 19 May 2009 13:48:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752116AbZESLsE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2009 07:48:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752060AbZESLsD
	(ORCPT <rfc822;git-outgoing>); Tue, 19 May 2009 07:48:03 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:56980 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750849AbZESLsC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2009 07:48:02 -0400
Received: by fxm2 with SMTP id 2so3812822fxm.37
        for <git@vger.kernel.org>; Tue, 19 May 2009 04:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=pKFrHeBkrn6IkOZVjR+rUg8yxuDR8q3OTxHqn7luhF0=;
        b=rbitOSyzP6oimc3lndlFoy/63PMVuFlGiMEO6Se2noHVfxuPj9Ia/eBdoP7xx2zF+Q
         Zp7pmfYfQ3T5Aqdmh8kNXavo2R5IbesQOd/dco3+VeFlzwZtecZp3JPl5nwXiSeScwJc
         Fgw4SlNy43NfHv8sINXH2+Xm/cHNrC/7qasMQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=II1aANjMOLpPSN/FtEvT1qkPQfoBBs37kIdMjPQgVs7AIpnJ9y3B4IpD+hbIiMuw1G
         jJktLcRzAYb49ei0+D3CWRISGlXdHH7+tWUlt2I2mJm2Dd5n4h3jaQYbe5vqRkYx2A4S
         0WwDoClO3dn724BoSUFd3pJtWKXbNogmU/pKg=
Received: by 10.204.67.66 with SMTP id q2mr7898169bki.166.1242733681790; Tue, 
	19 May 2009 04:48:01 -0700 (PDT)
In-Reply-To: <20090519110800.GB28702@noris.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119520>

On Tue, May 19, 2009 at 13:08, Michael Radziej <mir@noris.de> wrote:
> On Tue, May 19, Bert Wesarg wrote:
>
>> No, it works here. Which version of graphviz do you have?
>
> I tried two versions on debian:
>
> 2.8-3+etch1 (debian etch)
> 2.20.2-3~bpo40+1 (debian etch-backports)
>
> I also tried it on a different host running Ubuntu with
> 2.16-3ubuntu2
>
> Which one did you use?
The 2.20.2 one.

And you see the error with all 3?

Can you send the output from 'tg summary --graphviz' too?

Bert
>
> Michael
