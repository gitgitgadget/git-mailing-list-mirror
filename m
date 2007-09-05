From: David Kastrup <dak@gnu.org>
Subject: Re: People unaware of the importance of "git gc"?
Date: Wed, 05 Sep 2007 21:43:20 +0200
Message-ID: <85sl5shp9j.fsf@lola.goethe.zz>
References: <alpine.LFD.0.999.0709042355030.19879@evo.linux-foundation.org>
	<20070905174427.GC13314@fieldses.org>
	<Pine.LNX.4.64.0709051339420.30020@torch.nrlssc.navy.mil>
	<85642phqtn.fsf@lola.goethe.zz> <20070905191310.GE13314@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brandon Casey <casey@nrlssc.navy.mil>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Wed Sep 05 21:43:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IT0mk-0002c6-Fm
	for gcvg-git@gmane.org; Wed, 05 Sep 2007 21:43:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932170AbXIETna (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Sep 2007 15:43:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932192AbXIETna
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 15:43:30 -0400
Received: from mail-in-11.arcor-online.net ([151.189.21.51]:38908 "EHLO
	mail-in-11.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932170AbXIETn3 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Sep 2007 15:43:29 -0400
Received: from mail-in-04-z2.arcor-online.net (mail-in-04-z2.arcor-online.net [151.189.8.16])
	by mail-in-11.arcor-online.net (Postfix) with ESMTP id 8A2BA30182A;
	Wed,  5 Sep 2007 21:43:27 +0200 (CEST)
Received: from mail-in-06.arcor-online.net (mail-in-06.arcor-online.net [151.189.21.46])
	by mail-in-04-z2.arcor-online.net (Postfix) with ESMTP id 797E1ABEB1;
	Wed,  5 Sep 2007 21:43:27 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-072-218.pools.arcor-ip.net [84.61.72.218])
	by mail-in-06.arcor-online.net (Postfix) with ESMTP id 500C43664C8;
	Wed,  5 Sep 2007 21:43:23 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id BF1F11CAD71B; Wed,  5 Sep 2007 21:43:20 +0200 (CEST)
In-Reply-To: <20070905191310.GE13314@fieldses.org> (J. Bruce Fields's message of "Wed\, 5 Sep 2007 15\:13\:10 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.2/4166/Wed Sep  5 17:20:22 2007 on mail-in-06.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57753>

"J. Bruce Fields" <bfields@fieldses.org> writes:

> On Wed, Sep 05, 2007 at 09:09:40PM +0200, David Kastrup wrote:
>> Brandon Casey <casey@nrlssc.navy.mil> writes:
>> 
>> > On Wed, 5 Sep 2007, J. Bruce Fields wrote:
>> >
>> >> Well, this may just prove I'm an idiot, but one of the reasons I rarely
>> >> run it is that I have trouble remembering exactly what it does; in
>> >> particular,
>> >>
>> >> 	- does it prune anything that might be needed by a repo I
>> >> 	  cloned with -s?
>> >
>> >     YES! yikes.
>> >
>> > This is about the best argument put forth so far for not
>> > automatically running git-gc.
>> 
>> Well, it could also mean that if git finds a dead symbolic link when
>> looking up an object, it should check the corresponding link target
>> directory for a pack file with the respective object...  and if it
>> finds such a pack file, create a link to it and use it.
>
> One of the two of us is very confused about what "git-clone -s" does.
> See the git-clone man page.  I don't think symlinks are involved.

Guilty as charged.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
