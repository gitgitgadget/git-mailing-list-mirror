From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: vcs for hefty video and graphics files
Date: Wed, 24 Nov 2010 14:42:11 -0800 (PST)
Message-ID: <m3r5ea4a5y.fsf@localhost.localdomain>
References: <877hg55iyd.fsf@newsguy.com> <icg5ia$5an$1@dough.gmane.org>
	<20101123204149.GA2373@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Philippe Lhoste <PhiLho@GMX.net>, git@vger.kernel.org,
	Harry Putnam <reader@newsguy.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 24 23:42:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLO2f-00063f-Ia
	for gcvg-git-2@lo.gmane.org; Wed, 24 Nov 2010 23:42:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755485Ab0KXWmQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Nov 2010 17:42:16 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:48312 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754541Ab0KXWmP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Nov 2010 17:42:15 -0500
Received: by fxm13 with SMTP id 13so236968fxm.19
        for <git@vger.kernel.org>; Wed, 24 Nov 2010 14:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=vOUE9CR/TAVrmpM6Xtz5b5K5+GU/Bqkz4cK7Xr+CAYQ=;
        b=LKjv7qat0eI0xLAvyp6jhEqk76i1iSci0g7s6wHeqNEicOYvjKtORVT0P7UxXc/Han
         WTZXgkWDeLzFhZSxAkOtQBW6rhw1AorWBOhyGe4YTSTOxSZhVrzBw/r+21qrcwcsdt/8
         Bz69b/mVU2J9G694tS10fxS5ZEi+lSq5JQpBI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=Vwh4VVzBtSnKd59Kk1ZOsAtHP8BDQMjKn8/uT+5vc8occy+wk/JWEGYzx+Fa59HUpY
         rVGdUvMOBnNv3M5jq+15XbPzO0YU2ijtIljjRvf7MQfARRJcS022yuiQhy6NmnMVM7yN
         MNTAFtYMXvQAOsJqJrjmBjJamIjVgUq/zu+a0=
Received: by 10.223.83.4 with SMTP id d4mr4301681fal.59.1290638532824;
        Wed, 24 Nov 2010 14:42:12 -0800 (PST)
Received: from localhost.localdomain (abwq109.neoplus.adsl.tpnet.pl [83.8.240.109])
        by mx.google.com with ESMTPS id n15sm3722fam.12.2010.11.24.14.42.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 24 Nov 2010 14:42:11 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id oAOMfY9g002765;
	Wed, 24 Nov 2010 23:41:44 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id oAOMfDWi002760;
	Wed, 24 Nov 2010 23:41:13 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20101123204149.GA2373@burratino>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162093>

Jonathan Nieder <jrnieder@gmail.com> writes:
> Philippe Lhoste wrote:
> 
> > Some game makers keep track of their (large) binary files, along
> > with the rest of the project (source code). Rarely in isolation.
> > Perforce and PlasticSCM both boast superior support of these files,
> > I won't comment on these allegations (over other VCS), just having
> > no experience here.
> 
> One small thing to add: for this use case, you might like git-annex[1].
> 
> It is a shame no single mailing list to follow up to was mentioned.
> Hopefully the reply will get to Harry, anyway.
> 
> Regards,
> Jonathan
> 
> [1] http://git-annex.branchable.com/

Jonathan, could you add git-annex to "Interfaces, frontends, and tools"
page on git wiki:
  https://git.wiki.kernel.org/index.php/InterfacesFrontendsAndTools

Does git-annex use git-replace?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
