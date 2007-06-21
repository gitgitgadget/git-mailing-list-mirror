From: "Carlos Rica" <jasampler@gmail.com>
Subject: Little fix and suggestion for the git tutorial
Date: Thu, 21 Jun 2007 18:45:01 +0200
Message-ID: <1b46aba20706210945h49139cc2y69d2de972f014189@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "J. Bruce Fields" <bfields@fieldses.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 21 18:45:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1PmM-0001ww-6t
	for gcvg-git@gmane.org; Thu, 21 Jun 2007 18:45:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753900AbXFUQpE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Jun 2007 12:45:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753739AbXFUQpE
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jun 2007 12:45:04 -0400
Received: from wa-out-1112.google.com ([209.85.146.182]:19137 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753537AbXFUQpC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jun 2007 12:45:02 -0400
Received: by wa-out-1112.google.com with SMTP id v27so394834wah
        for <git@vger.kernel.org>; Thu, 21 Jun 2007 09:45:01 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=GR/pX03xv0PVAduJ89217gUGzRlst6wHdXmBBmn05xWLvMEdsQSIHNQ8hngQ2UKOI2ht3eak5hk9FQ1pyJiq6kz9YbM6JAzP9fAGQ01wi0xW2B9ZN1YsnTlu3xnuBcEe1PTcSCf9XBGn7xPeCn0cmGCXqAAnCg8/MbUKJ9NGyy8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Q63hiWUfofeAdyQs30bmMEw+XW2z15HZSh7koAXP8dy6Y4VRqSBtS9+vutbWCRXG2gVsEq6krH6lI0RmdyndZpOMgnVdriYmpTUq5XEFcltKQfmA1Y8d1gM6ekQFT9FemdTzB81PUkMokF+SG4kL4XqL9+d+jYQOiHwME6AUtZ4=
Received: by 10.114.177.1 with SMTP id z1mr1822242wae.1182444301520;
        Thu, 21 Jun 2007 09:45:01 -0700 (PDT)
Received: by 10.114.61.17 with HTTP; Thu, 21 Jun 2007 09:45:01 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50641>

Sorry for not sending a patch, I was following the tutorial and found
this, in the section "Using git for collaboration":

 307 With this, you can perform the first operation alone using the
 308 "git fetch" command without merging them with her own branch,
 309 using:

I think that "you" should be replaced with "she".

I have a suggestion also that I don't know how to fix. The text in
that section seems to say something like you need to add a "remote"
alias to be able to run fetch for retrieving without merging:

...[remote add <alias>]...

 307 With this, you can perform the first operation alone using the
 308 "git fetch" command without merging them with her own branch,
 309 using:

....[fetch <alias>]...

 315 Unlike the longhand form, when Alice fetches from Bob using a
 316 remote repository shorthand set up with `git remote`, what was
 317 fetched is stored in a remote tracking branch, in this case
 318 `bob/master`.  So after this:

I'm not sure, but I think that you could use fetch without the need of
an alias. I think that here it is trying to avoid more advanced
explanations or longer commands, however I don't know how to say it
better, perhaps mentioning that this way it is easier, without
omitting that it could be done without a "remote" alias for the repo.

That's all, thank you
