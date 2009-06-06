From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 17/23] http.c::http_fetch_ref(): use the new http API
Date: Sat, 6 Jun 2009 09:17:24 +0200
Message-ID: <200906060917.25362.jnareb@gmail.com>
References: <20090606000556.9cbf4ac0.rctay89@gmail.com> <m3eity5rtq.fsf@localhost.localdomain> <be6fef0d0906051804t704a802ane4921c56d4577401@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 06 09:17:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCq9p-0005DO-Vi
	for gcvg-git-2@gmane.org; Sat, 06 Jun 2009 09:17:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751177AbZFFHR3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jun 2009 03:17:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750802AbZFFHR2
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jun 2009 03:17:28 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:47118 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750792AbZFFHR1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jun 2009 03:17:27 -0400
Received: by fxm18 with SMTP id 18so2057179fxm.7
        for <git@vger.kernel.org>; Sat, 06 Jun 2009 00:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=LPJvXBnI3hHk8R9EuL9n3OVxHwsXjcHYQKL1nBN5/bs=;
        b=GHXpc3BES0SiyDrw7uFEX8w/WcW122S3T8kFnaGKPREF6Uwcq5iQpiIkSsDuQfbbP/
         YICEjWPZyGyB3+TYbLZjbDJvDf5hKA2Pw0sAuIZvLyCAa2spiuESKYRo4FvFYeB+mvvL
         hOH3E6ZJvs/i0uldTzLa9JZVb2Gi+u38KhwyA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=H8RqMiusOLA9SusZpoJvPgsp+q0rZ5LswbzoL0GIFPUZ5kfIwsJXX5Qxtj4FRMjv3q
         0nq36omLOyqMsZJnnEMGce1udOqJ+x2SqPKW8cgwVDfTk+wD+8ydZskrk1ZRFpYF+tam
         0kHcz1V2ZSHSTmfT6bNZEGX7IvkvYHTwZWD3k=
Received: by 10.86.36.11 with SMTP id j11mr4750803fgj.22.1244272648882;
        Sat, 06 Jun 2009 00:17:28 -0700 (PDT)
Received: from ?192.168.1.13? (abwo21.neoplus.adsl.tpnet.pl [83.8.238.21])
        by mx.google.com with ESMTPS id 12sm1581006fgg.5.2009.06.06.00.17.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 06 Jun 2009 00:17:28 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <be6fef0d0906051804t704a802ane4921c56d4577401@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120875>

On Sat, 6 Jun 2009, Tay Ray Chuan wrote:
> On Sat, Jun 6, 2009 at 4:50 AM, Jakub Narebski<jnareb@gmail.com> wrote:

[...]

> > Perhaps this and previous patch should be squashed?
> 
> Why should this and patch #16 (for get_refs_via_curl()) be squashed?
> Are you perhaps suggesting that all the use-the-new-http-API patches
> should be squashed?

I'm sorry this was before I noticed that there are a few more patches
which are about using newly introduced API. Please disregard this part
of message.

-- 
Jakub Narebski
Poland
