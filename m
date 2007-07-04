From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Usability of git-update-ref <headname>
Date: Wed, 4 Jul 2007 14:08:46 +1200
Message-ID: <46a038f90707031908x3fb2eb59ob0a57a33777363fb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 04 04:08:57 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5uIW-0004F3-Vi
	for gcvg-git@gmane.org; Wed, 04 Jul 2007 04:08:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753238AbXGDCIs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Jul 2007 22:08:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753198AbXGDCIs
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jul 2007 22:08:48 -0400
Received: from wx-out-0506.google.com ([66.249.82.230]:32745 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751465AbXGDCIr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2007 22:08:47 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1960142wxd
        for <git@vger.kernel.org>; Tue, 03 Jul 2007 19:08:46 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=mecnTUfMfLmNPRPtrcVievTTci1ZKTuP/eTIc7YJ2XN7Xi6mK5VYLufIg3jgu4YEhbHIQpbkUb7Qdbja7bgzDVuuMBE+ZpNcgGYNebqBFHjnNEeQ2Q0K8ca61SUtH0XAX/72FbFkziSKSWnBmW4xx4fOGjPfTae5MAdjSql0nuY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Lkix/QcgKqBSkeFAvl4Z+qDw8BNzLLNL9XAP87nzEySnmqFn9cd423QwrMAj5boBeUQs1R9G0t5kYM4edELXgb4S/ud9OI47VB32Dm+vGvDFlplA5GwcE9Nm2+JxPNJXRSEvzskzFiFR2u0dOyjZPE3b1p892dDwPTNni36zkw0=
Received: by 10.90.118.8 with SMTP id q8mr6837088agc.1183514926764;
        Tue, 03 Jul 2007 19:08:46 -0700 (PDT)
Received: by 10.90.52.9 with HTTP; Tue, 3 Jul 2007 19:08:46 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51558>

A few times now I've done the following

  # I think I'm on master, but I'm acually on maint
  git-branch foo-feature
  git-checkout foo-feature

  # realise I've branched in the wring place
  git-update-ref foo-feature master

And from that point, all sorts of things go weird, because I should have said

  git-update-ref refs/heads/foo-feature master

to fix it up I have to manually rm .git/foo-feature -- and I can't see
a way to remove a ref with git-update-ref, so if I was using packed
refs I'd be in trouble ;-)

Am I using the wrong command? I'd be happy to remove the bogus head
and create a new one, but I don't think we have git-rm-ref.



m
