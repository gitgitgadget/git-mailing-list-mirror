From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [GSoC update] git-remote-svn: Week 5
Date: Mon, 31 May 2010 17:52:01 +0200
Message-ID: <AANLkTikndHUAYiTm9S3l8ZK_rqQ7jXTvpD3r6IobYnlY@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 31 17:59:27 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJ7Of-0004xl-Eu
	for gcvg-git-2@lo.gmane.org; Mon, 31 May 2010 17:59:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756854Ab0EaP7I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 May 2010 11:59:08 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:40056 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756061Ab0EaP7G (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 May 2010 11:59:06 -0400
Received: by vws9 with SMTP id 9so909375vws.19
        for <git@vger.kernel.org>; Mon, 31 May 2010 08:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:from:date
         :message-id:subject:to:cc:content-type;
        bh=+OTQ0wNUor5HZP51czjL82nvC5yMOTam9rAVyHAx5Tc=;
        b=WyZgui+oI4wRGzqeTYgWdkS52oeYIY56Xa4zdetl86oJwlEdz4uDsrUI5cNYv1ynsP
         ROBH/PxJJGgEyb9UyGiwWkJClIejrAr2hADcTJLCc2FtLoVsFL/Fxsk5XuVAoI0XN9X2
         W2+h/AJqAOmRfPozbhOhfEVS4O9V7ZXRVq1gY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        b=ZTr1dKRDq1pwOhJcdIadNU2PGaoJnYE8TK07GTEaP6Y3cXLan9lLTBlIfLovSSdbxF
         JgXbY8Zk5E7pyiNEcX2hwGMFamdoyE+wY/N1kOTENDnHJOFyUYdjA2ak9ZXDcgKtT4xt
         HBiteMkI1VWgk7veb35J5rUbx152mrxQyTCEs=
Received: by 10.224.44.102 with SMTP id z38mr1778046qae.32.1275321141161; Mon, 
	31 May 2010 08:52:21 -0700 (PDT)
Received: by 10.229.50.3 with HTTP; Mon, 31 May 2010 08:52:01 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148047>

Hi,

Despite trying not to, I ended up spending yet another week on David's
exporter: most of the work went into clean up for merging into
git.git. Thanks to Jonathan's thorough review, it should be ready for
inclusion now- I'll post a series in the first half of this week. In
the meantime, I've also started working on an SVN client that uses the
libsvn ra API to fetch revision history over the network- hopefully
I'll have something to show within a few days. Although there's a
steady work output, I think I'm lagging a little bit and need to work
more efficiently if I want all my work to be merged by the end of
summer.

-- Ram
