From: Jon Forrest <nobozo@gmail.com>
Subject: Odd Difference Between Windows Git and Standard Git
Date: Thu, 19 May 2016 18:48:18 -0700
Message-ID: <nhlqd4$ekr$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 20 03:48:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3ZYH-0002L6-CU
	for gcvg-git-2@plane.gmane.org; Fri, 20 May 2016 03:48:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753693AbcETBs3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2016 21:48:29 -0400
Received: from plane.gmane.org ([80.91.229.3]:39262 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753342AbcETBs2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2016 21:48:28 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1b3ZYA-0002IY-Gn
	for git@vger.kernel.org; Fri, 20 May 2016 03:48:26 +0200
Received: from c-71-202-183-39.hsd1.ca.comcast.net ([71.202.183.39])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 20 May 2016 03:48:26 +0200
Received: from nobozo by c-71-202-183-39.hsd1.ca.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 20 May 2016 03:48:26 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: c-71-202-183-39.hsd1.ca.comcast.net
X-Mozilla-News-Host: news://www.gmane.org:119
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295135>

I'm running Git version 2.8.2 built from source on Ubuntu 16.04.
I'm using a repository that's stored on Dropbox. I'm the only person
accessing this repo. Everything works great.

For reasons unrelated to Git, I decided to try Git for Windows,
so I installed "git version 2.8.2.windows.1" on Windows 10.
When I run 'git status' on Ubuntu the list I see is exactly what
I expect. However, when I run 'git status' on the
same Dropbox repo on Windows, I see what I expect plus I'm told
that every .pdf file and some .png files are modified.

I'm guessing that this is caused by some mishandling of
binary files. Is this behavior to be expected? If so, is there
something I can do to have the output on Windows be the
same as on Ubuntu? I'm aware of 'git update-index --assume-unchanged'
but this seems harsh.

I copied the repo to a non-Dropbox location, just in case
it was Dropbox that was causing the problem, but this didn't
make any difference.

(If you want to try this yourself, try it on the ProGit2
book source on Github).

Thanks,
Jon Forrest
