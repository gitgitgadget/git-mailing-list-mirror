From: Geoff Russell <geoffrey.russell@gmail.com>
Subject: need advice on usage patterns
Date: Mon, 26 Jul 2010 10:04:31 +0930
Message-ID: <AANLkTi=g2YNQtiH7+xzqWeoOV6p5r+Nwtt2kkCd3u6JN@mail.gmail.com>
Reply-To: geoffrey.russell@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 26 02:34:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdBeZ-0004iO-4E
	for gcvg-git-2@lo.gmane.org; Mon, 26 Jul 2010 02:34:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752658Ab0GZAed (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jul 2010 20:34:33 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:51904 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751319Ab0GZAec (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jul 2010 20:34:32 -0400
Received: by qwh6 with SMTP id 6so4718940qwh.19
        for <git@vger.kernel.org>; Sun, 25 Jul 2010 17:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:reply-to:date
         :message-id:subject:from:to:content-type;
        bh=ZfjT4oya4u0fWRHC5oEAB7NRq1AHGJqCFTnLjCPS33w=;
        b=EDFzcpHyDhESuAVm+rCZxHbSqU3dCyCCQV8sQ74eK24UOGajb8n6qPIBc2K3gMudh0
         j2FHMK9CYNFZJcplviyJyV2hYDAZemCbEnysXRzMUn3YJcEUodv7PuOOTh65Z103UD3F
         O14ju4HiixsD+MvV4s9gkYlk0o0vSU8Wa1Y9c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:date:message-id:subject:from:to:content-type;
        b=v5vVfccMj0HZVuOhH5tIrMXuo93Y9eUM9aBJlrMMgGKHNs/ibhBxXhNPYidteT90lF
         gnTzXc0o1NO8UMA7Y8baiX9+1lAbialv4b/9V9mpZbc3IaULP0m29NIYet3RTIFZPSIG
         gZYGnDCovmmxFreM+7+e5mvsVOWYsQtIfA9Do=
Received: by 10.224.45.77 with SMTP id d13mr5217649qaf.39.1280104471633; Sun, 
	25 Jul 2010 17:34:31 -0700 (PDT)
Received: by 10.229.227.12 with HTTP; Sun, 25 Jul 2010 17:34:31 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151799>

Hi,

I'm after advice on usage patterns.

We are looking to use git to manage our release+patching process.  We
release our
software as a couple of directories (bin+tables).  Mostly we then send updates
to single customers without always testing that the update will work
for all customers.
Other updates apply to everybody.

Our thought is to have a "central" repository with the well tested
programs and branches for
each customer for versions that should not be sent to everybody.  The
developers work on their
own local repositories and push branches to the central one for final
testing prior to distribution.
The most common usage would be to rebase the branches on the latest master.
A developer should be able to just "git pull" and get updates to
branches for all customers.

There are notes on the "git pull" man page about not working on a remote branch
but having a local branch with a different name and merging the remote branch.
Why is this necessary?

Does anyone have comments or advice on alternative ways to manage
this? The remote branch
commands seem rather complex, has anybody written scripts to
simplify the process of interacting with remote branches?

Cheers and thanks,

Geoff Russell
