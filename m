From: Aharon Robbins <arnold@skeeve.com>
Subject: Re: Fwd: What's cooking in git.git (Aug 2010, #04; Wed, 18)
Date: Thu, 19 Aug 2010 21:05:10 +0300
Message-ID: <201008191805.o7JI5Aw0002340@localhost.localdomain>
References: <7vfwyb8skr.fsf@alter.siamese.dyndns.org>
 <20100819030237.GE18922@burratino> <4C6CE61F.7060305@viscovery.net>
 <AANLkTi=z6rs5U8N_piUUzR=t6oSNNF02RxVCws-1YRS1@mail.gmail.com>
 <AANLkTinkjsLycvV-uvfG14t7Q=uKt+pnpizKCPGirVW1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, gitster@pobox.com, jrnieder@gmail.com,
	j.sixt@viscovery.net
To: avarab@gmail.com
X-From: git-owner@vger.kernel.org Thu Aug 19 20:20:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Om9j1-00021i-Um
	for gcvg-git-2@lo.gmane.org; Thu, 19 Aug 2010 20:20:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754334Ab0HSSUW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Aug 2010 14:20:22 -0400
Received: from mxout1.netvision.net.il ([194.90.9.20]:33947 "EHLO
	mxout1.netvision.net.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752973Ab0HSSUV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Aug 2010 14:20:21 -0400
X-Greylist: delayed 902 seconds by postgrey-1.27 at vger.kernel.org; Thu, 19 Aug 2010 14:20:20 EDT
Received: from skeeve.com ([46.116.84.107]) by mxout1.netvision.net.il
 (Sun Java(tm) System Messaging Server 7u3-15.01 64bit (built Feb 12 2010))
 with ESMTPA id <0L7E00DOIVKO46F0@mxout1.netvision.net.il> for
 git@vger.kernel.org; Thu, 19 Aug 2010 21:05:13 +0300 (IDT)
Received: from localhost.localdomain (localhost [127.0.0.1])
	by skeeve.com (8.14.3/8.14.3) with ESMTP id o7JI5CxB002341; Thu,
 19 Aug 2010 21:05:12 +0300
Received: (from arnold@localhost)
	by localhost.localdomain (8.14.3/8.14.3/Submit) id o7JI5Aw0002340; Thu,
 19 Aug 2010 21:05:10 +0300
In-reply-to: <AANLkTinkjsLycvV-uvfG14t7Q=uKt+pnpizKCPGirVW1@mail.gmail.com>
User-Agent: Heirloom mailx 12.4 7/29/08
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153946>

Hi! Re this:

> Date: Thu, 19 Aug 2010 13:16:56 +0000
> Subject: Fwd: What's cooking in git.git (Aug 2010, #04; Wed, 18)
> From: ??var Arnfj??r?? Bjarmason <avarab@gmail.com>
> To: "Arnold D. Robbins" <arnold@skeeve.com>
>
> Hi there. The Git project grabbed the gawk regex engine to use as a
> compat engine in case the platform we're working on doesn't support
> REG_STARTEND. But because we don't compile it with RE_ENABLE_I18N
> it'll spew some warnings about unused variables (see below). Here's a
> patch to solve this:

Wow! It's really cool to be upstream for someone else. :-)

Thanks for the patch. I'll get it into my code base.

> I was going to report this upstream once I got around to finding out
> what upstream *is*, I don't *think* gawk itself is the canonical
> upstream, they just copy it from somewhere else (again, I *think*).

About every year or so, I sync from whatever is in GLIBC.  But my version
has a number of additional fixes that have not been accepted back into
the GLIBC version.

The only other possible candidate for an "upstream" source would be the
version in gnulib.

HTH,

Arnold
