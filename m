From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git push failed over http
Date: Sun, 28 Jun 2009 01:11:55 -0700 (PDT)
Message-ID: <m3y6rcwz5f.fsf@localhost.localdomain>
References: <82ec251f0906280020p71026a81w57018e9af4d39396@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Lynn Lin <lynnos@tong-ji.org>
X-From: git-owner@vger.kernel.org Sun Jun 28 10:12:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MKpUd-00016B-Fh
	for gcvg-git-2@gmane.org; Sun, 28 Jun 2009 10:12:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752216AbZF1IL5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Jun 2009 04:11:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751809AbZF1IL4
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Jun 2009 04:11:56 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:65107 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751785AbZF1ILz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jun 2009 04:11:55 -0400
Received: by bwz9 with SMTP id 9so2719888bwz.37
        for <git@vger.kernel.org>; Sun, 28 Jun 2009 01:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=ohtkbUVYzubpTzm+bHCu9kQjZ3rHa8SizqGYuPGJDhc=;
        b=c9ykqzFUzkbN2OUmRblbut5pY3BtSP4Y/teiPf1pc9q0rFOqgcMnsmwJjrABil90iA
         qFVjumKWFVaUcTM/T6uHuggypholCHtv122RmNpIPeh+Sz8iUnIzLlvSZfNsqWUpj5ec
         qLkbS8+Tl35cpqZJTv5bvL5lZmnaKHTCiHLG0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=Ay+cuDNGFZhhGtkD5bY9FDuGkHBW6PwEqzodWVPRdmvYmY493o9qmR+TDtdlrAKSWH
         uYMQP+I7rKkUc5gUhwSV11UQSgNpDZ4usXO+KdThoyfQ9rQhFgmOJ5ZQcFHg7nGTJFuV
         ZTeBVuwyAcO/U8REaOoYikOO5WOB5Hq0qpATo=
Received: by 10.103.197.14 with SMTP id z14mr3293934mup.1.1246176715863;
        Sun, 28 Jun 2009 01:11:55 -0700 (PDT)
Received: from localhost.localdomain (abvg228.neoplus.adsl.tpnet.pl [83.8.204.228])
        by mx.google.com with ESMTPS id y2sm935608mug.43.2009.06.28.01.11.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 28 Jun 2009 01:11:55 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n5S8HNRl021484;
	Sun, 28 Jun 2009 10:17:24 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n5S8HGHn021476;
	Sun, 28 Jun 2009 10:17:16 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <82ec251f0906280020p71026a81w57018e9af4d39396@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122397>

Lynn Lin <lynnos@tong-ji.org> writes:

>        I setup a git public repo (http) over apache2,however I can't
> push to remote public repository
> 
> $ git push
> error: Cannot access URL http://192.168.1.109/demo.git/, return code 22
> error: failed to push some refs to 'http://192.168.1.109/demo.git'
> 
> Could anyone give some ideas on this problem?

First, you push over https, not http.  Second, you have to setup
WebDAV on server for pushing via http.

Other than that I cannot help, as I never set up git to push via http.
But I would check the documentation ("Git User's Manual" or "Git
Comunity Book" http://book.git-scm.com,... or perhaps best would be
howto/setup-git-server-over-http.txt)

-- 
Jakub Narebski
Poland
ShadeHawk on #git
