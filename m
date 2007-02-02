From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: newbie questions about git design and features (some wrt hg)
Date: Fri, 2 Feb 2007 20:56:31 +0100
Message-ID: <200702022056.32791.jnareb@gmail.com>
References: <3c6c07c20701300820l42cfc8dbsb80393fc1469f667@mail.gmail.com> <20070202173758.GC10108@waste.org> <200702021944.14756.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: mercurial@selenic.com, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>
To: Matt Mackall <mpm@selenic.com>
X-From: git-owner@vger.kernel.org Fri Feb 02 20:55:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HD4VN-00057B-0w
	for gcvg-git@gmane.org; Fri, 02 Feb 2007 20:55:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423199AbXBBTzR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Feb 2007 14:55:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423204AbXBBTzR
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Feb 2007 14:55:17 -0500
Received: from wr-out-0506.google.com ([64.233.184.232]:38454 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423199AbXBBTzM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Feb 2007 14:55:12 -0500
Received: by wr-out-0506.google.com with SMTP id 68so808688wri
        for <git@vger.kernel.org>; Fri, 02 Feb 2007 11:55:12 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=SAPuySoyYMMolf5k9iOYhjBzmRNPAEVmP93DX+ZhY+dzpRlFmk/tOkugTYFt8JyU7MyWYcT/G58p2mR/G3VAoa5G/mgw9dSZV+iQT8+lRW8Mb9VBI/O2XCPghtBn727iXv/BwXGiJ1TlVOWJ9WdYntn1hv/OUo+MnNiuu+yq5FY=
Received: by 10.78.193.19 with SMTP id q19mr860369huf.1170446110911;
        Fri, 02 Feb 2007 11:55:10 -0800 (PST)
Received: from host-81-190-29-4.torun.mm.pl ( [81.190.29.4])
        by mx.google.com with ESMTP id z40sm4789949ugc.2007.02.02.11.55.10;
        Fri, 02 Feb 2007 11:55:10 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <200702021944.14756.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38532>

Jakub Narebski wrote:
> Matt Mackall wrote:
>> On Fri, Feb 02, 2007 at 06:18:10PM +0100, Jakub Narebski wrote:
> 
>>> Revision-controlled (in-tree) tags are inane idea. Tags are non-moving
>>> (and sometimes annotated) pointers to given point in history. They should
>>> not depend on which branch you are, or what version you have checked out.
>> 
>> And.. they don't!
> 
> If that means that you always use the version of .hgtags from the tip
> (branches are tips of history; they can have different .hgtags),
> this is also broken; this means for example that you cannot compare
> current version when on development head (branch) with tag on different
> branch, those two branches have the same .hgtags file.

I meant to write:

..._unless_ those two branches have the same .hgtags file.

> "They should not depend on which branch you are"... and they can.

For example you are on branch 'master', you tag current release
e.g. v1.3.4, then you checkout branch 'devel'... and you don't have
v1.3.4 tag available unless you merge in .hgtags from 'master'.
At least from what I understand of Mercurial tags behaviour.

Having to create a commit to remember tag which can be published...
I'm not sure if it is a good idea either. Junio creates "GIT 1.4.4.3"
commits, ant those are tagges, so perhaps it is not so bad idea
either.

You encourage to hand-edit .hgtags, but the edited version might
not be the one that is used (for example when starting a branch).

-- 
Jakub Narebski
Poland
