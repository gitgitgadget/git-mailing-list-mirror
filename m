From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [ANNOUNCE] Java Git (aka jgit) has switched to 3-clause BSD
Date: Tue, 27 May 2008 02:14:21 -0700 (PDT)
Message-ID: <m3fxs42jjk.fsf@localhost.localdomain>
References: <20080526044640.GB30245@spearce.org>
	<19f34abd0805260113w1341a26bg140d1dbb7438bf46@mail.gmail.com>
	<alpine.DEB.1.00.0805261106470.30431@racer>
	<19f34abd0805260422m6d8c414dy746623ed609440eb@mail.gmail.com>
	<20080526181259.GA17449@foursquare.net>
	<20080526234445.GF30245@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue May 27 11:15:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0vHB-0007qw-Jk
	for gcvg-git-2@gmane.org; Tue, 27 May 2008 11:15:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755108AbYE0JOZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2008 05:14:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755092AbYE0JOZ
	(ORCPT <rfc822;git-outgoing>); Tue, 27 May 2008 05:14:25 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:4849 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755055AbYE0JOZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2008 05:14:25 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1489326fgg.17
        for <git@vger.kernel.org>; Tue, 27 May 2008 02:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=JGZSAcdMGXNOe6MD4zy7MOkkH3/KXFvB4o75gZ/6NP0=;
        b=K0Ly35Z/nYEyjElhPxp6z11avVe9xK2RjP8OuO+szhhX0S9zNiLpfHNckXBdGG9HUuh8HBHpw+t005JXK3FWjOXiZMGfGY//nfdkdqUk449kpVio0F8y74Qg4RLUMMyZ/Bu6qqDfuDCs3OyUPFNU1CRtD6TmtKfsXGG3q007OO0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=kOyDNmxbyt6oWIVIgyYlIPNdXLlqB7N8meU4JwJVrSjmnk2Bl3dilWAcOTWXtZgw9xoI01iS3E1nGYThdy78rSonbaHDWnMCc8SZwhLoOy1eoLBRCikjb+9bTqREgOon4uzaLiOm4eXAOLqMOvXxM1PeAm/Oc6Gft0Klp+APoCE=
Received: by 10.86.90.2 with SMTP id n2mr1453864fgb.51.1211879663339;
        Tue, 27 May 2008 02:14:23 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.251.174])
        by mx.google.com with ESMTPS id l19sm15117766fgb.9.2008.05.27.02.14.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 27 May 2008 02:14:21 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m4R9H4Nq021239;
	Tue, 27 May 2008 11:17:04 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m4R9H3pe021236;
	Tue, 27 May 2008 11:17:03 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20080526234445.GF30245@spearce.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82997>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> $ git log --pretty=format:%ae \
>     bsd jgit org.spearce.jgit org.spearce.jgit.test \
>     | sort | uniq -c | sort -nr

Errr... why bot use git-shortlog?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
