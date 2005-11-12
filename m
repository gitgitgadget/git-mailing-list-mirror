From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: http protocol, cloning git.git, fails (too many open files)
Date: 12 Nov 2005 14:25:09 -0800
Message-ID: <86acg9ijwa.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Nov 12 23:26:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eb3oI-0005KC-EB
	for gcvg-git@gmane.org; Sat, 12 Nov 2005 23:25:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964842AbVKLWZS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 Nov 2005 17:25:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964839AbVKLWZS
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Nov 2005 17:25:18 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:16681 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP id S964802AbVKLWZQ
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Nov 2005 17:25:16 -0500
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id A081E8FE94
	for <git@vger.kernel.org>; Sat, 12 Nov 2005 14:25:10 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 07487-02-19 for <git@vger.kernel.org>;
 Sat, 12 Nov 2005 14:25:09 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id EF5FE8FE9D; Sat, 12 Nov 2005 14:25:09 -0800 (PST)
To: git@vger.kernel.org
x-mayan-date: Long count = 12.19.12.14.4; tzolkin = 8 Kan; haab = 2 Ceh
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11715>


    $ mkdir foo
    $ cd foo
    $ cg-clone http://www.kernel.org/pub/scm/git/git.git git.new
    Fetching head...
    Fetching objects...
    progress: 1 objects, 191 bytes
progress: 2 objects, 519 bytes
progress: 3 objects, 5851 bytes
progress: 4 objects, 7671 bytes
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    progress: 5 objects, 8274 bytes
progress: 6 objects, 12989 bytes
progress: 7 objects, 16698 bytes
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    progress: 8 objects, 28639 bytes
progress: 9 objects, 37700 bytes
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    progress: 10 objects, 38341 bytes
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    progress: 11 objects, 39097 bytes
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    progress: 12 objects, 43396 bytes
progress: 13 objects, 44694 bytes
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    progress: 14 objects, 45036 bytes
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    progress: 15 objects, 45511 bytes
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    progress: 16 objects, 47485 bytes
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    progress: 17 objects, 51016 bytes
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    progress: 18 objects, 51368 bytes
progress: 19 objects, 54438 bytes
progress: 20 objects, 55478 bytes
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    progress: 21 objects, 63175 bytes
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    progress: 22 objects, 64613 bytes
progress: 23 objects, 66548 bytes
progress: 24 objects, 68347 bytes
progress: 25 objects, 70471 bytes
progress: 26 objects, 72662 bytes
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    progress: 27 objects, 75536 bytes
progress: 28 objects, 82929 bytes
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    progress: 29 objects, 85551 bytes
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    progress: 30 objects, 85834 bytes
progress: 31 objects, 86902 bytes
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    progress: 32 objects, 87980 bytes
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    progress: 33 objects, 88242 bytes
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    progress: 34 objects, 90131 bytes
progress: 35 objects, 92595 bytes
progress: 36 objects, 99562 bytes
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    progress: 37 objects, 99997 bytes
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    progress: 38 objects, 101100 bytes
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    progress: 39 objects, 101673 bytes
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    progress: 40 objects, 102357 bytes
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    progress: 41 objects, 104042 bytes
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    progress: 42 objects, 104924 bytes
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    progress: 43 objects, 105887 bytes
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    progress: 44 objects, 112614 bytes
progress: 45 objects, 114909 bytes
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    progress: 46 objects, 125043 bytes
progress: 47 objects, 132911 bytes
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    progress: 48 objects, 135339 bytes
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    progress: 49 objects, 140171 bytes
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    progress: 50 objects, 142244 bytes
progress: 51 objects, 142320 bytes
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    progress: 52 objects, 144201 bytes
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    progress: 53 objects, 147742 bytes
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    progress: 54 objects, 152880 bytes
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    progress: 55 objects, 154845 bytes
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    progress: 56 objects, 160035 bytes
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    progress: 57 objects, 162525 bytes
progress: 58 objects, 172189 bytes
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    progress: 59 objects, 175374 bytes
progress: 60 objects, 179154 bytes
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    progress: 61 objects, 183166 bytes
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    progress: 62 objects, 184979 bytes
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    progress: 63 objects, 185402 bytes
progress: 64 objects, 185658 bytes
progress: 65 objects, 186589 bytes
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
    error: Couldn't create temporary file .git/objects/be/63132804252e9a2f94ce1166ef9fa319a845fd.temp for .git/objects/be/63132804252e9a2f94ce1166ef9fa319a845fd: Too many open files

    error: Couldn't create temporary file .git/objects/df/a87fe1191862b2c650e55fdd727802ef00cf34.temp for .git/objects/df/a87fe1191862b2c650e55fdd727802ef00cf34: Too many open files

    error: Couldn't create temporary file .git/objects/51/cf86a5843acc3b6bc3d8c4be9fec0fdd0a0df5.temp for .git/objects/51/cf86a5843acc3b6bc3d8c4be9fec0fdd0a0df5: Too many open files

    error: Couldn't create temporary file .git/objects/c9/9db9dd79315dff4ac19c79b35275cd02397e60.temp for .git/objects/c9/9db9dd79315dff4ac19c79b35275cd02397e60: Too many open files

    error: Couldn't create temporary file .git/objects/2b/2c6b77afd53870423d4bad9191ed669bc55660.temp for .git/objects/2b/2c6b77afd53870423d4bad9191ed669bc55660: Too many open files

    error: Couldn't create temporary file .git/objects/dc/c168dbbfaf5c72d20cbbfba92c817f40467238.temp for .git/objects/dc/c168dbbfaf5c72d20cbbfba92c817f40467238: Too many open files

    error: Couldn't create temporary file .git/objects/07/203659d0dae619f78773d3caea6b58907a1ba5.temp for .git/objects/07/203659d0dae619f78773d3caea6b58907a1ba5: Too many open files

    progress: 66 objects, 187452 bytes

And at this point, it hung.  I had to ^C.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
