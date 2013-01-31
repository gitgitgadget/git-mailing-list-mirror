From: Scott Yan <scottyan19@gmail.com>
Subject: How to identify the users?
Date: Thu, 31 Jan 2013 13:52:32 +0800
Message-ID: <CACkbei+Jby13B7rsEb3iLQM2ZSFDgrkgvrYC5M7u4yatppvLxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 31 06:53:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0n4y-0006vP-IB
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jan 2013 06:52:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751628Ab3AaFwf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2013 00:52:35 -0500
Received: from mail-lb0-f180.google.com ([209.85.217.180]:39099 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750921Ab3AaFwe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2013 00:52:34 -0500
Received: by mail-lb0-f180.google.com with SMTP id q12so3019021lbc.11
        for <git@vger.kernel.org>; Wed, 30 Jan 2013 21:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:date:message-id:subject:from:to
         :content-type;
        bh=Xkx1NReGCv+kNR4ehDT3GiWct5WxKvTXiHUl6jSAUX4=;
        b=Qui5GDT6qoSvhzvOBNPhO7OSkcBztcRHwzs96UDF8Ykyw7vJXyN8KVwLJlTun3ISZz
         yjnpntMlY9N8odeeMjj+ql5DmDLm9nIFdULxWpc5upIvSviErN7Y9UtF+eB4LjkKbUtJ
         XwXTPM1IujXznn6WtvSUIp2L2waeZWxIueRh047bDG930d09Ov74TSnKQi5TT0+mqzK1
         YMHvGO/FHXJK3nL6EL9KhkvUlWII3QW25H51xdxD4+vH+p0VBgFReZC0VX/ID57lr3G2
         81XKL/X1JF92A/GEHdWK36Y4HUaYxcltl1rbWGHyJBvaPBxkrptaGT/lCCntlFjdSfP6
         ZQFg==
X-Received: by 10.152.136.20 with SMTP id pw20mr6742998lab.16.1359611552613;
 Wed, 30 Jan 2013 21:52:32 -0800 (PST)
Received: by 10.112.13.207 with HTTP; Wed, 30 Jan 2013 21:52:32 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215092>

Hello everyone:

The user info of git client (user name and email) is set by the users
themselves, so , how to avoid userA pretend to be userB?

Git server could authentication the user, but it do nothing about the
user info of commit message.

For example:
There are 20 people of my team, and everyone can push to the public
repository(git server),
If I found some backdoor code in my project, and the commit record
shows it was committed by userA, so I ask userA: why do you do this?
but he told me: no, this is not my code, I have never committed such
thing.  ----and yes, everyone could change his user info to userA very
easily .

so... what should I do to avoid such situations?
Thanks!
