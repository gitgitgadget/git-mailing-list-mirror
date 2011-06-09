From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Git is not scalable with too many refs/*
Date: Thu, 09 Jun 2011 04:18:09 -0700 (PDT)
Message-ID: <m38vtbdzjq.fsf@localhost.localdomain>
References: <BANLkTimnCqaEBVreMhnbRBV3r-r1ZzkFcg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: NAKAMURA Takumi <geek4civic@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 09 13:18:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUdFh-0004JR-Ur
	for gcvg-git-2@lo.gmane.org; Thu, 09 Jun 2011 13:18:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756194Ab1FILSN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2011 07:18:13 -0400
Received: from mail-bw0-f52.google.com ([209.85.214.52]:37478 "EHLO
	mail-bw0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753515Ab1FILSL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2011 07:18:11 -0400
Received: by bwj24 with SMTP id 24so1849692bwj.11
        for <git@vger.kernel.org>; Thu, 09 Jun 2011 04:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:x-authentication-warning:to:cc:subject
         :references:from:date:in-reply-to:message-id:lines:user-agent
         :mime-version:content-type;
        bh=zacgRMZbW1xM7OIBnbKvpo8bK46ovnsYYnqgU4c/U0g=;
        b=nCa962XZFKRmXv2sEYftQh4LYX+iEVTlk+gR4KYSwLOZJjVu8IYXCjiiUXRQt4sc1V
         Pke/RVV20Nro8ctu6WpHVKufZDcpywrjyHe/8k16yscgmzKI2rG+NSMqlSOcXLC0n0Az
         5uq1hbtNgSmRV/JHgHrPM6xNrB8a+g3EFPlEg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=dJwm5DzRbrvS0dgQVPCC/cg5vs/0Jv2ThxtVz90oZpfHMARq8fF0PLsgFenEjXOEDY
         V7P7xlm4703mVJH+NS8X740eLfB2ipAqFAcYb6CEBPlkqH3+0A/Y7wMjx/38svKCV9Tz
         5xZ3wWW4Zw4dKYKI7SgMWBdbmtT8zrz3j5jBk=
Received: by 10.204.139.199 with SMTP id f7mr640266bku.23.1307618290205;
        Thu, 09 Jun 2011 04:18:10 -0700 (PDT)
Received: from localhost.localdomain (abvo166.neoplus.adsl.tpnet.pl. [83.8.212.166])
        by mx.google.com with ESMTPS id a28sm1347724fak.1.2011.06.09.04.18.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 09 Jun 2011 04:18:09 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p59BHfqv031643;
	Thu, 9 Jun 2011 13:17:52 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p59BHUhN031634;
	Thu, 9 Jun 2011 13:17:30 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <BANLkTimnCqaEBVreMhnbRBV3r-r1ZzkFcg@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175516>

NAKAMURA Takumi <geek4civic@gmail.com> writes:

> Hello, Git. It is my 1st post here.
> 
> I have tried tagging each commit as "refs/tags/rXXXXXX" on git-svn
> repo locally. (over 100k refs/tags.)
[...]

That's insane.  You would do much better to mark each commit with
note.  Notes are designed to be scalable.  See e.g. this thread

  [RFD] Proposal for git-svn: storing SVN metadata (git-svn-id) in notes
  http://article.gmane.org/gmane.comp.version-control.git/174657

-- 
Jakub Narebski
Poland
ShadeHawk on #git
