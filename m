From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 1/2] fix typo in Documentation
Date: Wed, 04 Feb 2009 01:26:09 -0800 (PST)
Message-ID: <m38womwo2b.fsf@localhost.localdomain>
References: <1233781241-721-1-git-send-email-guanqun.lu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Guanqun Lu <guanqun.lu@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 04 10:27:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUe2m-0006wT-0j
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 10:27:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752144AbZBDJ0O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 04:26:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752061AbZBDJ0N
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 04:26:13 -0500
Received: from fg-out-1718.google.com ([72.14.220.157]:60961 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751698AbZBDJ0L (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 04:26:11 -0500
Received: by fg-out-1718.google.com with SMTP id 16so1157697fgg.17
        for <git@vger.kernel.org>; Wed, 04 Feb 2009 01:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=atkBEyIBfAPfHh/Dqb2VrHufteIzgciyiGZAZDbd3KM=;
        b=EkazYSnNB43LJa7pLe0a3ItR+twPb7pdkgfOKt+qAjCuj9ABIlhzjRxqJo7GV9ijmT
         8yoVfrM298RM5PG3OTVXePmWnQbQUIygBWGwFUU9QSo5yd9xh6fiflq2/bOBWazIDpBE
         SHhgpxBnlDUjO1JIiFYnIdzfRovDDcsUTNr4w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=c+QdRNO3X3RUjR2OaoeZkgjM9ec5QUt8VDdKg0BHFmpEgecf/12/3JcRB0FPyTS4q7
         mqDJT7RrymLOOqCjOb0d0r82Vuc2D9KJpLGRXkFFK9mAoX4rGedht+PGL2GChDeHsEZa
         r2+Q56x18dYAS68TnRwryDhoyvdpo3vHtSYLY=
Received: by 10.86.97.7 with SMTP id u7mr1701041fgb.34.1233739570059;
        Wed, 04 Feb 2009 01:26:10 -0800 (PST)
Received: from localhost.localdomain (abvm245.neoplus.adsl.tpnet.pl [83.8.210.245])
        by mx.google.com with ESMTPS id d6sm6397079fga.59.2009.02.04.01.26.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 04 Feb 2009 01:26:09 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n149Q6u2029880;
	Wed, 4 Feb 2009 10:26:06 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n149Q4Lf029876;
	Wed, 4 Feb 2009 10:26:04 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1233781241-721-1-git-send-email-guanqun.lu@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108324>

Guanqun Lu <guanqun.lu@gmail.com> writes:

> Signed-off-by: Guanqun Lu <guanqun.lu@gmail.com>
> ---
>  Documentation/technical/api-strbuf.txt |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Minor nit: I would add _where_ did you fix typy, i.e. instead of just
  fix typo in Documentation
I'd use
  fix typo in strbuf API documentation

-- 
Jakub Narebski
Poland
ShadeHawk on #git
