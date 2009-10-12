From: Salvatore Mangano <smangano@into-technology.com>
Subject: Re: Supressing sorting of trees
Date: Mon, 12 Oct 2009 16:02:37 -0400
Message-ID: <DF65B4B0-62B1-4469-99E1-3305434F9D59@into-technology.com>
References: <loom.20091012T152113-874@post.gmane.org> <20091012142032.GG9261@spearce.org> <loom.20091012T171550-239@post.gmane.org> <alpine.DEB.1.00.0910121803360.4985@pacific.mpi-cbg.de> <loom.20091012T182258-9@post.gmane.org> <46a038f90910121236x6bbe258bwa3bc3fdcc54de524@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1076)
Content-Type: text/plain; charset=us-ascii; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 12 22:11:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxRFL-0006oZ-Ap
	for gcvg-git-2@lo.gmane.org; Mon, 12 Oct 2009 22:11:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758067AbZJLUJz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 16:09:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758064AbZJLUJz
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 16:09:55 -0400
Received: from smtp100.biz.mail.re2.yahoo.com ([206.190.52.46]:27965 "HELO
	smtp100.biz.mail.re2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756807AbZJLUJz (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Oct 2009 16:09:55 -0400
X-Greylist: delayed 384 seconds by postgrey-1.27 at vger.kernel.org; Mon, 12 Oct 2009 16:09:54 EDT
Received: (qmail 18639 invoked from network); 12 Oct 2009 20:02:38 -0000
Received: from ool-18bd213f.dyn.optonline.net (smangano@24.189.33.63 with plain)
        by smtp100.biz.mail.re2.yahoo.com with SMTP; 12 Oct 2009 13:02:38 -0700 PDT
X-Yahoo-SMTP: qbT9X2CswBA222ZOezn1LxwRX_.l9JM-
X-YMail-OSG: EfiHzHMVM1nlAGiNyfJNECzWqtNv8DWVGsbGY5gy927HNBfH7B5gd48XY3FsYVgav7Y9cYPWjPz.XKbPFo5rN838OR1rm30o_7X5vUEZ_bLvUzdeG0gVrCmKMa.o89YLOlO5lkBG6SajBKrz4DpYgRTaDCzrlowyQxr_ZJWRe.QNE1ST4snR1wWR2nOdd9WLzKyo_bZxUzMmktQq_3NTJU8qVPQo5Z80XwkewP1rlBML5OxGDZQnAttauBVdgEABLC0_SIwGJS5cHAoStkJOl_CWjL1lyYaBNPnIWJhrCl33TU.KpKMeG2gETd9Ofs8T7HJiV0I9xveU5iT.NEs6QyZo55e7siuY3oB9z096cfraIU1oBTBu9SfNr1HR_qYO5Ww-
X-Yahoo-Newman-Property: ymail-3
In-Reply-To: <46a038f90910121236x6bbe258bwa3bc3fdcc54de524@mail.gmail.com>
X-Mailer: Apple Mail (2.1076)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130060>


On Oct 12, 2009, at 3:36 PM, Martin Langhoff wrote:

> On Mon, Oct 12, 2009 at 6:51 PM, Sal Mangano
> <smangano@into-technology.com> wrote:
>> 2) I can use Git unchanged but preserve order by storing some  
>> information in
>> each sub tree (e.g. an extra blob) which retains the real order. I  
>> can also
>
> This #2 is your best bet by far. An extra blob in each subdir is just
> one option, you can handle this "extra metadata" in a number of ways
> -- maybe external to git, on a separate history will work best.
>
> The downsides of messing with internal tree handling of git are so
> staggering that you'd do better to throw git away.
>
> (this is from experience of abusing git to various purposes that have
> little to do with version control :-) )
>
> In other words: Shaun and Dscho are right, so right that it hurts.
>

Thanks Martin. I suspect you, Shaun and Dscho are correct. But, can  
anyone point to specific code
that would allow me to see first hand that this is hopeless. So far,  
based on the code I looked at, I see
it as problematic but not hopeless. Here I define "problematic" as  
having to change a few files and/or
avoid using some features while "hopeless" meaning I'd have to change  
almost very single plumbing
command.
