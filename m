From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [PATCH] [1/2many] - FInd the maintainer(s) for a patch - scripts/get_maintainer.pl
Date: Wed, 15 Aug 2007 09:52:29 -0400
Message-ID: <68B09015-4411-470A-BA88-732969469AA2@mac.com>
References: <1187026955.2688.4.camel@laptopd505.fenrus.org> <1187037445.6628.98.camel@heimdal.trondhjem.org> <1187054366.2757.0.camel@laptopd505.fenrus.org> <46C10AA8.3090505@gmail.com> <20070814102033.604c8695@the-village.bc.nu> <46C1CFFE.4000001@gmail.com> <1187110824.32555.76.camel@localhost> <46C1EE6F.2080807@gmail.com> <1187116082.32555.122.camel@localhost> <alpine.LFD.0.999.0708141131140.30176@woody.linux-foundation.org> <20070814193333.GI21089@ftp.linux.org.uk> <46C2548D.80605@gmail.com> <alpine.LFD.0.999.0708151846130.16414@enigma.security.iitk.ac.in> <46C30220.6060007@gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Satyam Sharma <satyam@infradead.org>,
	Al Viro <viro@ftp.linux.org.uk>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Joe Perches <joe@perches.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Arjan van de Ven <arjan@infradead.org>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	Mariusz Kozlowski <m.kozlowski@tuxland.pl>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Rene Herman <rene.herman@gmail.com>
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1763426AbXHONxz@vger.kernel.org Wed Aug 15 15:54:31 2007
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1763426AbXHONxz@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILJKP-0001Br-K0
	for glk-linux-kernel-3@gmane.org; Wed, 15 Aug 2007 15:54:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763426AbXHONxz (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Wed, 15 Aug 2007 09:53:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762682AbXHONx0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Aug 2007 09:53:26 -0400
Received: from smtpout.mac.com ([17.250.248.175]:65202 "EHLO smtpout.mac.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762201AbXHONxX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Aug 2007 09:53:23 -0400
Received: from mac.com (smtpin05-en2 [10.13.10.150])
	by smtpout.mac.com (Xserve/smtpout05/MantshX 4.0) with ESMTP id l7FDqYRX022075;
	Wed, 15 Aug 2007 06:52:34 -0700 (PDT)
Received: from [10.0.2.2] (ip70-187-212-71.dc.dc.cox.net [70.187.212.71])
	(authenticated bits=0)
	by mac.com (Xserve/smtpin05/MantshX 4.0) with ESMTP id l7FDqVEI026892
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Wed, 15 Aug 2007 06:52:32 -0700 (PDT)
In-Reply-To: <46C30220.6060007@gmail.com>
X-Mailer: Apple Mail (2.752.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55904>

On Aug 15, 2007, at 09:39:44, Rene Herman wrote:
> On 08/15/2007 03:33 PM, Satyam Sharma wrote:
>
> [ git info --maintainer ]
>
>> I'd really _love_ a tool that does all that what you've proposed  
>> above!  But why does it have to be "git-info" or anything in the  
>> git(7) suite for that matter? This sounds like a job for a  
>> different specialised tool,  long with ".metatags" kind of files  
>> dispersed in the source tree.
>
> To automatically move (and delete) the meta-data alongside the  
> files themselves is a reason.
>
> More generally -- shouldn't it? This is about source management  
> (well, maybe more about project management, but...) and the source  
> code management tool looks to be the right place for that. The  
> different parts of git are somewhat/fairly stand-alone as is, no?

If you were going to do that I'd just suggest making git aware of the  
"user.*" extended attributes and having it save those into the git  
repo along with the permission data.

Cheers,
Kyle Moffett
