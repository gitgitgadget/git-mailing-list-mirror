From: Mircea Bardac <dev@mircea.bardac.net>
Subject: possible 'git cp'/how does git detect copies
Date: Fri, 27 Jun 2008 13:40:22 +0100
Message-ID: <4864DFB6.3050204@mircea.bardac.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 27 14:47:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCDML-0008BQ-Vx
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 14:47:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753959AbYF0Mq3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 08:46:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753828AbYF0Mq3
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 08:46:29 -0400
Received: from wr-out-0506.google.com ([64.233.184.234]:58185 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752645AbYF0Mq2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 08:46:28 -0400
Received: by wr-out-0506.google.com with SMTP id 69so379964wri.5
        for <git@vger.kernel.org>; Fri, 27 Jun 2008 05:46:25 -0700 (PDT)
Received: by 10.90.54.17 with SMTP id c17mr1603910aga.74.1214570785723;
        Fri, 27 Jun 2008 05:46:25 -0700 (PDT)
Received: from ?192.168.126.97? ( [212.13.49.167])
        by mx.google.com with ESMTPS id 6sm1275067agd.39.2008.06.27.05.46.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 27 Jun 2008 05:46:25 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (X11/20080502)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86545>

I was looking today at duplicating a file but, I soon realized that 
there is no 'git cp' command (this was the "deductive approach to git 
commands", starting from git mv/rm/...). How does "git diff -C" detect 
copies (-C is used for this, according to the documentation)?

On a very simple test, I couldn't see this working. I just copied one 
file, added it, committed the change, ran "git diff -C HEAD^!". There is 
no place saying that it's contents is copied from some other file (both 
files are in the repository now).

"git blame -C new_copied_file" also doesn't show the commits for the 
original file.

This is all with 1.5.6.1.

I am probably missing something here... but I can't produce an example 
of copied contents that actually works. Any hint would be appreciated.

I found this older thread [1] on "git cp" but the discussion appears to 
have stalled at some point. If there is indeed no use of a "git cp" 
command, I would like at least some info on how content copies are being 
detected, since I haven't seen this working.

[1] http://kerneltrap.org/mailarchive/git/2008/2/3/705424


Many thanks,
Mircea

--
http://mircea.bardac.net
