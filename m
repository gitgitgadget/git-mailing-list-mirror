From: Howard Miller <howard@e-learndesign.co.uk>
Subject: Merging non-git releases of a project
Date: Fri, 9 Oct 2009 22:11:19 +0100
Message-ID: <26ae428a0910091411i39a03650o51163f794b984524@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 09 23:14:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwMmk-0008Ft-IP
	for gcvg-git-2@lo.gmane.org; Fri, 09 Oct 2009 23:13:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934270AbZJIVL7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Oct 2009 17:11:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934264AbZJIVL7
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Oct 2009 17:11:59 -0400
Received: from mail-ew0-f208.google.com ([209.85.219.208]:55461 "EHLO
	mail-ew0-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934255AbZJIVL6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Oct 2009 17:11:58 -0400
Received: by ewy4 with SMTP id 4so1001733ewy.37
        for <git@vger.kernel.org>; Fri, 09 Oct 2009 14:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:date
         :x-google-sender-auth:message-id:subject:from:to:content-type;
        bh=A85UNb6hMvS8BF3aCxB7jQ/+rAhzMW625DJiQcBYkDA=;
        b=v65WeyzjXIW4yR8obgj2fHO5haAtOa1o6v189cODl+Nt8wZ2breqD4oCjxx7wkxdFb
         YZxJjEqt5lW4r4UqQVrH82wk+jLBQ04G/LwPkKygijhC2eQsEI9ipvWeijtn8pv7fIl9
         UxHV54pezKPvHbCKxhpjru56JvQsHjQUHGrgg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type;
        b=r+de5GdcFpMM/aWZoc8dyu722FSV0ABfis5mEUw2ePV/RYIfyrlo9priXb0a+WUN3B
         1pF4C+9DTsgfalr1h991lU3DaKiq/aLxfdnD2bh0mIyERUq4EfG9GVgJ4Mqn9/NzkQYA
         udIMQyvr5Uq54ep/0Mbh8np7/G603P4rcNNTg=
Received: by 10.216.90.13 with SMTP id d13mr994323wef.130.1255122679937; Fri, 
	09 Oct 2009 14:11:19 -0700 (PDT)
X-Google-Sender-Auth: e49896664fc2e477
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129842>

Here's my dilemma.... I've used git extensively to track modifications
made to a reasonably large source tree. I do not have access to the
repository for that project, just a given release. I have now acquired
the latest version of that project and I want to 'merge' (not sure
that's the right word in this case) my changes into the new version.
Then I need to carry on using git for further changes. I think it
should be simple but I can't get my head around the best way to do
this.

Any pointers appreciated!
