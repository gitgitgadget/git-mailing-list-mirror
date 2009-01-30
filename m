From: Mike Ralphson <mike.ralphson@gmail.com>
Subject: Re: [ANNOUNCE] EasyGit (eg) 0.97
Date: Fri, 30 Jan 2009 16:59:26 +0000
Message-ID: <e2b179460901300859r438a4230hc990305688b4f29e@mail.gmail.com>
References: <51419b2c0901300842rb993454u7e8b6d1032c12ac8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 30 18:00:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSwje-0008JP-Mg
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 18:00:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752394AbZA3Q73 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2009 11:59:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752021AbZA3Q73
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 11:59:29 -0500
Received: from mail-qy0-f11.google.com ([209.85.221.11]:48420 "EHLO
	mail-qy0-f11.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751346AbZA3Q72 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jan 2009 11:59:28 -0500
Received: by qyk4 with SMTP id 4so711452qyk.13
        for <git@vger.kernel.org>; Fri, 30 Jan 2009 08:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ordKM9S+21Yjq/s5foAEuJhEKFVW+jk86bIreAX45MI=;
        b=GffBT21NX1uM4V5k+8T63xWGWJxe4jMA+wCclBnh/gwxL/T7Od8xDtOL9PVBKcDFYA
         NMUBTB7N2q5aNP5SrROlClfno/RiwXyPEGX4htOPgFGXw60TBv7ZL5yD9QAp468nfzjI
         L9GPgW1r0acEAgNUzEaBXZQ86Y6ElxCAVBjFk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=uxAIbg7x6q96SH8R3/qRnr9rMza7R9G/9wgIdZWFgUT9RaFdJ/n4zxse1khBb5I+8i
         pO+vssIyvV4MlmP9MGo1XUTATw6Jt+Zbq7ogFL14BFMT184SRLZWzKGneapJ5h59ImHP
         96RVxG/j10qy0dMCWor/3TybA7p3dpeN9k0Eo=
Received: by 10.214.216.9 with SMTP id o9mr2509092qag.202.1233334766619; Fri, 
	30 Jan 2009 08:59:26 -0800 (PST)
In-Reply-To: <51419b2c0901300842rb993454u7e8b6d1032c12ac8@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107850>

2009/1/30 Elijah Newren <newren@gmail.com>:
> [5] The bug I can only occasionally trigger and which I don't know the
> cause of yet: when exiting from eg log the terminal settings sometimes
> are messed up (with echo off and such), requiring a "reset" to get the
> terminal back to normal.

Are you sure that isn't this bug in git.git ?

pager: do wait_for_pager on signal death
http://article.gmane.org/gmane.comp.version-control.git/106728

Mike
