From: Howard Miller <howard@e-learndesign.co.uk>
Subject: Commited to wrong branch
Date: Tue, 15 Sep 2009 11:31:07 +0100
Message-ID: <26ae428a0909150331q391ed39ak622902d175b46d84@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 15 12:31:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnVJc-0007Ai-MZ
	for gcvg-git-2@lo.gmane.org; Tue, 15 Sep 2009 12:31:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752663AbZIOKbI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2009 06:31:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752614AbZIOKbH
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Sep 2009 06:31:07 -0400
Received: from mail-ew0-f206.google.com ([209.85.219.206]:36496 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752427AbZIOKbF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2009 06:31:05 -0400
Received: by ewy2 with SMTP id 2so312553ewy.17
        for <git@vger.kernel.org>; Tue, 15 Sep 2009 03:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:date
         :x-google-sender-auth:message-id:subject:from:to:content-type;
        bh=SFGWWCLpN0X1HzRV44SpnyrgBHgRFBw43uJ6te5mPU0=;
        b=tk3QUdKG1JHkpnoDjQZgExE/1EzBnpn6u3GKietOfRuIQ/rzRfcNFSW7a3U3y2Fx+n
         7vMxAZXo+DPhBxDEq1/9rI8O6m1gmx5ABJjcPMpBPwfZe5YzQyfSm2Hl6ur/iNAObE4Y
         rW849X4iO1VXR7w+3YaFdwkAB3MqIOaZVWgdM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type;
        b=adhbiKUYFepRM74fp9tdBasgk2RbZiFylrsc0QyelDFDkRBTm8WQNnJD16PqbGv4E3
         7SKGBMemqr7npaU9tM2ZpKzSU3f/YSolKKoaXIuYiLO8wbaOImLbWI8T140gSTsEvxa1
         sDLgIdNPjOIDINbbH7IdNDKRRPWLa9IS2uuWo=
Received: by 10.216.53.8 with SMTP id f8mr1628264wec.171.1253010667792; Tue, 
	15 Sep 2009 03:31:07 -0700 (PDT)
X-Google-Sender-Auth: d60d3693d4bd3856
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128524>

Hi,

I am resurrecting a discussion from a week or two back (been on
holiday).  As follows...

I had made some changes to some files and then done a commit. Only
then did I realise that I had the wrong branch checked out. To make
matters worse I then did a 'git reset HEAD^' which means that I can
now no longer switch branches. I am stuck. I had some advice (thanks!)
but it was not complete. I'd appreciate some more help.

I was advised to do a 'git reflog --branchname--' (I don't
know/understand what this command does) but it doesn't work. I just
get 'usage: git reflog (expire | ...)'

So basically I am no further forward. Just to reiterate I need to...

* remove the commit from my current branch (it tracks a remote so I
would prefer there to be no evidence to confuse other people after I
push)
* add the changes to the (other) branch they should have been added to.
* not loose or break anything.

Any (more) help appreciated.
