From: Rich Pixley <rich.pixley@palm.com>
Subject: Re: Newbie grief
Date: Fri, 04 May 2012 14:29:28 -0700
Message-ID: <4FA44A38.1070704@palm.com>
References: <4F9F128C.5020304@palm.com> <201204302331.q3UNVo7o032303@no.baka.org>	<4F9F28F5.2020403@palm.com> <201205010137.q411bxaU002449@no.baka.org>	<4F9F52B9.9060508@palm.com> <08704bd2e32343a4b9def80e4fa1efa2-mfwitten@gmail.com> <4FA2D8EA.7030809@palm.com> <CAMP44s2w9B0Jvcn44R5_-ptC=x+5=OgGF0n0SkH+t0JjomXsGA@mail.gmail.com> <7v4nrvadzq.fsf@alter.siamese.dyndns.org> <CAMP44s0DwRZT2yEWVh89LeVPU1seu+SJwEdt-jy=4gssCedegg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Witten <mfwitten@gmail.com>,
	Seth Robertson <in-gitvger@baka.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 04 23:29:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQQ4W-0008JA-NG
	for gcvg-git-2@plane.gmane.org; Fri, 04 May 2012 23:29:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759768Ab2EDV3e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 May 2012 17:29:34 -0400
Received: from smtp-relay2.palm.com ([64.28.152.243]:23700 "EHLO
	smtp-relay2.palm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756491Ab2EDV3b (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2012 17:29:31 -0400
X-IronPort-AV: E=Sophos;i="4.75,533,1330934400"; 
   d="scan'208";a="13319634"
Received: from unknown (HELO ushqusdns3.palm.com) ([148.92.223.90])
  by smtp-relay2.palm.com with ESMTP; 04 May 2012 14:29:29 -0700
Received: from flamingo.palm.com ([148.92.244.134])
	by ushqusdns3.palm.com (8.14.4/8.14.4) with ESMTP id q44LTSDJ005579;
	Fri, 4 May 2012 14:29:28 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:12.0) Gecko/20120321 Thunderbird/12.0
In-Reply-To: <CAMP44s0DwRZT2yEWVh89LeVPU1seu+SJwEdt-jy=4gssCedegg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197075>

On 5/4/12 1:45 PM, Felipe Contreras wrote:
> It doesn't matter how you look at it; 'push -f' is not ideal.

Push -f offers an alternative that is available in other source code 
control systems, (not just mercurial), but not in git.  It's a bit of a 
culture shock to discover that it's not available in git.

> In the git world there's many ways to resolve this; push to another
> branch, push to another repo, allow ssh access to your machine, send
> the changes by mail, copy the git repo to a shared location, etc.
> *All* of those alternatives are better than 'push -f'.

In your opinion, and that's fine.  I don't need to argue this point any 
longer.  All of those other solutions are also available in the other 
source code control systems too.

> It seems to me that this *huge* thread basically boils down to Rich
> wanting 'hg push -f', when clearly that just creates problems, even in
> mercurial.

Actually, I wanted a work flow that was functional for me and supported 
a shared branch between multiple repositories.  I think I have a process 
for that now.  The key things I've learned so far are:

* Git can't cope with repository collisions, (in essence, because it's 
not willing to ever create multiple heads, but also because it doesn't 
track the entire pedigree of a branch, and because destructive rewrites 
on the repository are common in typical git usage).

The usual way to deal with this in the git world is to use geographical 
branches and triangles everywhere, but using "merge before push" can 
provide a way to use shared branches within git, (provided you can live 
within a fair number of restrictions, which I probably can.)

* That that cryptic message means that git would need to cope with a 
repository collision, which it can't do.  It doesn't actually mean that 
the repository is corrupt, which is what I took it to mean.

Frankly, if the cryptic message had been clearer, I probably would never 
have posted here.  I'd likely have figured out that git had this 
restriction and found a way to work around it on my own.

--rich
