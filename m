From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Multiple user questions
Date: Fri, 23 May 2008 18:30:43 -0700 (PDT)
Message-ID: <m3zlqg32w9.fsf@localhost.localdomain>
References: <200805231327.41216.devurandom@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dennis Schridde <devurandom@gmx.net>
X-From: git-owner@vger.kernel.org Sat May 24 03:31:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jzibo-0003pw-CP
	for gcvg-git-2@gmane.org; Sat, 24 May 2008 03:31:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754959AbYEXBas (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2008 21:30:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754932AbYEXBas
	(ORCPT <rfc822;git-outgoing>); Fri, 23 May 2008 21:30:48 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:6967 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754632AbYEXBar (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2008 21:30:47 -0400
Received: by nf-out-0910.google.com with SMTP id d3so459724nfc.21
        for <git@vger.kernel.org>; Fri, 23 May 2008 18:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=SuL3hi7UZlMyg6V/xA6FCU9bKfqKoTeOOi5CRFMMLQg=;
        b=ZfoBSsbDzbSJTmNa7tLRx6cB3u42WkrDu/MY5WFpXxkmAXBb2Im7lxCzmRcS7ApHszbI9qYTyE+gZOFuxNDEuh8bY/ZApnlqI5VUGAysIk3kKlqT0pnoe25fGpMxH6LxUzb1WHHGfKagzstrDQ27ngCwYMK9Z8Dvrn8+0EkpW5o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=A6cQ1Zggn1gUpdgXipPhq9ZdRodEU14qP/MumYl9H+/DV/7snDm6lS4CWAfcedPOq2g9aD5rHSPVmwX+kFKqg+V81MBetOLALsy7J05RGX31nWvHUTsIvFXe/vPG9a/zZ5OXHmI+L1aqCERwAp3EFNC0Rkex9U//kkh4o7gGmIg=
Received: by 10.210.120.7 with SMTP id s7mr1696386ebc.76.1211592644753;
        Fri, 23 May 2008 18:30:44 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.211.36])
        by mx.google.com with ESMTPS id h1sm5774822nfh.19.2008.05.23.18.30.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 23 May 2008 18:30:43 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m4O1UEhG032554;
	Sat, 24 May 2008 03:30:24 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m4O1TwDx032543;
	Sat, 24 May 2008 03:29:58 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <200805231327.41216.devurandom@gmx.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82787>

Dennis Schridde <devurandom@gmx.net> writes:

> 1) Can I somehow make send-email just send one email with multiple patches 
> attached?

This way you cannot reply to each patch separately in an easy way.
Thats what "[PATCH n/m]" and threading/chaining to cover letter is
for.

> 2) Can I make format-patch include the full commit message, date, author, 
> stats in the patches? (To mimic what git-show would show me.)
> Will this be sent via send-email, too?

Errr... git-format-patch output _does_ include full commit message,
author, author date and diffstat.

git-send-email can send fir-format-patch patches (and usually is used
in such way).

> 4) Can I make format-patch output one deletion and one insertion for a 
> complete rewrite of a function, instead of multiple deletes/inserts?

Try git-format-patch with -B option, or -B<num>.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
