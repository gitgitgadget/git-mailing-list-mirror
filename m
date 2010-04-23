From: Dan Savilonis <djs@n-cube.org>
Subject: core.whitespace blank-at-eof on by default?
Date: Fri, 23 Apr 2010 10:58:48 -0400
Message-ID: <u2k325c62f61004230758xc5dbd87dza2515fac8e2e505b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 23 16:59:18 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5KLd-0001ES-L2
	for gcvg-git-2@lo.gmane.org; Fri, 23 Apr 2010 16:59:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754900Ab0DWO7M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Apr 2010 10:59:12 -0400
Received: from mail-iw0-f182.google.com ([209.85.223.182]:52175 "EHLO
	mail-iw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752819Ab0DWO7J (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Apr 2010 10:59:09 -0400
Received: by iwn12 with SMTP id 12so94774iwn.15
        for <git@vger.kernel.org>; Fri, 23 Apr 2010 07:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:sender:received:from:date
         :x-google-sender-auth:message-id:subject:to:content-type;
        bh=OqBeBUQtvBZVjjM2okXGWJsRn+CReH8GRjLHayaMjuI=;
        b=L+kZ21IsmC3ZTStJ3OEhXnZUXKfFCFkPsuFVJLh4cztcPypVlHp5ScP1S0Kbd4iMvD
         aK6qW5dAoVfZK9CBR46bGREiYiE36bbluaCSwk6wEUSpwcpE47pZ6mo1KHaEEo5ji/l2
         SAhYpQuPdw3vHv9NebMH8p86TYJgWghYKV/g8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:from:date:x-google-sender-auth:message-id
         :subject:to:content-type;
        b=n45h11lu+TINCoHBuNJbbOpxnuAsPH6XQt46gw8pGUrj2T+1eMKmYiPgOfhlNRu3HW
         XlO7a6wuZXpfc3f6Zwk3c8mW+d/Okxh62A5VfuY5zjt4AhQHoQcWx2limcQke+hRwNO2
         ZDJ3uxw2QqJ31kDsmQu96MJnmjhIjASzUgkiI=
Received: by 10.231.144.69 with SMTP id y5mr38176ibu.46.1272034748455; Fri, 23 
	Apr 2010 07:59:08 -0700 (PDT)
Received: by 10.231.33.76 with HTTP; Fri, 23 Apr 2010 07:58:48 -0700 (PDT)
X-Google-Sender-Auth: 317168619823c11b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145620>

I noticed the blank-at-eof whitespace error is on by default after
77b15bb. As a result, correcting a C file with no blank line at EOF is
marked as a whitespace error, even though the C standard requires
this.

What is the intent of this rule? To prevent extra blank lines at EOF,
or any at all? Would it make more sense to only warn only one the
addition of 2+ blank lines or when a blank line is already present at
EOF?

Dan
