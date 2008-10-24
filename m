From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Zit (v2): the git-based single file content tracker
Date: Fri, 24 Oct 2008 03:43:15 -0700 (PDT)
Message-ID: <m34p32i83f.fsf@localhost.localdomain>
References: <gdok16$vh2$1@ger.gmane.org> <gdqbta$rhe$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 24 12:44:37 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtK9f-0002H0-2E
	for gcvg-git-2@gmane.org; Fri, 24 Oct 2008 12:44:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751352AbYJXKnS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Oct 2008 06:43:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750944AbYJXKnS
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Oct 2008 06:43:18 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:19235 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750808AbYJXKnR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Oct 2008 06:43:17 -0400
Received: by nf-out-0910.google.com with SMTP id d3so328127nfc.21
        for <git@vger.kernel.org>; Fri, 24 Oct 2008 03:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=ia8WFn4UJMW2bv4YKKSBEC2RTt1dyIZQoVKn73QBwew=;
        b=OwCdUIDkTNOiVWdVIPI1OHSecKskii3UgjHLODmU7hIfj8TnvI7CK46Kvcx2pd/hKV
         PC5yIA+H9/jfQioK7QSfuONG92j61y2Llbs8JDCk4tdyakbHlJJGo3NgfNaFAYdoQj99
         VvXj0nlJ45yqqj5A/ywVwa6EPWnOjCJGvVBnA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=w/vb/xO93SB15btBJNJudXsjg1xRMqQvHSoVhv0gG7S2C+AX1X0UQMt/IzZGZQtzLW
         w7jsV+74PPqVVZg3GD/wEBraDrxp6cDiGs5E/CNYPIL8mYE0fGBxn6fNwAuTBWWIEtms
         LoNv6zFxO5xS/0JXCHJFns7/HR/lZY0uyYVJI=
Received: by 10.210.136.10 with SMTP id j10mr2102749ebd.188.1224844996227;
        Fri, 24 Oct 2008 03:43:16 -0700 (PDT)
Received: from localhost.localdomain (abwq207.neoplus.adsl.tpnet.pl [83.8.240.207])
        by mx.google.com with ESMTPS id 5sm17904118eyh.2.2008.10.24.03.43.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 24 Oct 2008 03:43:15 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m9OAkTCo019756;
	Fri, 24 Oct 2008 12:46:30 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m9OAkSbI019753;
	Fri, 24 Oct 2008 12:46:28 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <gdqbta$rhe$1@ger.gmane.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99025>

Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:

> The reworked Zit ( git://git.oblomov.eu/zit ) works by creating
> .file.git/ to track file's history. .file.git/info/excludes is
> initialized to the very strong '*' pattern to ensure that things such
> as git status etc only consider the actually tracked file.
[...]

Could you add it to Git Wiki page:
  http://git.or.cz/gitwiki/InterfacesFrontendsAndTools

I think that the project is interesting enough to be added there
even if it is still in beta, or even alpha, stage.


P.S. Currently I cannot access git.or.cz for some reason (it is
up for everyone else, and even for me on different remote machine).
-- 
Jakub Narebski
Poland
ShadeHawk on #git
