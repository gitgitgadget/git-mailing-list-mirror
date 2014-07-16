From: Ted Felix <ted@tedfelix.com>
Subject: Re: [PATCH v2 2/2] rebase: omit patch-identical commits with --fork-point
Date: Wed, 16 Jul 2014 17:36:03 -0400
Message-ID: <53C6F043.7090209@tedfelix.com>
References: <xmqqmwcatgza.fsf@gitster.dls.corp.google.com> <47e67c62fb2a8c8846f5d3a12d71aebf8fa875d7.1405538598.git.john@keeping.me.uk> <374b26180807c67f7bd152ce5a2f52e34397e3a6.1405538598.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: John Keeping <john@keeping.me.uk>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 16 23:42:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7Wxq-0005mn-Pa
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jul 2014 23:42:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750846AbaGPVmL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2014 17:42:11 -0400
Received: from qmta02.westchester.pa.mail.comcast.net ([76.96.62.24]:54409
	"EHLO qmta02.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751532AbaGPVmJ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Jul 2014 17:42:09 -0400
X-Greylist: delayed 365 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Jul 2014 17:42:09 EDT
Received: from omta01.westchester.pa.mail.comcast.net ([76.96.62.11])
	by qmta02.westchester.pa.mail.comcast.net with comcast
	id T2Cm1o0080EZKEL519c3G4; Wed, 16 Jul 2014 21:36:03 +0000
Received: from [192.168.1.105] ([76.100.236.26])
	by omta01.westchester.pa.mail.comcast.net with comcast
	id T9c31o00i0arC9o3M9c3hG; Wed, 16 Jul 2014 21:36:03 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <374b26180807c67f7bd152ce5a2f52e34397e3a6.1405538598.git.john@keeping.me.uk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20140121; t=1405546563;
	bh=lRuRUw4aF8BRjZ/VsSi2pXMHYsbVH/m6ubsO9zXBQjE=;
	h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
	 Content-Type;
	b=GNLhp0RL3ZVOuZ80IcNCfGW+mh0EtF2+kTZ5q59J17xpTeZSQJskA309Zs2JyhpAh
	 HxSliaNBExQi//4BB/jiUqrvS/zYXxMa28Xu6t6TuKQXx+/rQDg4t/VucQZAQNn1ZN
	 zFFsZFWyLGftmrQwdlsftPKZKK2jvJGiP9X3t1hJ77Zo7128YefAc3TYYh+JmjFav7
	 dunE+qaW7JRJ+Nrmzm2k+aLiF4mPbYnzJ3NHme4L5ZfXrhK0SxNLjjVetuYqUATZNm
	 esS6br/u60V/voJtSKA2m6rmxgUe2PkaDXI0U/Lh7LUhV9nRqJNov0gSrA72gGrx32
	 YSW4eLlWRz81w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253693>

On 07/16/2014 03:23 PM, John Keeping wrote:
> Change from v1:
>      - add a test case

Test case is working fine for me.  It passes with the patch and fails 
without.  However, it does seem to cause all the rest of the test cases 
to fail if it fails.  Is there some cleanup missing?

Ted.
