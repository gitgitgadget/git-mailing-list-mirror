From: jaseem abid <jaseemabid@gmail.com>
Subject: Some help on gitweb project.
Date: Sun, 13 May 2012 23:11:12 +0530
Message-ID: <CAH-tXsAFMyrkAD1FWZKimbJt-gzmcyyXqt7gymtKozwfFt_aSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
	Andrew Sayers <andrew-git@pileofstuff.org>
To: git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 13 19:41:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1STcnv-0006Vx-1r
	for gcvg-git-2@plane.gmane.org; Sun, 13 May 2012 19:41:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751858Ab2EMRly convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 May 2012 13:41:54 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:33960 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751100Ab2EMRly convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 May 2012 13:41:54 -0400
Received: by wibhm6 with SMTP id hm6so862018wib.1
        for <git@vger.kernel.org>; Sun, 13 May 2012 10:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=EAjZpNaqXm4zVWMsodcMlKE+iXPK/+P8SHZ9COU0J1g=;
        b=TNKvPtWFAGD2RCv/SPBqdvwWa/JWMsS7dNOmOSeSJGbocJqzDKs7nf2L7DeKtPsh4n
         uWnzj+poq3X5EzcozwS9khZiokWkeHisR+Q4ZZAsED3Go+nI00T0hu0iz07U6Jp7B5F+
         WCRY+Pz5b1bBGNPtnsmsm7kfz1c3LU55N31JRbhNhxooHcQYJe0akUoNfdshdqXoR7u5
         VnLrJuISPNVVC93EOPVUuYT0M6zp5cFJxFh9GNMZgUIrIM/IELWWwRzz/jeHHPJM8zYf
         607kxleZtoAK7e0SECkkmMguCT0WDTuJ/l0lzysW5Khb5kK8V/1/BK7kf7h0yju4aizR
         T2XQ==
Received: by 10.216.213.219 with SMTP id a69mr3517087wep.16.1336930912554;
 Sun, 13 May 2012 10:41:52 -0700 (PDT)
Received: by 10.227.39.96 with HTTP; Sun, 13 May 2012 10:41:12 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197750>

Dear all,

CC : Andrew Sayers, Jakub Nar=C4=99bski

I have been working on gitweb for a couple of days as part of a
rejected GSoC proposal. I would love to get some help on this and if
somebody can, that would be thankful.

1. How is code tested after some change? I am not talking about unit
testing but about making sure that application is doing what it is
actually intended to do. Do you have to re - install git/gitweb with
every version of code you commit and make sure that it works well and
as expected? Or, is there some other way? Sorry but I am a newbie when
it comes to FOSS contribution and as well working on a project of this
magnitude.

As far as I understand, gitweb by default is looking for files from
`/usr/share/gitweb/` (I work on Debian Sid if that helps). If I edit
the perl or some JavaScript code, how should I test it? *Install* my
version from source as mentioned in "gitweb/INSTALL" ?

2. How I should be committing ?

Personally I commit on *very* small changes, so that I can easily get
back to any point and do bisects well and good, but I see the patches
in the mailing list to be polished and fine tuned. Commit somehow
comfortably and then polish it in another branch with rebase and
squashes and then submit it for comments on mailing list?

Refer please: http://sethrobertson.github.com/GitBestPractices/#sausage

3. How will I submit a commit like "Adding jQuery library"? Mail a
whole minimized JavaScript library to the mailing list? How can
somebody crosscheck the contents of a minimized JavaScript library ?

Earlier Jakub mentioned about adding CDN support for the library,
which I think is a very good feature. How should I do this? Add an
extra config/build variable to select b/w local and CDN version ?

4. At what stage is code to be submitted? After the full project is
done or in a modular manner? Can I ask for some review and help from
if I push the code to github and share the link, or do I have to mail
that also? I don't want to repeat this :
https://github.com/torvalds/linux/pull/17

5. What should be my base commit/branch for starting the work ?

V/r,

Jaseem Abid
http://jaseemabid.github.com
