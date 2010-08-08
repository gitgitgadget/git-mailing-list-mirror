From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [GSoC update] git-remote-svn: Week 15
Date: Sun, 8 Aug 2010 16:22:33 +0530
Message-ID: <20100808105232.GB2309@kytes>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Aug 08 12:54:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oi3WC-00068l-Pi
	for gcvg-git-2@lo.gmane.org; Sun, 08 Aug 2010 12:54:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753378Ab0HHKx6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Aug 2010 06:53:58 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:51976 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753229Ab0HHKx5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Aug 2010 06:53:57 -0400
Received: by pwj7 with SMTP id 7so1011983pwj.19
        for <git@vger.kernel.org>; Sun, 08 Aug 2010 03:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=PikhUmvHJPA6DdH6eNQmp3vc0rcc/CSFh3BrJvTOO1U=;
        b=kmLTgukzQtHUidRgRdAOrkFnb+J1NoU+51jcpP81b4Xq5/A/aZVYfgo8UB6tU9S5OC
         Qpg0hA3EJu+JYIYh4oXDR0pyCiJWCnLm1BkH17J67aFvfXalD7mcEaOWdr+eg1cQ+z1v
         Jgn6lPVOxNAkIe34PJJ0b+DPxYtLEH3OjQKsc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=izzh1PepHQkNpWzeUcuMyD17L3u4Oppq/X+3ZgK8LxeU5L3oQg0RfVuP29O2tiPQXM
         xi9dpWRA4tNRRO4dI4vvLxBLawHSs2RrKh4/ZpPo4SklLpsWgT5gIBogpo8AFTEaxMao
         yMXICyn1EGBsbURwqhN4bA+szaF+OlI4TCj2Q=
Received: by 10.142.144.2 with SMTP id r2mr12783655wfd.262.1281264836872;
        Sun, 08 Aug 2010 03:53:56 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id x18sm4790734wfd.8.2010.08.08.03.53.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 08 Aug 2010 03:53:55 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152898>

Hi,

I'm happy to report that svnrdump is complete with the load
functionality. Ofcourse, there are probably some bugs and many
cleanup/ optimization opportunities- I just mean that it's
more-or-less stable for other developers to see and use. Now I have to
go back to working on svn-dump-fast-export. With the libsvn svndiff0
parser ready, I'll re-iterate what remains to be done: When
svn-dump-fast-export sees a diff, it must pick up the latest version
of the corresponding file from a blob that it wrote to the object
store to apply the diff to and write the result back to the object
store via fast-import. This task is VERY non-trivial, and essentially
involves making fast-import provide feedback and making
svn-dump-fast-export aware of the Git object store. I'll try to finish
off as much of this as possible within the next couple of weeks.

-- Ram
