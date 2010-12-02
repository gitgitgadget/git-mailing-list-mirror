From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] git-cherry.txt: Change symbol marks in graph.
Date: Thu, 02 Dec 2010 00:00:13 -0800 (PST)
Message-ID: <m31v604nc0.fsf@localhost.localdomain>
References: <1291267093-29855-1-git-send-email-jari.aalto@cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Thu Dec 02 09:00:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PO45a-0000gt-Dx
	for gcvg-git-2@lo.gmane.org; Thu, 02 Dec 2010 09:00:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754862Ab0LBIAR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Dec 2010 03:00:17 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:42876 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752803Ab0LBIAQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Dec 2010 03:00:16 -0500
Received: by bwz15 with SMTP id 15so6983037bwz.19
        for <git@vger.kernel.org>; Thu, 02 Dec 2010 00:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=9MGOOceh8YeFc7q7UaddxRdJR5C8KUYIk0YPFUawdFw=;
        b=iuql0UEdnQOWQvamFqLbtbWQStToOGQdt1l/mXGNrm1cczigcndf/qbfWqQxbEqGeZ
         QKyFJAZ0P8KV00lVnLBMGB2Uu9oepIOy8I7PL7ZU1BZAoX6NL8dmJdvC0HGSU0XyJ9b4
         6z8y6o1+K1PM7xU1dJ2ewwapc7cPtZtdpFr/s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=EIB6dgqPG61BxS5vAtLTMrDPzgOaU0IZ+kFM/xfjyW/yYMRwO6kZIdzmAfSDOsjkQ/
         E3Uc2rUAQG+HozNAWCmaRUtlN+kfH9RzoqI0+8WparN9gnxoatJ8YXzv7nEhjNmcmQVS
         yHSASfADQn5MxqwurKHSL6gyCrdYk7Z5UkpHE=
Received: by 10.204.84.156 with SMTP id j28mr187296bkl.101.1291276815262;
        Thu, 02 Dec 2010 00:00:15 -0800 (PST)
Received: from localhost.localdomain (abwq166.neoplus.adsl.tpnet.pl [83.8.240.166])
        by mx.google.com with ESMTPS id p34sm95217bkf.15.2010.12.02.00.00.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 02 Dec 2010 00:00:13 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id oB27xi6o014911;
	Thu, 2 Dec 2010 08:59:55 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id oB27xR1m014907;
	Thu, 2 Dec 2010 08:59:27 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1291267093-29855-1-git-send-email-jari.aalto@cante.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162682>

Jari Aalto <jari.aalto@cante.net> writes:

> From: Jari Aalto <jari.aalto@cante.net>
> 
> The common commit were marked with a minus sign (-), but that is
> usually interpreted as something less or substracted. Use natural
> equal sign (=). Commits that are not in upstream were marked with plus
> sign (+) but a question mark (?) is visually a litle more striking
> (erect) in context where all other signs are "flat". It also helps
> visually impared to see difference between (* ... ?) as opposed to
> similar signs (* ... +).

Reading comprehension FAIL.  The graph in question uses '+' and '-' because
that is what 'git cherry' *output( uses ('+' included, '-' excluded).  They
are very natural in git-cherry output (diff-like).

-- 
Jakub Narebski
Poland
ShadeHawk on #git
