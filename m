From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: Creating a tarball out of a directory in a bare git repository
Date: Mon, 01 Mar 2010 15:00:28 -0800
Message-ID: <86y6ibhckz.fsf@blue.stonehenge.com>
References: <27750115.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: jateeq <jawad_atiq@hotmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 02 00:23:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NmExH-0003Lx-1N
	for gcvg-git-2@lo.gmane.org; Tue, 02 Mar 2010 00:23:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751665Ab0CAXXI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Mar 2010 18:23:08 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:16302 "EHLO
	blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751316Ab0CAXXH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Mar 2010 18:23:07 -0500
X-Greylist: delayed 1356 seconds by postgrey-1.27 at vger.kernel.org; Mon, 01 Mar 2010 18:23:07 EST
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id E665E1DE383; Mon,  1 Mar 2010 15:00:28 -0800 (PST)
x-mayan-date: Long count = 12.19.17.2.14; tzolkin = 5 Ix; haab = 12 Kayab
In-Reply-To: <27750115.post@talk.nabble.com> (jawad_atiq@hotmail.com's message of "Mon, 1 Mar 2010 14:47:45 -0800 (PST)")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141367>

>>>>> "jateeq" == jateeq  <jawad_atiq@hotmail.com> writes:

jateeq> - list all the files/folders in the directory (i have the sha1 hash of the
jateeq> directory)
jateeq> - foreach file in the directory, get the file contents (recurse if there are
jateeq> further subdirectories). Probably store the result in an array. 
jateeq> - create a file somewhere on the filesystem out of each file output above.
jateeq> Store it under the directory name.
jateeq> - create a tarball out of the 'working' directory as usual.

Sounds like you're reinventing "git archive". :)

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Smalltalk/Perl/Unix consulting, Technical writing, Comedy, etc. etc.
See http://methodsandmessages.vox.com/ for Smalltalk and Seaside discussion
