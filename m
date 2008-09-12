From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: CGit and repository list
Date: Fri, 12 Sep 2008 19:40:43 +0200
Message-ID: <200809121940.43471.jnareb@gmail.com>
References: <19449377.post@talk.nabble.com> <200809121754.30277.jnareb@gmail.com> <20080912160538.GB10360@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri Sep 12 19:41:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KeCed-00080G-1t
	for gcvg-git-2@gmane.org; Fri, 12 Sep 2008 19:41:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757558AbYILRkv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Sep 2008 13:40:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757559AbYILRku
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Sep 2008 13:40:50 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:35727 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756439AbYILRkt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2008 13:40:49 -0400
Received: by gxk9 with SMTP id 9so19800317gxk.13
        for <git@vger.kernel.org>; Fri, 12 Sep 2008 10:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=bFeFDkCOHPmP3gpV8DQyWQqyz5oG0ZBEVz5ljkENozI=;
        b=ASaNfOqekR7dF9Q45FCWs7QNNWUh3/97CQWEH1WgiRJJbEs9/E1bfRXyP/DyJ5GRs/
         QZmtWIBtXYi2jx+F+KHxWF1NkttW6dUQZGGUOTeUL8aGt8COGvGGye9bmWa018iSH2v1
         N6xWFIDpSufgrl4+pTW4Tmh7Si0Zz40Xyuugw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=A998cTAAn8vsJ+fBZFoYMfVeXDJqQsypUqtfy728oeLuYdOZ+pMkqhkKMqLwuE0VKN
         GRf9EMELHJ6Rth9rb6jR9sxEiTkwWgByBJy5u9EJ1KgJZogq32P8he3OJYT78BJ7pyDq
         6349gwTN2geRjBHlZ9WZqDtrnGWWfmyXuifDs=
Received: by 10.86.33.19 with SMTP id g19mr3445436fgg.13.1221241246587;
        Fri, 12 Sep 2008 10:40:46 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.211.228])
        by mx.google.com with ESMTPS id d4sm13163013fga.5.2008.09.12.10.40.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 12 Sep 2008 10:40:45 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20080912160538.GB10360@machine.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95753>

Dnia pi=B1tek 12. wrze=B6nia 2008 18:05, Petr Baudis napisa=B3:
> On Fri, Sep 12, 2008 at 05:54:29PM +0200, Jakub Narebski wrote:
>>
>> P.S. Could you please gather some statistics to compare the period
>> before and after installing "smart" HTTP server (and after smart
>> clients became widespread).
>=20
> What kind of statistics?

In the simplest case just some averaged system load (perhaps load=20
average from uptime, or from top, or from /proc) before and after.
Perhaps bandwidth used per week or something like that too.

If you have time and interest, CPU load, disk IO, network IO or
network bandwidth used, and average time to serve request (latency)
for fetching via HTTP protocol, for "dumb" and "smart" clients,
perhaps averaged over number of requests.  (I don't know unfortunately=20
how to get such data).

In short: check how "smart" HTTP protocol would improve things.

--=20
Jakub Narebski
Poland
