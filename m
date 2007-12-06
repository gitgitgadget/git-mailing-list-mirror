From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: Re: Git and GCC
Date: Wed, 05 Dec 2007 21:04:47 -0800
Message-ID: <1196917487.10408.82.camel@brick>
References: <4aca3dc20712051108s216d3331t8061ef45b9aa324a@mail.gmail.com> 	 <20071205.182815.249974508.davem@davemloft.net> 	 <4aca3dc20712051841o71ab773ft6dd0714ebc355dd5@mail.gmail.com> 	 <20071205.185203.262588544.davem@davemloft.net> 	 <4aca3dc20712051947t5fbbb383ua1727c652eb25d7e@mail.gmail.com> 	 <1196915112.10408.66.camel@brick> 	 <alpine.LFD.0.9999.0712052033570.13796@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Daniel Berlin <dberlin@dberlin.org>, David Miller <davem@davemloft.net>,  ismail@pardus.org.tr, gcc@gcc.gnu.org, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: gcc-return-142721-gcc=m.gmane.org@gcc.gnu.org Thu Dec 06 06:06:06 2007
Return-path: <gcc-return-142721-gcc=m.gmane.org@gcc.gnu.org>
Envelope-to: gcc@gmane.org
Received: from sourceware.org ([209.132.176.174])
	by lo.gmane.org with smtp (Exim 4.50)
	id 1J08vB-0003wZ-JW
	for gcc@gmane.org; Thu, 06 Dec 2007 06:05:43 +0100
Received: (qmail 3662 invoked by alias); 6 Dec 2007 05:04:54 -0000
Received: (qmail 3647 invoked by uid 22791); 6 Dec 2007 05:04:54 -0000
X-Spam-Check-By: sourceware.org
Received: from rv-out-0910.google.com (HELO rv-out-0910.google.com) (209.85.198.188)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Thu, 06 Dec 2007 05:04:47 +0000
Received: by rv-out-0910.google.com with SMTP id f5so92188rvb         for <gcc@gcc.gnu.org>; Wed, 05 Dec 2007 21:04:45 -0800 (PST)
Received: by 10.140.226.14 with SMTP id y14mr1731660rvg.1196917485507;         Wed, 05 Dec 2007 21:04:45 -0800 (PST)
Received: from ?192.168.1.101? ( [216.19.190.48])         by mx.google.com with ESMTPS id l32sm88616rvb.2007.12.05.21.04.42         (version=TLSv1/SSLv3 cipher=RC4-MD5);         Wed, 05 Dec 2007 21:04:44 -0800 (PST)
In-Reply-To: <alpine.LFD.0.9999.0712052033570.13796@woody.linux-foundation.org>
X-Mailer: Evolution 2.12.1
X-IsSubscribed: yes
Mailing-List: contact gcc-help@gcc.gnu.org; run by ezmlm
Precedence: bulk
List-Id: <gcc.gcc.gnu.org>
List-Unsubscribe: <mailto:gcc-unsubscribe-gcc=m.gmane.org@gcc.gnu.org>
List-Archive: <http://gcc.gnu.org/ml/gcc/>
List-Post: <mailto:gcc@gcc.gnu.org>
List-Help: <http://gcc.gnu.org/ml/>
Sender: gcc-owner@gcc.gnu.org
Delivered-To: mailing list gcc@gcc.gnu.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67238>

On Wed, 2007-12-05 at 20:54 -0800, Linus Torvalds wrote:
> 
> On Wed, 5 Dec 2007, Harvey Harrison wrote:
> > 
> > If anyone recalls my report was something along the lines of
> > git gc --aggressive explodes pack size.

> [ By default, for example, "git svn clone/fetch" seems to create those 
>   horrible fake email addresses that contain the ID of the SVN repo in 
>   each commit - I'm not talking about the "git-svn-id", I'm talking about 
>   the "user@hex-string-goes-here" thing for the author. Maybe people don't 
>   really care, but isn't that ugly as hell? I'd think it's worth it doing 
>   a really nice import, spending some effort on it.
> 
>   But maybe those things come from the older CVS->SVN import, I don't 
>   really know. I've done a few SVN imports, but I've done them just for 
>   stuff where I didn't want to touch SVN, but just wanted to track some 
>   project like libgpod. For things like *that*, a totally mindless "git 
>   svn" thing is fine ]
> 

git svn does accept a mailmap at import time with the same format as the
cvs importer I think.  But for someone that just wants a repo to check
out this was easiest.  I'd be willing to spend the time to do a nicer
job if there was any interest from the gcc side, but I'm not that
invested (other than owing them for an often-used tool).

Harvey
