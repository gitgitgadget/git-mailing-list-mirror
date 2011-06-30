From: Adam Bourg <adam.bourg@gmail.com>
Subject: Git: Using Git in a Web Server environment?
Date: Thu, 30 Jun 2011 13:18:40 -0600
Message-ID: <BANLkTimdSvzsRYxE0sDDAoU-84YRb=z9+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 30 21:22:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QcMoo-0002lh-Jc
	for gcvg-git-2@lo.gmane.org; Thu, 30 Jun 2011 21:22:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753915Ab1F3TW2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jun 2011 15:22:28 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:64509 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753895Ab1F3TWZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2011 15:22:25 -0400
Received: by bwd5 with SMTP id 5so2077201bwd.19
        for <git@vger.kernel.org>; Thu, 30 Jun 2011 12:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=CmlB11uAFo27nZdT9oVA3cfI9igYPkuWJmuhmZoUInc=;
        b=XX1+jh/wvOdnjR2OGKieeuMsPqiNBfZ65jlNCszroD6uQMaPhT/FC0IFU0Dv4vD2i0
         ehr9Gaw5zzsUsGI7H42xnpLJYt7TS6RzJSUb8h0bGSUCjhPAo+WK2xkCwZ3/FskiJcmJ
         usOkZAfevMTcDyvdYd0Pz3wMPc5WNd4gb2jwo=
Received: by 10.204.74.197 with SMTP id v5mr2322201bkj.150.1309461521127; Thu,
 30 Jun 2011 12:18:41 -0700 (PDT)
Received: by 10.205.82.78 with HTTP; Thu, 30 Jun 2011 12:18:40 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176504>

Background: Reading Pro Git, loving GIt. Git is Awesome!

Servers: 3 Windows Server 2008 w/ 3 SQL Server 2008 servers (3 boxes);
each with a instance of Coldfusion 8.
The servers are:
-Production
-Staging/Testing
-Development

What is the proper way to setup my environment?

I want to be able to elevate code through dev, to testing/staging then
to production. I'm thinking the best way is to setup a Git Repository
on Production then pull down to Staging then to Dev, then to each of
our local machines, then push up in the chains when we need to elevate
code to each level.

Is that wise? Are there any hangups or something I should be concerned
with? Should I put my production site on Git?

Thank you!

Adam Bourg
