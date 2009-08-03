From: Matt Di Pasquale <pasquale@fas.harvard.edu>
Subject: git for pushing local subdir to website
Date: Mon, 3 Aug 2009 13:11:13 -0400
Message-ID: <13f0168a0908031011odd98c03ye08a1b0774fca523@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 03 19:11:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MY14Z-00013F-6w
	for gcvg-git-2@gmane.org; Mon, 03 Aug 2009 19:11:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751656AbZHCRLf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Aug 2009 13:11:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751458AbZHCRLf
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Aug 2009 13:11:35 -0400
Received: from mail-fx0-f217.google.com ([209.85.220.217]:37789 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750811AbZHCRLe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Aug 2009 13:11:34 -0400
Received: by fxm17 with SMTP id 17so2760523fxm.37
        for <git@vger.kernel.org>; Mon, 03 Aug 2009 10:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:from:date
         :x-google-sender-auth:message-id:subject:to:content-type
         :content-transfer-encoding;
        bh=2nyPHGNhEODTUk2XlgMtSWdTpvzFUrfFxlLUmkx3YSg=;
        b=pQK+Kt/VwZ8McRiX+eX3NNGY272wDP1pQOVyd7HEt+3JePlSJQfo/0e1nXvQlNA9Pa
         ieWw/BlG/Gzhwqe7jL8cNTq5v1LDOzi1XBi36EB+Y9m4H7rkHJw+AsV0Ag5hEWrgVh3X
         PR1nttUXI15WO39I8+3wG3Q0EHcsHBdWd0vIM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:from:date:x-google-sender-auth:message-id
         :subject:to:content-type:content-transfer-encoding;
        b=Xj9tmT2W9SHc+BKdT3t6bRj13YsbWJEf4vvXwDuDjhaPm1jSyeOU0x8KJILKK2p8db
         IblJ92/BWivNPv4x6+sux3oje2B5+bIQZxA1tWQ/Q/9WlQ0MTP2kVTXHEY7e2kIWwoBX
         KAZnuJl27USSisZ4leQ2J8mj1ijxf9J1lA2/M=
Received: by 10.103.242.20 with SMTP id u20mr3654490mur.0.1249319493122; Mon, 
	03 Aug 2009 10:11:33 -0700 (PDT)
X-Google-Sender-Auth: 6317adf61073f363
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124705>

I made a post here about this here:
http://stackoverflow.com/questions/600079/is-there-any-way-to-clone-a-git-repositorys-sub-directory-only/1223407#1223407

Basically, I'm working alone on a website (well, it's a facebook
app.). What's the best way to sync my local copy with my production?
but i want the production to only be linked with the production subdir
of my local project.

so, I have a local copy i'm working on that I've organized like so.
call the project example. here are the dirs on my local comp. macbook.

example -extra [this holds files i don't want to go to the webserver
mainly for security reasons. files like .psd files or .sql files. or
readme files. etc.] -example.com [this dir holds all the files i want
on my server for production at http://example.com]

i have local git repo here: example/.git

now... how do i just push example.com and not extra and example.com?

do i need to make another git repo in example.com and make example.com
a submodule?

i've also thought about using branches... a local branch and a
production branch. but i only want one copy of the production files.
because i want to be able to check out all the files and zip the dir
and send it to someone to see.

that doesn't really make sense conceptually because example is one big
project. extra is like extra files and example.com is like what i
really want to go on web server...

thanks!

-matt
