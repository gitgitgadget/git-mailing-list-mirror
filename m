From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: newbie questions about git design and features (some wrt hg)
Date: Fri, 2 Feb 2007 19:44:13 +0100
Message-ID: <200702021944.14756.jnareb@gmail.com>
References: <3c6c07c20701300820l42cfc8dbsb80393fc1469f667@mail.gmail.com> <200702021818.11368.jnareb@gmail.com> <20070202173758.GC10108@waste.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: mercurial@selenic.com, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>
To: Matt Mackall <mpm@selenic.com>
X-From: git-owner@vger.kernel.org Fri Feb 02 20:10:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HD3nu-0001bo-Df
	for gcvg-git@gmane.org; Fri, 02 Feb 2007 20:10:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423039AbXBBTKb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Feb 2007 14:10:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423056AbXBBTKb
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Feb 2007 14:10:31 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:27175 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423039AbXBBTKb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Feb 2007 14:10:31 -0500
Received: by ug-out-1314.google.com with SMTP id 44so842303uga
        for <git@vger.kernel.org>; Fri, 02 Feb 2007 11:10:29 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=luH6zcCWHqTMFle67AEPp3BBIuqpgD2WdzCw7EL3Ereg69v6bQSILUtA4xFY1QN3/x4N0ibyscjBdHka3gZu0x6o2TgkWtnfWrDit0fiwSHgJDIOqrGZfMkSjr6coJiPHLowxcNuD2S3dqpGD1mcvfrYPlAqigeF9Sud8oJKx+I=
Received: by 10.67.26.7 with SMTP id d7mr4840875ugj.1170443429455;
        Fri, 02 Feb 2007 11:10:29 -0800 (PST)
Received: from host-81-190-29-4.torun.mm.pl ( [81.190.29.4])
        by mx.google.com with ESMTP id 54sm5842064ugp.2007.02.02.11.10.27;
        Fri, 02 Feb 2007 11:10:28 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20070202173758.GC10108@waste.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38526>

Matt Mackall wrote:
> On Fri, Feb 02, 2007 at 06:18:10PM +0100, Jakub Narebski wrote:

>> Revision-controlled (in-tree) tags are inane idea. Tags are non-moving
>> (and sometimes annotated) pointers to given point in history. They should
>> not depend on which branch you are, or what version you have checked out.
> 
> And.. they don't!

If that means that you always use the version of .hgtags from the tip
(branches are tips of history; they can have different .hgtags),
this is also broken; this means for example that you cannot compare
current version when on development head (branch) with tag on different
branch, those two branches have the same .hgtags file.

"They should not depend on which branch you are"... and they can.

> I'm now officially done correcting your uninformed perceptions. Come
> back when you've actually looked at the docs.

URL, pretty please?

My mistake is caused by the fact that .hgtags is special, i.e. not
current version is used (as e.g. with .scmignore files) but version
closest to the tip. This means broken abstraction.

-- 
Jakub Narebski
Poland
