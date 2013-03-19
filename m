From: Jakub Suder <jakub.suder@gmail.com>
Subject: git-code-review
Date: Tue, 19 Mar 2013 21:22:35 +0100
Message-ID: <CAAgkN4eosm7MK0A7NPCHAmSCFt3w=AuqbZTfyjT-v=YmvkyaKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 19 21:23:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UI33o-0002Q6-4N
	for gcvg-git-2@plane.gmane.org; Tue, 19 Mar 2013 21:23:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757345Ab3CSUWh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Mar 2013 16:22:37 -0400
Received: from mail-ob0-f179.google.com ([209.85.214.179]:60223 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754055Ab3CSUWg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Mar 2013 16:22:36 -0400
Received: by mail-ob0-f179.google.com with SMTP id un3so902687obb.10
        for <git@vger.kernel.org>; Tue, 19 Mar 2013 13:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:date:message-id:subject:from:to
         :content-type;
        bh=h1iZPGPO/4nzO33VfWEbbWeHpSJHXH+NBEj7VgzgjbU=;
        b=qmX4M2cOkKy3jqZ3ZqH0eBsBpFRI5+klC7wRk/vLTx0a3hsop1cDHWT4CR6KIipCVN
         MCKtdoL6+zKEHRzqCPTiaq0hnGia8gxyjdq9AkcT73Ifw+YOwuVPtNszJ4rrC9duSSjK
         EbFhAM0YR07VWRHSWsny8MBJaDscdUHjq8m4bNdgDBHfl4eyPhwXg7kMLY60uCk1kw2d
         8meyedTzSDHby5jbyBwl9b2EaMGFQRnfR/kO+Hm1sKgD/cwrABbEqz4w1tDzU9dfdhXV
         IMFNWtEHj+XjszySB0EGNhqcropsb1lh3CxG4kgralpoFsWepDFQpfI6RiUxxUMyTkMS
         vtfg==
X-Received: by 10.182.217.10 with SMTP id ou10mr2413035obc.30.1363724555945;
 Tue, 19 Mar 2013 13:22:35 -0700 (PDT)
Received: by 10.76.33.198 with HTTP; Tue, 19 Mar 2013 13:22:35 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218553>

Hi,

I thought someone might be interested here - I wrote a small thingie
in Bash to help me with daily code reviews in my project using git and
optionally GitHub. It basically just creates a mirror of
.git/refs/remotes in .git/review, except it's only updated when you
run the tool, so you can use it to keep track of what was already
reviewed and what wasn't, and review e.g. commits from the last day
every morning (and still be able to run git pull/fetch whenever you
need).

Here's the link: https://github.com/jsuder/git-code-review

--
Kuba Suder
