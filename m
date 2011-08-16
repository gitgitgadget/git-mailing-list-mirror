From: Andreas Gruenbacher <andreas.gruenbacher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: rejecting patches that have an offset
Date: Wed, 17 Aug 2011 00:48:07 +0200
Message-ID: <1313534889.5598.21.camel@schurl.linbit>
References: <4E49A8EA.5020507@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: bug-patch-mXXj517/zsQ@public.gmane.org, Git Mailing List <git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Eric Blake <eblake-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
X-From: bug-patch-bounces+gcgpb-bug-patch=m.gmane.org-mXXj517/zsQ@public.gmane.org Wed Aug 17 00:48:18 2011
Return-path: <bug-patch-bounces+gcgpb-bug-patch=m.gmane.org-mXXj517/zsQ@public.gmane.org>
Envelope-to: gcgpb-bug-patch@m.gmane.org
Received: from lists.gnu.org ([140.186.70.17])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <bug-patch-bounces+gcgpb-bug-patch=m.gmane.org-mXXj517/zsQ@public.gmane.org>)
	id 1QtSQi-0005kY-N6
	for gcgpb-bug-patch@m.gmane.org; Wed, 17 Aug 2011 00:48:16 +0200
Received: from localhost ([::1]:33793 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bug-patch-bounces+gcgpb-bug-patch=m.gmane.org-mXXj517/zsQ@public.gmane.org>)
	id 1QtSQi-0000lg-B6
	for gcgpb-bug-patch@m.gmane.org; Tue, 16 Aug 2011 18:48:16 -0400
Received: from eggs.gnu.org ([140.186.70.92]:52494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andreas.gruenbacher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>) id 1QtSQf-0000la-T9
	for bug-patch-mXXj517/zsQ@public.gmane.org; Tue, 16 Aug 2011 18:48:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andreas.gruenbacher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>) id 1QtSQe-0006O6-RS
	for bug-patch-mXXj517/zsQ@public.gmane.org; Tue, 16 Aug 2011 18:48:13 -0400
Received: from mail-fx0-f41.google.com ([209.85.161.41]:49897)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andreas.gruenbacher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>) id 1QtSQe-0006O1-IA
	for bug-patch-mXXj517/zsQ@public.gmane.org; Tue, 16 Aug 2011 18:48:12 -0400
Received: by fxg9 with SMTP id 9so375628fxg.0
	for <bug-patch-mXXj517/zsQ@public.gmane.org>; Tue, 16 Aug 2011 15:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=subject:from:to:cc:date:in-reply-to:references:content-type
	:x-mailer:content-transfer-encoding:message-id:mime-version;
	bh=7/bnWVCcOMvyLEwIL7yB9kd3D9xpWR6nCXr6rZhnoho=;
	b=aJG0MyJttEWkZvPo700rG5hZJerAC/VZFVz/gV0L75xG2nujqVnCNiDnkc7TGS/WNp
	Lk5R9j/2cywBYf1nPrLEDSERtF4gMBhzOPb8ad0gL4y/7JEXha1Rm7BfRTktIA292H9D
	pGo5F04ODNJ6GnsfQhXmLyaCrcPN/1NrgZlFA=
Received: by 10.223.105.134 with SMTP id t6mr351711fao.81.1313534890991;
	Tue, 16 Aug 2011 15:48:10 -0700 (PDT)
Received: from [192.168.91.241] (chello084114015216.14.vie.surfer.at
	[84.114.15.216])
	by mx.google.com with ESMTPS id s14sm402323fah.29.2011.08.16.15.48.07
	(version=SSLv3 cipher=OTHER); Tue, 16 Aug 2011 15:48:09 -0700 (PDT)
In-Reply-To: <4E49A8EA.5020507-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
X-Mailer: Evolution 3.0.2 (3.0.2-3.fc15) 
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.6 (newer, 2)
X-Received-From: 209.85.161.41
X-BeenThere: bug-patch-mXXj517/zsQ@public.gmane.org
X-Mailman-Version: 2.1.14
Precedence: list
List-Id: "Bug reports, suggestions,
	general discussion for GNU patch." <bug-patch.gnu.org>
List-Unsubscribe: <https://lists.gnu.org/mailman/options/bug-patch>,
	<mailto:bug-patch-request-mXXj517/zsQ@public.gmane.org?subject=unsubscribe>
List-Archive: </archive/html/bug-patch>
List-Post: <mailto:bug-patch-mXXj517/zsQ@public.gmane.org>
List-Help: <mailto:bug-patch-request-mXXj517/zsQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/bug-patch>,
	<mailto:bug-patch-request-mXXj517/zsQ@public.gmane.org?subject=subscribe>
Errors-To: bug-patch-bounces+gcgpb-bug-patch=m.gmane.org-mXXj517/zsQ@public.gmane.org
Sender: bug-patch-bounces+gcgpb-bug-patch=m.gmane.org-mXXj517/zsQ@public.gmane.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179482>

Eric,

On Mon, 2011-08-15 at 17:16 -0600, Eric Blake wrote:
> It would have saved me a lot of time if both 'patch' and 'git apply' 
> could be taught a mode of operation where they explicitly reject a patch 
> that cannot be applied without relying on an offset.

that sounds reasonable.  Can you send a patch or at least add a bug on
Savannah?

> It might also be nice if patch could learn the algorithm that appears to 
> match the git behavior, where when there are multiple points with 
> identical context (viewing just the context in isolation), but where 
> those locations differ in function location (as learned by the @@ header 
> line in the patch file), then the preferred offset is the one in the 
> named function, even if that is not the closes context match to the line 
> number given in the patch file.

Sounds interesting; a patch for that would be great as well.

Thanks,
Andreas
