From: Junio C Hamano <gitster@pobox.com>
Subject: Re: That improved git-gui blame viewer..
Date: Mon, 11 Jun 2007 23:52:38 -0700
Message-ID: <7vbqflll55.fsf@assigned-by-dhcp.pobox.com>
References: <alpine.LFD.0.98.0706091117510.20321@woody.linux-foundation.org>
	<20070611064203.GG6073@spearce.org>
	<alpine.LFD.0.98.0706110826590.14121@woody.linux-foundation.org>
	<7vveduqxxr.fsf@assigned-by-dhcp.pobox.com>
	<e5bfff550706112316j42c7c8e8uf8383de990ca9707@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Marco Costalba" <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 12 08:52:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hy0FB-0002Pe-Bc
	for gcvg-git@gmane.org; Tue, 12 Jun 2007 08:52:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751109AbXFLGwk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jun 2007 02:52:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751165AbXFLGwk
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jun 2007 02:52:40 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:50733 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751109AbXFLGwj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2007 02:52:39 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070612065239.BXM4247.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Tue, 12 Jun 2007 02:52:39 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id AWse1X0081kojtg0000000; Tue, 12 Jun 2007 02:52:39 -0400
In-Reply-To: <e5bfff550706112316j42c7c8e8uf8383de990ca9707@mail.gmail.com>
	(Marco Costalba's message of "Tue, 12 Jun 2007 08:16:01 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49927>

"Marco Costalba" <mcostalba@gmail.com> writes:

> On 6/11/07, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> An option to re-blame starting from the parent commit of what is
>> currently blamed (i.e. "peel" one level) would certainly be
>> interesting but I do not think git-gui has it (yet).
>
> Not to advertise, but qgit has already that from ages.

Advertising is good.

> Annotate algorithm of qgit is little different in that it starts from
> the oldest revision that modified a file and goes to the latest. In
> this way we can have the whole file history annotated in one pass and
> very fast.

I am not sure about two things in this description.

 (1) Are you emulating CVS-like "a file has an identity, and we
     follow its changes" model?  How does it handle file split,
     merge, and code movement in general?

 (2) It is unclear why going from old to new has the advantage
     of being "one pass", implication of which is that the
     opposite direction needs to be done as more than one pass.
     Care to enlighten?
