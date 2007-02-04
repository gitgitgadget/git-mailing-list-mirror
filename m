From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] config.txt: update branch.<name>.merge documentation
Date: Sat, 03 Feb 2007 16:38:30 -0800
Message-ID: <7v4pq221vd.fsf@assigned-by-dhcp.cox.net>
References: <87irejgsyj.fsf@gmail.com>
	<8aa486160702031630l4fd3e29did4f249713cf2ce81@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Yann Dirson <ydirson@altern.org>
To: =?iso-8859-1?Q?Santi_B=E9jar?= <sbejar@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 04 01:38:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDVOs-0000yb-U6
	for gcvg-git@gmane.org; Sun, 04 Feb 2007 01:38:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751626AbXBDAid convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 3 Feb 2007 19:38:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751635AbXBDAid
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Feb 2007 19:38:33 -0500
Received: from fed1rmmtai19.cox.net ([68.230.241.40]:44509 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751626AbXBDAic convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 Feb 2007 19:38:32 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070204003834.OSZM1349.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Sat, 3 Feb 2007 19:38:34 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id KCeY1W00E1kojtg0000000; Sat, 03 Feb 2007 19:38:32 -0500
In-Reply-To: <8aa486160702031630l4fd3e29did4f249713cf2ce81@mail.gmail.com>
	(Santi =?iso-8859-1?Q?B=E9jar's?= message of "Sun, 4 Feb 2007 01:30:02
 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38625>

"Santi B=E9jar" <sbejar@gmail.com> writes:

> On 2/3/07, Santi B=E9jar <sbejar@gmail.com> wrote:
>> --- a/Documentation/config.txt
>> +++ b/Documentation/config.txt
>> @@ -233,11 +233,12 @@ branch.<name>.remote::
>>  branch.<name>.merge::
>>         When in branch <name>, it tells `git fetch` the default refs=
pec to
>>         be marked for merging in FETCH_HEAD. The value has exactly t=
o match
>> -       a remote part of one of the refspecs which are fetched from =
the remote
>> -       given by "branch.<name>.remote".
>> +       the remote or local part of one of the refspecs which are fe=
tched
>> +       from the remote given by "branch.<name>.remote".
>
> It is OK, but ...

Yeah, but I am starting to think that it was a mistake to allow
an additional way to express the same thing.

Reverting 80c797764 would make the implementation to match the
specification described in the original.
