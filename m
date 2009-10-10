From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: Git 1.6.5-rc git clone unhandled exception using http protocol
Date: Sun, 11 Oct 2009 00:07:23 +0800
Message-ID: <be6fef0d0910100907t61ea922bqf117e6c025e94ce7@mail.gmail.com>
References: <4ACF7296.3010809@gmail.com>
	 <be6fef0d0910100355v41de0771m30c153f413a46d2e@mail.gmail.com>
	 <4AD09F5E.9090304@gmail.com>
	 <be6fef0d0910100811l325d3df1jdf8d3d9dd51e3385@mail.gmail.com>
	 <4AD0AE84.1070500@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>
To: eduard stefan <eduard.stefan@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 10 18:12:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MweYe-0003ft-Ue
	for gcvg-git-2@lo.gmane.org; Sat, 10 Oct 2009 18:12:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761693AbZJJQIA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Oct 2009 12:08:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757115AbZJJQIA
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Oct 2009 12:08:00 -0400
Received: from mail-iw0-f180.google.com ([209.85.223.180]:40896 "EHLO
	mail-iw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752990AbZJJQIA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Oct 2009 12:08:00 -0400
Received: by iwn10 with SMTP id 10so1649963iwn.4
        for <git@vger.kernel.org>; Sat, 10 Oct 2009 09:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=WEhYfZzYBnBT7LHOiYyoju5QC546Ru9jkR0y9ZsnAoY=;
        b=KSMMJM3sRDHOTC7X0fSQZANDgn8dPdTsHBvWS/WyOop2tpOYY7RRA+VOkIagairtQC
         mdWIkUtAeRISlN2LKfZalpIfxUJEkSTH4ALYzRDgvE51zXmTdRbBoFjlc+Aj+9qNpNBw
         BcTiPlwUjxG6sWFdfXDM9tCuiIe3GgD/JnN5Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=Kl/k0pQDpR8p3XUcccBe+WbNWWKEf+8Q6xc4NpNUmpINivL97OmN3tvxXq9gnxkLdn
         gDjRUCsqwAH1L6IiX9v+C903wULbZNLpBWSsptuUifBRV7xU1Jl6MsvqzYHDvETUtXb/
         jfI1BIIdI5sQmvVh6QUUubIgWMNOcq06BbHCU=
Received: by 10.231.1.22 with SMTP id 22mr7775892ibd.56.1255190843685; Sat, 10 
	Oct 2009 09:07:23 -0700 (PDT)
In-Reply-To: <4AD0AE84.1070500@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129890>

Hi,

On Sat, Oct 10, 2009 at 11:55 PM, eduard stefan <eduard.stefan@gmail.com> wrote:
> I was just trying to point that the URL used is not relevant,
> as long as the protocol used is URL, then it crashes.

ok.

I suspect, as you do, it's got to do with remote-curl.

Could you try this command?

  echo list | git remote-curl http://github.com/loudej/spark.git

On my machine, I get

  @refs/heads/master HEAD
  f192d3de483f2e7f38eebf84c8f1bbc8c4b5f185 refs/heads/gh-pages
  2a0cd31d8706ec2d8cc5d7b49873cc24621b20af refs/heads/installers
  10526926014eb2d89c2b449f1e29f4df7ab620bd refs/heads/master
  7f36b2caf2f01566bd58f9304d6ad5c36ae280ce refs/heads/mono
  80fc2424ebf082265c66bd6e0637c74744742b49 refs/heads/spark-1.1
  62d62d5c183dd22cdf9491999291047add05c722 refs/heads/spike-1.1
  d85abb61563e7f4f372c7e0418da0f20c49baf48 refs/tags/v1.0.39890-RC1
  db9d3380c39284695added69edab46c2ddab2f48 refs/tags/v1.0.39917-RC2
  70c418dd806a4eb7f32fa6fe710c9a5967ddef32 refs/tags/v1.0.39935


-- 
Cheers,
Ray Chuan
