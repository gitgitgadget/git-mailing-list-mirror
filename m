From: Ian Molton <spyro@f2s.com>
Subject: how to merge...
Date: Mon, 30 Jan 2006 12:25:13 +0000
Organization: The Dragon Roost
Message-ID: <43DE05A9.90804@f2s.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Jan 30 13:21:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F3Y2D-0001DE-K8
	for gcvg-git@gmane.org; Mon, 30 Jan 2006 13:21:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932237AbWA3MV1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jan 2006 07:21:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932242AbWA3MV1
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jan 2006 07:21:27 -0500
Received: from outmail1.freedom2surf.net ([194.106.33.237]:43198 "EHLO
	outmail.freedom2surf.net") by vger.kernel.org with ESMTP
	id S932237AbWA3MV0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jan 2006 07:21:26 -0500
Received: from [192.168.1.2] (i-195-137-81-187.freedom2surf.net [195.137.81.187])
	by outmail.freedom2surf.net (8.12.10/8.12.10) with ESMTP id k0UCLPVT004361
	for <git@vger.kernel.org>; Mon, 30 Jan 2006 12:21:25 GMT
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051219)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15271>

Hi...

Well, I've got the basics of importing patches from outside git now, so 
the next question is...

suppose I've aplpied the 2.6.16-rc1-mm3 patch into its own branch in my 
local git repo.

I've also created an arm26 branch from the master 2.6.16-rc1.

I want to pull some patches from the -mm3 branch into the arm26 one, as 
a single change.

Obviously, I could simply make a diff including just those files and 
apply it to my arm26 branch, but I'd prefer not to if theres a better 
way that allows git to keep track of what really happened.

Presumably the 'correct' fix is to import the broken up -mm patchset so 
git can pull only the changes relating to those files, but since Im 
learning and not everyone provides broken up patchsets, it'd be nice to 
know if theres a way to do it 'the hard way'.

Cheers!
