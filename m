From: David Mansfield <david@cobite.com>
Subject: Re: [PATCH Cogito] cg-init breaks if . contains sub-dir
Date: Tue, 10 May 2005 17:31:11 -0400
Message-ID: <4281281F.6000101@cobite.com>
References: <20050509233904.GB878@osuosl.org> <pan.2005.05.10.03.41.15.683163@smurf.noris.de> <428043EB.7010004@didntduck.org> <20050510075227.GA8176@lug-owl.de> <20050510080445.GB8176@lug-owl.de> <7vis1rpi8a.fsf@assigned-by-dhcp.cox.net> <20050510093212.GD8176@lug-owl.de> <20050510093924.GH11221@kiste.smurf.noris.de> <20050510094538.GE8176@lug-owl.de> <20050510095825.GI11221@kiste.smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jan-Benedict Glaw <jbglaw@lug-owl.de>,
	Junio C Hamano <junkio@cox.net>,
	Brian Gerst <bgerst@didntduck.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 10 23:56:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVch0-000374-2f
	for gcvg-git@gmane.org; Tue, 10 May 2005 23:55:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261822AbVEJWAi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 May 2005 18:00:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261836AbVEJWAQ
	(ORCPT <rfc822;git-outgoing>); Tue, 10 May 2005 18:00:16 -0400
Received: from iris.cobite.com ([208.222.83.2]:5846 "EHLO email-pri.cobite.com")
	by vger.kernel.org with ESMTP id S261794AbVEJVbT (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 May 2005 17:31:19 -0400
Received: from localhost (iris.cobite.com [127.0.0.1])
	by email-pri.cobite.com (Postfix) with ESMTP
	id 22EB098059; Tue, 10 May 2005 17:31:11 -0400 (EDT)
Received: from email-pri.cobite.com ([127.0.0.1])
 by localhost (iris.cobite.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 17566-05; Tue, 10 May 2005 17:31:11 -0400 (EDT)
Received: by email-pri.cobite.com (Postfix, from userid 45000)
	id ECA2A9864B; Tue, 10 May 2005 17:31:10 -0400 (EDT)
Received: from [208.222.80.105] (gandalf.cobite.com [208.222.80.105])
	by email-pri.cobite.com (Postfix) with ESMTP
	id EA16798059; Tue, 10 May 2005 17:31:06 -0400 (EDT)
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
To: Matthias Urlichs <smurf@smurf.noris.de>
In-Reply-To: <20050510095825.GI11221@kiste.smurf.noris.de>
X-Virus-Scanned: by amavisd-new at cobite.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Matthias Urlichs wrote:
> Hi,
> 
> Jan-Benedict Glaw:
> 
>>>Please don't change that without talking to Linus.
>>
>>I won't.  You haven't seen a patch from me "fixing" this, too.  *I*
>>consider this as a defect, but that doesn't mean that I'll force others
>>to take this view, too.  But maybe I'll talk Linus into this when he's
>>back from his trip.
> 
> 
> That would be a good idea; I do support dropping (or at least relaxing)
> that rule. For excluding unwanted files, I'd suggest using a .git/ignore
> file with nice shiny patterns (*.a *.o *.swp ...) inside -- git already
> supports that anyway.
> 

Speaking of which, for a large project, (such as the kernel) it is a 
pain in the butt if exclude lists only consider the 'basename' of the 
file, and cannot include any path matching information.

For a long time there were generated files in the kernel which had the 
same names as non-generated files somewhere else in the kernel tree 
(under a different path).  Making an automated 'take latest patch from 
Linus, apply, commit' was really a pain because of this.

Is there/will there be support for path matching in the ignore files?

If the answer is no, but people like the idea, I could look into it.

David




