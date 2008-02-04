From: Paul Gardiner <osronline@glidos.net>
Subject: Re: New to git: sorry for obvious question.
Date: Mon, 04 Feb 2008 14:17:51 +0000
Message-ID: <47A71E8F.6030104@glidos.net>
References: <47A6E130.7090909@glidos.net> <20080204105006.GA15855@bit.office.eurotux.com> <47A70ECE.2040606@panasas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 04 15:19:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JM2A6-0002BB-LH
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 15:19:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754116AbYBDOR7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 09:17:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753713AbYBDOR6
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 09:17:58 -0500
Received: from mk-outboundfilter-1.mail.uk.tiscali.com ([212.74.114.37]:9844
	"EHLO mk-outboundfilter-1.mail.uk.tiscali.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754040AbYBDOR5 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Feb 2008 09:17:57 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ao8CAP6rpkc+8aIg/2dsb2JhbACrNA
X-IP-Direction: IN
Received: from ranger.systems.pipex.net ([62.241.162.32])
  by smtp.pipex.tiscali.co.uk with ESMTP; 04 Feb 2008 14:17:55 +0000
Received: from [10.0.0.24] (80-42-19-184.dynamic.dsl.as9105.com [80.42.19.184])
	by ranger.systems.pipex.net (Postfix) with ESMTP id 8B878E000637
	for <git@vger.kernel.org>; Mon,  4 Feb 2008 14:17:54 +0000 (GMT)
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <47A70ECE.2040606@panasas.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72506>

Boaz Harrosh wrote:
> On Mon, Feb 04 2008 at 12:50 +0200, Luciano Rocha <luciano@eurotux.com> wrote:
>> Also, git clone --bare doesn't set up the origin configuration, and I
>> have to do it by hand:
>>   git config remote.origin.url "$url"
>>   git config remote.origin.fetch "+refs/heads/*:refs/heads/*"
>>
> Better do "git-remote add URL" then manual addition as above.

Would that be git-remote add --mirror origin URL?
