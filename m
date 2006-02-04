From: Ian Molton <spyro@f2s.com>
Subject: Merge problems.
Date: Sat, 04 Feb 2006 22:50:59 +0000
Organization: The Dragon Roost
Message-ID: <43E52FD3.20202@f2s.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Feb 04 23:46:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F5WB0-0001ZU-OK
	for gcvg-git@gmane.org; Sat, 04 Feb 2006 23:46:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932385AbWBDWqg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Feb 2006 17:46:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932519AbWBDWqg
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Feb 2006 17:46:36 -0500
Received: from outmail1.freedom2surf.net ([194.106.33.237]:15786 "EHLO
	outmail.freedom2surf.net") by vger.kernel.org with ESMTP
	id S932385AbWBDWqg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Feb 2006 17:46:36 -0500
Received: from [192.168.1.2] (i-195-137-81-187.freedom2surf.net [195.137.81.187])
	by outmail.freedom2surf.net (8.12.10/8.12.10) with ESMTP id k14MkTVT001108
	for <git@vger.kernel.org>; Sat, 4 Feb 2006 22:46:30 GMT
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051219)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15606>

Doing the following:

git checkout -b mywork v2.6.12
# work, work, work
git commit -a
git merge "Merging happily." mywork v2.6.15

At theat point I get a merge failure - I assume that means I've
got conflicts. I forgot to not the exact error.

so I can see unmerged files using git ls-files --unmerged which lists a
lot of SHA1 hashes and paths. but most of the files in the list I havent
touched! why would they have any conflicts? surely they would simply
update 2.6.12->2.6.15 ?

The SHA1 hashes are all listed at least twice per file too, eg.

100644 d058e65daf19f4bb8c257e2273f4c935ccee5121 1
Documentation/DocBook/scsidrivers.tmpl
100644 d058e65daf19f4bb8c257e2273f4c935ccee5121 2
Documentation/DocBook/scsidrivers.tmpl

What does this mean?

How do I work out what needs merging byhand?
