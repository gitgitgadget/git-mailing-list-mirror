From: Junio C Hamano <junkio@cox.net>
Subject: Re: Meaning of "fatal: protocol error: bad line length character"?
Date: Sat, 20 Jan 2007 11:33:38 -0800
Message-ID: <7vfya57ast.fsf@assigned-by-dhcp.cox.net>
References: <17842.1385.366750.915767@lisa.zopyra.com>
	<7vk5zh7b7d.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 20 20:33:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8LyG-0002DK-Eb
	for gcvg-git@gmane.org; Sat, 20 Jan 2007 20:33:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965297AbXATTdk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 20 Jan 2007 14:33:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965357AbXATTdk
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Jan 2007 14:33:40 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:38972 "EHLO
	fed1rmmtao01.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965297AbXATTdk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jan 2007 14:33:40 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070120193339.THPG9173.fed1rmmtao01.cox.net@fed1rmimpo02.cox.net>;
          Sat, 20 Jan 2007 14:33:39 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id DXZx1W0021kojtg0000000; Sat, 20 Jan 2007 14:33:57 -0500
To: Bill Lear <rael@zopyra.com>
In-Reply-To: <7vk5zh7b7d.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sat, 20 Jan 2007 11:24:54 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37283>

Junio C Hamano <junkio@cox.net> writes:

> Bill Lear <rael@zopyra.com> writes:
>
>> % git push
>> updating 'refs/heads/master'
>>   from 6b421066e842203e383e1dc466c1cdef10de56b1
>>   to   2a8e554ae0c99d44988690c9fce693b3f5f128fa
>> Generating pack...
>> Done counting 61 objects.
>> Result has 32 objects.
>> Deltifying 32 objects.
>>  100% (32/32) done
>> Writing 32 objects.
>>  100% (32/32) done
>> Total 32, written 32 (delta 18), reused 0 (delta 0)
>> Unpacking 32 objects
>> fatal: protocol error: bad line length character

By the way, I can see from the pack-objects output above that
you seem to be using git before commit 67c08ce1 (Nov 29, 2006);
most likely you are using the official 1.4.4.4?

Is it possible for you to try git built from the tip of 'master'
to see if it reproduces?
