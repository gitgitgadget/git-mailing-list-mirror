From: Geoffrey De Smet <ge0ffrey.spam@gmail.com>
Subject: [wish] git svn create-ignore should support resuming just like git
 svn fetch does
Date: Mon, 20 Dec 2010 10:01:26 +0100
Message-ID: <ien616$f0i$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 20 10:05:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PUbgA-0004br-Qh
	for gcvg-git-2@lo.gmane.org; Mon, 20 Dec 2010 10:05:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754620Ab0LTJFH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Dec 2010 04:05:07 -0500
Received: from lo.gmane.org ([80.91.229.12]:56417 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754427Ab0LTJFF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Dec 2010 04:05:05 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PUbfz-0004WL-DZ
	for git@vger.kernel.org; Mon, 20 Dec 2010 10:05:03 +0100
Received: from 91.182.180.144 ([91.182.180.144])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 20 Dec 2010 10:05:03 +0100
Received: from ge0ffrey.spam by 91.182.180.144 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 20 Dec 2010 10:05:03 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 91.182.180.144
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163990>

Hi,

git svn create-ignore doesn't support resuming.
Our OSS project is really big and my connection fails every few 1000 files.
As a result, it's impossible to complete the git svn create-ignore 
command and we had to manually recreate them (and guess where they are).

More info here:
http://stackoverflow.com/questions/4484643/migration-from-svn-go-git-how-do-i-create-gitignore-files-for-a-big-repository

-- 
With kind regards,
Geoffrey De Smet
