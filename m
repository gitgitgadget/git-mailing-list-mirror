From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: git-repack && git-prune-packed isn't doing it's job anymore?
Date: Sat, 4 Mar 2006 13:29:52 +1300
Message-ID: <46a038f90603031629qbbb287ckd8da1ef56a831dba@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Sat Mar 04 01:30:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FFKek-0000Fq-Ji
	for gcvg-git@gmane.org; Sat, 04 Mar 2006 01:29:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751739AbWCDA3x (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Mar 2006 19:29:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751755AbWCDA3x
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Mar 2006 19:29:53 -0500
Received: from wproxy.gmail.com ([64.233.184.201]:5481 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751739AbWCDA3x convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 3 Mar 2006 19:29:53 -0500
Received: by wproxy.gmail.com with SMTP id 71so781997wra
        for <git@vger.kernel.org>; Fri, 03 Mar 2006 16:29:52 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=IZsmS1OZbTINwxn6tcGTw+HkTNp/KISG3TbuoTRaDjhg2MoWIQWWUQFEqoCbeL0PvKYRiLkdLPXwn3VMitGqb+KPZyyTZVuYkuEfis8na2zI4XgrcSv+tU9iOuykbsrDwjGNJtVLlYCGLaOG6bO96l7jJASQuifiOzIbMEQVe0c=
Received: by 10.54.153.2 with SMTP id a2mr3066722wre;
        Fri, 03 Mar 2006 16:29:52 -0800 (PST)
Received: by 10.54.71.5 with HTTP; Fri, 3 Mar 2006 16:29:52 -0800 (PST)
To: "Git Mailing List" <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17161>

$ find .git/objects -type f | grep -v pack | wc -l
    3297
$ git-repack && git-prune-packed
Generating pack...
Done counting 664 objects.
Deltifying 664 objects.
 100% (664/664) done
Writing 664 objects.
 100% (664/664) done
Total 664, written 664 (delta 384), reused 0 (delta 0)
Pack pack-f38c51a5d5194d6a2f6e711586b9a51980c8d524 created.
$ find .git/objects -type f | grep -v pack | wc -l
    2583

Strange! This is from todays master,

$ git --version
git version 1.2.4.g0a60

cheers,


martin
