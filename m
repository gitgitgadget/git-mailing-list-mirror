From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] repack: improve documentation on -a option
Date: Sat, 30 Jun 2007 10:19:36 -0700
Message-ID: <7v3b09e4wn.fsf@assigned-by-dhcp.cox.net>
References: <1183193781941-git-send-email-sam.vilain@catalyst.net.nz>
	<11831937813223-git-send-email-sam.vilain@catalyst.net.nz>
	<20070630111551.GR12721@planck.djpig.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sam Vilain <sam.vilain@catalyst.net.nz>, git@vger.kernel.org
To: Frank Lichtenheld <frank@lichtenheld.de>
X-From: git-owner@vger.kernel.org Sat Jun 30 19:20:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4gc6-0005pE-7E
	for gcvg-git@gmane.org; Sat, 30 Jun 2007 19:20:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756213AbXF3RTp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Jun 2007 13:19:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757336AbXF3RTn
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jun 2007 13:19:43 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:60202 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757283AbXF3RTh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jun 2007 13:19:37 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070630171936.SPAP3993.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Sat, 30 Jun 2007 13:19:36 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id HtKc1X00A1kojtg0000000; Sat, 30 Jun 2007 13:19:36 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51228>

Frank Lichtenheld <frank@lichtenheld.de> writes:

> On Sat, Jun 30, 2007 at 08:56:12PM +1200, Sam Vilain wrote:
>>  -a::
>>  	Instead of incrementally packing the unpacked objects,
>> -	pack everything available into a single pack.
>> +	pack everything referenced into a single pack.
>>  	Especially useful when packing a repository that is used
>> -	for private development and there is no need to worry
>> -	about people fetching via dumb file transfer protocols
>> -	from it.  Use with '-d'.
>> +	for private development and there no need to worry
>
> Got "is" lost here intentionally? The change doesn't make sense
> to me.
>
>> +	about people fetching via dumb protocols from it.  Use
>> +	with '-d'.  This will clean up the objects that `git prune`
>> +	leaves behind, but `git fsck-objects --full` shows as
>> +	dangling.

Also 'fsck-objects' is somewhat outdated.  Will fix them up.
