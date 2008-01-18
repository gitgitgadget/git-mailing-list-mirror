From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's not in 'master', and likely not to be until 1.5.4
Date: Fri, 18 Jan 2008 03:26:50 -0800 (PST)
Message-ID: <m3tzlbl6he.fsf@roke.D-201>
References: <1200022189-2400-1-git-send-email-mlevedahl@gmail.com>
	<1200022189-2400-2-git-send-email-mlevedahl@gmail.com>
	<7v1w8o4ws0.fsf@gitster.siamese.dyndns.org>
	<30e4a070801111252s4e17b9c4m62adeb9032963e66@mail.gmail.com>
	<7v63xzzszp.fsf@gitster.siamese.dyndns.org>
	<478855B5.9070600@gmail.com>
	<7vbq7ry405.fsf@gitster.siamese.dyndns.org>
	<47885B2C.8020809@gmail.com>
	<7v7iify2wm.fsf@gitster.siamese.dyndns.org>
	<4788BFA8.2030508@gmail.com>
	<7vwsqeubj8.fsf@gitster.siamese.dyndns.org>
	<47891658.3090604@gmail.com>
	<7vbq7qssd7.fsf@gitster.siamese.dyndns.org>
	<47893E1A.5020702@gmail.com>
	<7v4pdislrf.fsf@gitster.siamese.dyndns.org>
	<alpine.LSU.1.00.0801132224540.8333@wbgn129.biozentrum.uni-wuerzburg.de>
	<7vir1xmazm.fsf@gitster.siamese.dyndns.org>
	<7v63xrh3mw.fsf_-_@gitster.siamese.dyndns.org>
	<7vfxwvfmd8.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 18 12:27:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFpNe-0001L0-QZ
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 12:27:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755030AbYARL06 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2008 06:26:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755305AbYARL06
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jan 2008 06:26:58 -0500
Received: from fg-out-1718.google.com ([72.14.220.152]:5746 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750853AbYARL05 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2008 06:26:57 -0500
Received: by fg-out-1718.google.com with SMTP id e21so1005401fga.17
        for <git@vger.kernel.org>; Fri, 18 Jan 2008 03:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        bh=t1DMN2JX3wevFAkw9XJ0arztf15/hCBNT0iHz3cerP0=;
        b=gEJljmlm34zT1huZ8JveYxczqp0Mx+E5CoI0QcI3zAc87lyQlEp0WfSS8+lQ8G/2JF2FlMM2RlV3EQX9gNzvRhT8LUcL4AMn4ogVPeGT1eQz0NetZBMpKcI0HEbubqchEbfDS8/hvUOuIXBC/VleP1CnN/sXRa8Hm9NknnvxS9g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        b=YJMzmDJ/8T+7pNBH1dLgQG09oziNSmoEdnpBLsle4n7asHPVGh6ZOSW+o0WLhpwQeFgvl/zoQUMZKOYZ1sNJebMT5likVjVevYnT4/sAgER/wr3v4zQWB+TMMM4WrD/bE6ZijYf7oS6rLLVPIESPQ31TOVy5HAJQ7CigFRK7lJI=
Received: by 10.82.180.17 with SMTP id c17mr5791261buf.14.1200655611331;
        Fri, 18 Jan 2008 03:26:51 -0800 (PST)
Received: from roke.D-201 ( [83.8.203.217])
        by mx.google.com with ESMTPS id j12sm488675fkf.6.2008.01.18.03.26.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 18 Jan 2008 03:26:50 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id m0IBQdFc031133;
	Fri, 18 Jan 2008 12:26:42 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m0IBQceW031130;
	Fri, 18 Jan 2008 12:26:38 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@fuw.edu.pl using -f
In-Reply-To: <7vfxwvfmd8.fsf_-_@gitster.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71002>

Junio C Hamano <gitster@pobox.com> writes:

> Here is an update to the list I sent earlier.  Topics that I
> thought may deserve attention, discussion and eventual inclusion
> but are not 1.5.4 material.
> 
> I think some of them actually have a slight chance of being
> 1.5.4 material, if interested parties present good enough
> arguments that they are actually good and safe bugfixes.
 
>  * submodule subcommand parser fix for "git submodule add init
>    update" (Imran M Yousuf and me)

Isn't it a bugfix, and shouldn't it for this reason be in 1.5.4?
 
>  * gitweb feed from commit to commitdiff (Florian La Rouche --
>    Jakub seems to be on top of this so I am not worried about it
>    too much).

What need IMHO to be changed is commit message: state stronger
that the only thing that changed is that feed entry refers now
to 'commitdiff' view rather than 'commit' view. I can agree that
it might be better... but I do not use gitweb feeds myself.

Reasonably post 1.5.4

> Again, I am hoping that authors will resend the ones they really
> care about after 1.5.4, as I do not want to take patches early.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
