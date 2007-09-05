From: David Kastrup <dak@gnu.org>
Subject: Re: People unaware of the importance of "git gc"?
Date: Wed, 05 Sep 2007 21:09:40 +0200
Message-ID: <85642phqtn.fsf@lola.goethe.zz>
References: <alpine.LFD.0.999.0709042355030.19879@evo.linux-foundation.org>
	<20070905174427.GC13314@fieldses.org>
	<Pine.LNX.4.64.0709051339420.30020@torch.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "J. Bruce Fields" <bfields@fieldses.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Wed Sep 05 21:09:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IT0G8-0001LX-4h
	for gcvg-git@gmane.org; Wed, 05 Sep 2007 21:09:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755298AbXIETJr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Sep 2007 15:09:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755279AbXIETJr
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 15:09:47 -0400
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:52806 "EHLO
	mail-in-04.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754791AbXIETJr (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Sep 2007 15:09:47 -0400
Received: from mail-in-01-z2.arcor-online.net (mail-in-01-z2.arcor-online.net [151.189.8.13])
	by mail-in-04.arcor-online.net (Postfix) with ESMTP id ADF1917FD85;
	Wed,  5 Sep 2007 21:09:45 +0200 (CEST)
Received: from mail-in-08.arcor-online.net (mail-in-08.arcor-online.net [151.189.21.48])
	by mail-in-01-z2.arcor-online.net (Postfix) with ESMTP id 9BB4F13C44F;
	Wed,  5 Sep 2007 21:09:45 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-072-218.pools.arcor-ip.net [84.61.72.218])
	by mail-in-08.arcor-online.net (Postfix) with ESMTP id 55A202F28E2;
	Wed,  5 Sep 2007 21:09:41 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id DD0EF1CAD71B; Wed,  5 Sep 2007 21:09:40 +0200 (CEST)
In-Reply-To: <Pine.LNX.4.64.0709051339420.30020@torch.nrlssc.navy.mil> (Brandon Casey's message of "Wed\, 5 Sep 2007 13\:46\:42 -0500 \(CDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.2/4166/Wed Sep  5 17:20:22 2007 on mail-in-08.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57741>

Brandon Casey <casey@nrlssc.navy.mil> writes:

> On Wed, 5 Sep 2007, J. Bruce Fields wrote:
>
>> Well, this may just prove I'm an idiot, but one of the reasons I rarely
>> run it is that I have trouble remembering exactly what it does; in
>> particular,
>>
>> 	- does it prune anything that might be needed by a repo I
>> 	  cloned with -s?
>
>     YES! yikes.
>
> This is about the best argument put forth so far for not
> automatically running git-gc.

Well, it could also mean that if git finds a dead symbolic link when
looking up an object, it should check the corresponding link target
directory for a pack file with the respective object...  and if it
finds such a pack file, create a link to it and use it.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
