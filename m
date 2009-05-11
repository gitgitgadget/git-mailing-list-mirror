From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: merging multiple commit into one?
Date: Mon, 11 May 2009 06:50:15 -0700 (PDT)
Message-ID: <m38wl3n3zj.fsf@localhost.localdomain>
References: <1de9d39c0905110621p6858bca8y8bb036a167754672@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: jean-luc malet <jeanluc.malet@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 11 15:50:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3Vti-0003UX-HF
	for gcvg-git-2@gmane.org; Mon, 11 May 2009 15:50:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753030AbZEKNuT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2009 09:50:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752294AbZEKNuS
	(ORCPT <rfc822;git-outgoing>); Mon, 11 May 2009 09:50:18 -0400
Received: from rv-out-0506.google.com ([209.85.198.224]:30078 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752263AbZEKNuP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 May 2009 09:50:15 -0400
Received: by rv-out-0506.google.com with SMTP id f9so2158581rvb.1
        for <git@vger.kernel.org>; Mon, 11 May 2009 06:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=4X+1GB4fy6Wk3QxKLJdjkEEBlPRtxUZS7VYPPp01rh4=;
        b=AnsbWz10DNZo541KzgdbMESv6978A6Zyej1+eFKJlS3SSEZh35R270Zm1vt34+Gbe9
         AVu0QReVotlZC8GnJt+R/rtwuePWvkvRLKMyD+2ZC3tM/vktC6iCU84LAOAM2nDRwXB4
         63OYG1pL4YBpD8sZWBj5eOQFtAwmbyeGyztSc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=u6hh+H20astTA4mrUvLwRs9we6gXJ8Yp2tWGRkDd3pxaPsQUfT+DNJXlyBuaStU1/Z
         PwH1EnMLYvEUJ4FmGsRaw5FDbTPpEeM44WiXkmRgjBuj85iC3DmnhgS6SJ9K1x5VFJRS
         I462J8N84VkmFv7WMjVLlbCwNpEms/mIp8Dcs=
Received: by 10.114.106.13 with SMTP id e13mr5640149wac.52.1242049816408;
        Mon, 11 May 2009 06:50:16 -0700 (PDT)
Received: from localhost.localdomain (absh130.neoplus.adsl.tpnet.pl [83.8.127.130])
        by mx.google.com with ESMTPS id m26sm5158392pof.0.2009.05.11.06.50.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 11 May 2009 06:50:15 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n4BDo9UU008395;
	Mon, 11 May 2009 15:50:11 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n4BDo8xw008392;
	Mon, 11 May 2009 15:50:08 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1de9d39c0905110621p6858bca8y8bb036a167754672@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118798>

jean-luc malet <jeanluc.malet@gmail.com> writes:

> Hi,
> I often commit "useless" code, for example before going into weekend
> or for saving some state during a dev process
> often thoses commit are simply useless and the commit message looks
> like "COMPILE ERROR - temporary save .... "
> at the end I have LOT of theses commits that are useless and I want to
> save some space/time/tree complexity merge multiple sequential commits
> (without branch) into one
> is it possible?

It is possible; one solution would be to use "git rebase --interactive"
and its 'squash' command...

> according to my knowledge of git, removing the commit and rewriting
> the last commit log so that it better reflect the modification will do
> the job but I'm not sure git allow it...

...but you can simply pick up where you saved snapshot by using "git
commit --amend" (or doing soft or mixed reset to previous commit
before comitting changes).

-- 
Jakub Narebski
Poland
ShadeHawk on #git
