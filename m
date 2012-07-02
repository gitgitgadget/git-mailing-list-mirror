From: Lars Winterfeld <lars.winterfeld@tu-ilmenau.de>
Subject: bug: "fatal: cannot pread pack file", version 1.7.5.4
Date: Mon, 02 Jul 2012 12:03:13 -0700
Message-ID: <5638dec6e156f83385a3baa01cf9ac4d@localhost>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 02 21:03:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SlluH-0004mu-Ax
	for gcvg-git-2@plane.gmane.org; Mon, 02 Jul 2012 21:03:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751309Ab2GBTDU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jul 2012 15:03:20 -0400
Received: from piggy.rz.tu-ilmenau.de ([141.24.4.8]:49009 "EHLO
	piggy.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750929Ab2GBTDU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2012 15:03:20 -0400
Received: from venus.rz.tu-ilmenau.de (venus.rz.tu-ilmenau.de [141.24.4.158])
	by piggy.rz.tu-ilmenau.de (8.13.7/8.13.7/Debian-2) with ESMTP id q62J3FWP023250
	for <git@vger.kernel.org>; Mon, 2 Jul 2012 21:03:15 +0200
X-Sender: 8T2hPuvgw8oU5VPyKXM23RZftIJy0ib5DwoGU+lI1ygksq3g3RlgBw==@vger.kernel.org
User-Agent: Roundcube Webmail/0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200854>

Hi,

I have used git for some time and regularly pushed changes to another 
server (as some kind of backup), but today I got this error during `git 
push`:

Counting objects: 1293, done.
Compressing objects: 100% (1027/1027), done.
Writing objects: 100% (1229/1229), 70.83 MiB | 364 KiB/s, done.
Total 1229 (delta 343), reused 0 (delta 0)
fatal: cannot pread pack file: No such file or directory
error: unpack failed: index-pack abnormal exit
To user@host:~/path/
 ! [remote rejected] master -> master (n/a (unpacker error))
error: failed to push some refs to 'user@host:~/path/'

I found similar bug reports suggesting to upgrade too version 1.7.x, 
but I am already using git version 1.7.5.4. Can somebody explain to me 
what this error is about? What can I do to resolve it / is there a 
workaround?

(There is enough disk space on the other server.)

Lars
