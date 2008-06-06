From: "Brian Foster" <brian.foster@innova-card.com>
Subject: [Q] Changing the current branch (HEAD) in a bare repository - how?
Date: Fri, 6 Jun 2008 17:43:59 +0200
Message-ID: <a537dd660806060843p4e92932x4e0f5464c5fd1da1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 06 17:44:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4e7a-0006wJ-VO
	for gcvg-git-2@gmane.org; Fri, 06 Jun 2008 17:44:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754063AbYFFPoB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 11:44:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753179AbYFFPoA
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 11:44:00 -0400
Received: from rv-out-0506.google.com ([209.85.198.231]:33425 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751509AbYFFPoA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 11:44:00 -0400
Received: by rv-out-0506.google.com with SMTP id l9so1555820rvb.1
        for <git@vger.kernel.org>; Fri, 06 Jun 2008 08:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:mime-version:content-type:content-transfer-encoding
         :content-disposition:x-google-sender-auth;
        bh=9md2wT6e1lqUWQD5UO9lbi7pS+t3kBrjzOVc38ioWPU=;
        b=EMU8iUfnDe3jja84P0RPu58YQyvWAHFsbM9aFCGnbxGM1TV3H4l9HhvD+ishbSWsN/
         k2yijXgBYZyGXuOnEDBs2AGqRsIID3493tekeszimM+V2QwtM+QhcilXS8VRcblvpWmm
         Pc825kS5w9s2JlYsTSwKxD9sgOxcIADgQD6vU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=QynBPZubj52DN/HlQP4xAJ74VTDFFBtaMm69BCRr3yp7SZikCvdSrQsVNfZ6lzJanG
         mVLJl6PLz6uZnfh385Cm3WhL5t0Jif9cIgGTDzQjjZcdx0e6C1ectWkvfYf0NIiXXbhM
         VjRG4UynVwv+FYCMQhdv4cTQL15rstZ6fX1Is=
Received: by 10.140.202.21 with SMTP id z21mr156050rvf.81.1212767039503;
        Fri, 06 Jun 2008 08:43:59 -0700 (PDT)
Received: by 10.141.197.19 with HTTP; Fri, 6 Jun 2008 08:43:59 -0700 (PDT)
Content-Disposition: inline
X-Google-Sender-Auth: 0676d3b1bb34ebdd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84082>

 Using git 1.5.2.5 (Kubuntu 7.10) and a bare repository,
 I started with (the commands and output below are typed
 in by hand, mostly from memory):

    $ git branch -a
    * master
      foo
    $

 and then changed the branch names:

    $ git branch -m master old-master
    $ git branch -m foo master

 and got this:

    $ git branch -a
      master
    * old-master
    $

 Now, how do I change the current branch to the (new)
 `master'?  A `checkout' fails:

    $ git checkout master
    fatal: /usr/bin/git-checkout cannot be used without a working tree.
    $

 I (ultimately) hand-edited `HEAD' (apparently successfully),
 but am wondering what I should have done or may have missed?

 I didn't spot anything in TFM, albeit I could have easily overlooked
 or misunderstood something.

cheers!
	-blf-

-- 
"How many surrealists does it take to   | Brian Foster
 change a lightbulb? Three. One calms   | somewhere in south of France
 the warthog, and two fill the bathtub  | Stop E$$o (ExxonMobil)!
 with brightly-coloured machine tools." | http://www.stopesso.com
