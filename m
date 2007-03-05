From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCHv2] t/t5515-fetch-merge-logic.sh: Added tests for the merge login in git-fetch
Date: Mon, 05 Mar 2007 00:40:27 -0800
Message-ID: <7vfy8k13t0.fsf@assigned-by-dhcp.cox.net>
References: <87ps7oslwk.fsf@gmail.com> <87abyskt6k.fsf@gmail.com>
	<7vslck14ly.fsf@assigned-by-dhcp.cox.net>
	<20070305082846.GC12104@always.joy.eth.net>
	<8aa486160703050036r42701933k321e93d166e78575@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Joshua N Pritikin" <jpritikin@pobox.com>,
	"Junio C Hamano" <junkio@cox.net>,
	"Git Mailing List" <git@vger.kernel.org>
To: =?utf-8?Q?Santi_B=C3=A9jar?= <sbejar@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 05 09:40:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HO8kL-0007Vl-D5
	for gcvg-git@gmane.org; Mon, 05 Mar 2007 09:40:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932408AbXCEIk3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 5 Mar 2007 03:40:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932536AbXCEIk3
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Mar 2007 03:40:29 -0500
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:54804 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932408AbXCEIk2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Mar 2007 03:40:28 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070305084029.KHRN2807.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Mon, 5 Mar 2007 03:40:29 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id WwgT1W00M1kojtg0000000; Mon, 05 Mar 2007 03:40:28 -0500
In-Reply-To: <8aa486160703050036r42701933k321e93d166e78575@mail.gmail.com>
	(Santi =?utf-8?Q?B=C3=A9jar's?= message of "Mon, 5 Mar 2007 09:36:27
 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41423>

"Santi B=C3=A9jar" <sbejar@gmail.com> writes:

> On 3/5/07, Joshua N Pritikin <jpritikin@pobox.com> wrote:
>> On Mon, Mar 05, 2007 at 12:23:05AM -0800, Junio C Hamano wrote:
>> > Santi B=C3=A9jar <sbejar@gmail.com> writes:
>> > > P.D.: When sended this way the From: must be quoted or in UTF-8?
>> >
>> > Absolutely not.
>>
>> I think Junio meant that UTF-8 is OK. At least it is okay here in mu=
tt.
>
> OK, thanks. So the next question is if git-format-patch needs a flag
> to indicate that?

I do not think so.  It is a tool to produce a fake mailbox, and
when it says "From: " it really means it is producing the header
line.
