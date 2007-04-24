From: Junio C Hamano <junkio@cox.net>
Subject: Re: gitattributes
Date: Tue, 24 Apr 2007 14:40:18 -0700
Message-ID: <7v4pn55u4d.fsf@assigned-by-dhcp.cox.net>
References: <1f6632e50704240436l4a81d8c9s1bbf95a7892db68c@mail.gmail.com>
	<81b0412b0704240918t70bfb3bt5f0e6e85028be5e6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Matthias Kestenholz" <lists@spinlock.ch>, git@vger.kernel.org
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 24 23:40:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgSkL-0004ep-KQ
	for gcvg-git@gmane.org; Tue, 24 Apr 2007 23:40:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423133AbXDXVkW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Apr 2007 17:40:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423142AbXDXVkW
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Apr 2007 17:40:22 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:63328 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423133AbXDXVkV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2007 17:40:21 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070424214018.PGDJ1218.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Tue, 24 Apr 2007 17:40:18 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id r9gJ1W0031kojtg0000000; Tue, 24 Apr 2007 17:40:18 -0400
In-Reply-To: <81b0412b0704240918t70bfb3bt5f0e6e85028be5e6@mail.gmail.com>
	(Alex Riesen's message of "Tue, 24 Apr 2007 18:18:15 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45491>

"Alex Riesen" <raa.lkml@gmail.com> writes:

> On 4/24/07, Matthias Kestenholz <lists@spinlock.ch> wrote:
>> The .gitattributes system together with input/output filters has already
>> proven exceptionally useful for me. I've got some co-workers which
>> do not seem to care about CRLF line endings or whitespace damage.
>>
>> core.autocrlf = input
>>
>> and
>>
>> [filter "whitespace"]
>>   clean = stripspace
>>   smudge = cat
>>
>
> Why didn't --ignore-space-at-eol, -b and -w work for you?

It should.  What Matthias would want more is probably to have
others to have the "clean" side of the filter in their working
repository.
