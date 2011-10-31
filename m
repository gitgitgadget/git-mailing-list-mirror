From: Michael Schubert <mschub@elegosoft.com>
Subject: Re: New Feature wanted: Is it possible to let git clone continue
 last break point?
Date: Mon, 31 Oct 2011 13:49:05 +0100
Message-ID: <4EAE9941.2080609@elegosoft.com>
References: <CAEZo+gfKVY-YgMjd=bEYzRV4-460kqDik-yVcQ9Xs=DoCZOMDg@mail.gmail.com> <CAEZo+gcj5q2UYnak1+1UG7pPzoeaUr=QLsiCiNXbC_n+JQbKQQ@mail.gmail.com> <m3obwx4j7s.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Cc: netroby <hufeng1987@gmail.com>, Git Mail List <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 31 13:50:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RKrJk-0005vC-V5
	for gcvg-git-2@lo.gmane.org; Mon, 31 Oct 2011 13:50:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932950Ab1JaMuH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Oct 2011 08:50:07 -0400
Received: from mx0.elegosoft.com ([78.47.87.163]:55870 "EHLO mx0.elegosoft.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932910Ab1JaMuG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Oct 2011 08:50:06 -0400
Received: from localhost (localhost [127.0.0.1])
	by mx0.elegosoft.com (Postfix) with ESMTP id 420E0DE723;
	Mon, 31 Oct 2011 13:50:04 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mx0.elegosoft.com
Received: from mx0.elegosoft.com ([127.0.0.1])
	by localhost (mx0.elegosoft.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HffF0-SXXKvB; Mon, 31 Oct 2011 13:49:55 +0100 (CET)
Received: from [10.10.10.197] (i59F7870A.versanet.de [89.247.135.10])
	by mx0.elegosoft.com (Postfix) with ESMTPSA id CCE65DE089;
	Mon, 31 Oct 2011 13:49:55 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:7.0.1) Gecko/20111001 Thunderbird/7.0.1
In-Reply-To: <m3obwx4j7s.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184503>

On 10/31/2011 10:14 AM, Jakub Narebski wrote:
> netroby <hufeng1987@gmail.com> writes:
> 
>> Is it possible to let git clone continue last break point.
>> when we git clone very large project from the web,  we may face some
>> interupt, then we must clone it from zero .
>>
>> it is bad feeling for low  connection  speed users.
>>
>> please help us out.
>>
>> we need git clone continue last break point
> 
> Resuming "git clone" is not currently possible in Git, and it would be
> difficult to add such feature to Git; there were several attempts and
> neither succeeded.
> 
> What you can do is generate a starter bundle out of your repository
> (using "git bundle"), and serve this file via HTTP / FTP / BitTorrent,
> i.e. some resumable transport.  Then you "git clone <bundle file>",
> fix up configuration, and fetch the rest since bundle creation.

There's also a "git bundler service":

http://comments.gmane.org/gmane.comp.version-control.git/181380
