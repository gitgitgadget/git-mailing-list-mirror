From: "Henning Rogge" <hrogge@gmx.net>
Subject: [mingw port] Problem starting git subcommands
Date: Sun, 8 Jul 2007 20:26:49 +0200
Message-ID: <87eacd830707081126x69b2edb3o9fd89733ff2258f4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 08 20:26:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7bTB-0007OO-J9
	for gcvg-git@gmane.org; Sun, 08 Jul 2007 20:26:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754580AbXGHS0v (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Jul 2007 14:26:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754592AbXGHS0v
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jul 2007 14:26:51 -0400
Received: from wx-out-0506.google.com ([66.249.82.228]:39038 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753606AbXGHS0u (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jul 2007 14:26:50 -0400
Received: by wx-out-0506.google.com with SMTP id h31so643649wxd
        for <git@vger.kernel.org>; Sun, 08 Jul 2007 11:26:49 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=googlemail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=g7mhXd2iDZ0zGKlnHDk8nWGLP67Vwj78EDMDxcC6x5Doy7JbFNtNc3bh3KMQmSIJW1z8FW67IlHu6yrJ6t+miK9HjAyI5qae74NX45t8znNR+Q3gP0ep5wBZZvoq/xu5NlMvUt8A8oCO9cN1CWADw2x/MpkgHJe79RF4rKaQSco=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=SMuBNAGwkfmDQoLzcCZB5ZqvYEdVJ5ffWYJNiKuhf6fhhXbp+XxcnnPek+J7KTw4tOHu22EsQO8DF7bBj8ywM8pIOHLB3AGEf+5kjtnaWTs9ErTU8mEaVcuA5aTjcvoZvP2vjtU88cHsHHyGfxNkaJ3KBCcaEZzWxDMdHODNYqk=
Received: by 10.90.78.9 with SMTP id a9mr1296890agb.1183919209660;
        Sun, 08 Jul 2007 11:26:49 -0700 (PDT)
Received: by 10.90.28.16 with HTTP; Sun, 8 Jul 2007 11:26:49 -0700 (PDT)
Content-Disposition: inline
X-Google-Sender-Auth: d28de939a4173adc
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51902>

I have experimented with GIT on my linux system successfully but one
of my projects has to be done on Windows (neither VMware Workstation
nor Wine can help at the moment) so I got a copy of the mingw port of
GIT (http://lilypond.org/git/binaries/mingw/git-1.5.2.1-1.mingw.exe).

Installation succeeded without a single error but when I tried to run
a few GIT commands I noticed a "bug":

the git.exe command does not recognize any scripted subcommand
(git-clone in my case) !
> C:\Programme\Git>git clone
> git: 'clone' is not a git-command

Do I need another software package ? I tried to install the Mingw
package itself, but it did not help at all.
