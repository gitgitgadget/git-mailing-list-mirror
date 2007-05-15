From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 01/10] Add a birdview-on-the-source-code section to the user manual
Date: Tue, 15 May 2007 01:55:19 -0700
Message-ID: <7v3b1ylb48.fsf@assigned-by-dhcp.cox.net>
References: <20070514181943.GA31749@diana.vm.bytemark.co.uk>
	<20070514183931.GC23090@fieldses.org>
	<20070515042200.GA10884@coredump.intra.peff.net>
	<20070515045044.GB2805@fieldses.org>
	<20070515050808.GA11745@coredump.intra.peff.net>
	<20070515082407.GA9096@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	"J. Bruce Fields" <bfields@fieldses.org>, git@vger.kernel.org
To: Karl =?utf-8?Q?Hasselstr=C3=B6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Tue May 15 10:55:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnsoZ-0004fa-PJ
	for gcvg-git@gmane.org; Tue, 15 May 2007 10:55:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757902AbXEOIzX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 15 May 2007 04:55:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758305AbXEOIzX
	(ORCPT <rfc822;git-outgoing>); Tue, 15 May 2007 04:55:23 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:64748 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757902AbXEOIzW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 May 2007 04:55:22 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070515085522.XUJJ13903.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Tue, 15 May 2007 04:55:22 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id zLvM1W0071kojtg0000000; Tue, 15 May 2007 04:55:22 -0400
In-Reply-To: <20070515082407.GA9096@diana.vm.bytemark.co.uk> (Karl
	=?utf-8?Q?Hasselstr=C3=B6m's?= message of "Tue, 15 May 2007 10:24:07
 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47330>

Karl Hasselstr=C3=B6m <kha@treskal.com> writes:

> On 2007-05-15 01:08:08 -0400, Jeff King wrote:
>
>> However, the content-type is already specified, so it shouldn't need
>> to rewrite. However, I notice that your original message is missing
>> a MIME-Version: 1.0 header. My guess is that vger's logic is that
>> without that header, it can't trust the Content-Type you have
>> provided (and indeed, not including MIME-Version violates the MIME
>> RFCs, I believe).
>
> You know, this rings a bell. I've discovered that a "MIME-Version:
> 1.0" is needed before. :-)
>
> "stg mail" used to have the same problem, until it was changed to use
> the Python e-mail libraries for all that stuff. And since then I
> haven't had problems with it.
>
>> I assumed this was a bug in git-send-email, but looking closer, it
>> doesn't put in any mime information at all! So your sending smtp
>> server is adding in the content-type header, but it's failing to add
>> the MIME-Version header, which I think is a bug (I can dig up the
>> RFC reference if you want).
>>
>> Arguably, git should be generating the full MIME header-set, since
>> it knows what actual encoding the message is in.
>
> I very much agree.

If the above statement meand git-send-email by "git" I would
very much agree.
