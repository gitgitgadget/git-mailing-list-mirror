From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Performance issue: initial git clone causes massive repack
Date: Sun, 5 Apr 2009 23:36:19 +0200
Message-ID: <fabb9a1e0904051436i1dc9c1bdhe86a23e470c756f9@mail.gmail.com>
References: <20090404220743.GA869@curie-int> <20090405000536.GA12927@vidovic> 
	<20090405T001239Z@curie.orbis-terrarum.net> <20090405035453.GB12927@vidovic> 
	<20090405070412.GB869@curie-int> <20090405190213.GA12929@vidovic> 
	<alpine.DEB.1.10.0904051419490.6245@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Nicolas Sebrecht <nicolas.s-dev@laposte.net>,
	"Robin H. Johnson" <robbat2@gentoo.org>,
	Git Mailing List <git@vger.kernel.org>
To: david@lang.hm, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 05 23:38:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lqa2a-0005Jy-WB
	for gcvg-git-2@gmane.org; Sun, 05 Apr 2009 23:38:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753983AbZDEVgh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Apr 2009 17:36:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753796AbZDEVgh
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Apr 2009 17:36:37 -0400
Received: from fk-out-0910.google.com ([209.85.128.186]:38851 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753644AbZDEVgh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2009 17:36:37 -0400
Received: by fk-out-0910.google.com with SMTP id 18so753076fkq.5
        for <git@vger.kernel.org>; Sun, 05 Apr 2009 14:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=4LNoeUsdX8ljU/CjmHHVbNUkAjalNU9FMd0GZM4RDKw=;
        b=OSBroDLN0qBbhG4deTDG8OiXT28iVYiJzE4PyfRkthqcD+9y6tB8kN7ZYH4JDQxt3m
         qsn43DadIfcZYXP8WMii4iaIU3+4ZYHPedn4cdlR9P0ia3LL7KBrP7wu1hcFAdrguOIi
         +bC/2DzvStmvIODaypmlq1MW2LYhAI4G52H8E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Grm0GbhFrscws23WblHn2OfLrlmNe8Co6BNw6fk7n1+ygwFQOvvR5XRDmComU0gJhc
         UFmWla89Cb0vv1w328rjVD8kFCmQCrz//oyYMOywgao0LbkreM1VwnbBmNa5AfiAA/kT
         1vKkHuIHnOH9BkqUi/Sfqe3d5whj1BSFlPDuY=
In-Reply-To: <alpine.DEB.1.10.0904051419490.6245@asgard.lang.hm>
Received: by 10.103.92.8 with SMTP id u8mr1650594mul.12.1238967394200; Sun, 05 
	Apr 2009 14:36:34 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115717>

Heya,

On Sun, Apr 5, 2009 at 23:28,  <david@lang.hm> wrote:
> Guys, back off a little on telling the gentoo people to change.

I agree here, we should either say "look, we don't really support big
repositories because [explanation here], unless you [workarounds
here]" OR we should work to improve the support we do have. Of course,
the latter option does not magically create developer time to work on
that, but if we do go that way we should at least tell people that we
are aware of the problems and that it's on the global TODO list (not
necessarily on anyone's personal TODO list though).
Of course, the problem can sometimes be solved by splitting the
repository, but I think it is important to have an official policy
here, do we want Git to support huge repositories, or do we not?

-- 
Cheers,

Sverre Rabbelier
