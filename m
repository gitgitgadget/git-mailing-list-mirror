From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Avoid C++ comments, use C comments instead
Date: Mon, 10 Jul 2006 17:34:07 -0700
Message-ID: <7vbqrx6ku8.fsf@assigned-by-dhcp.cox.net>
References: <20060710065751.22902.43316.stgit@dv.roinet.com>
	<7vzmfhdhrf.fsf@assigned-by-dhcp.cox.net>
	<20060710094653.GA52962@dspnet.fr.eu.org>
	<Pine.LNX.4.63.0607101306030.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	<20060710114117.GA62514@dspnet.fr.eu.org>
	<44B2A709.8020500@serice.net> <20060710202412.GA8189@dspnet.fr.eu.org>
	<Pine.LNX.4.63.0607110049470.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	<f36b08ee0607101625y6eaec83ck22dd20b4f27a1846@mail.gmail.com>
	<20060710235122.GB26528@dspnet.fr.eu.org>
	<20060711001504.GA10700@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 11 02:34:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G06Cb-0002aP-4j
	for gcvg-git@gmane.org; Tue, 11 Jul 2006 02:34:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751393AbWGKAeL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Jul 2006 20:34:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751395AbWGKAeK
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Jul 2006 20:34:10 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:40947 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1751393AbWGKAeJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jul 2006 20:34:09 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060711003408.SQDO985.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 10 Jul 2006 20:34:08 -0400
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060711001504.GA10700@spearce.org> (Shawn Pearce's message of
	"Mon, 10 Jul 2006 20:15:05 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23676>

Shawn Pearce <spearce@spearce.org> writes:

> Olivier Galibert <galibert@pobox.com> wrote:
>>
>> Maybe git can be perfectly happy with c89.  I don't know.  I know the
>> linux kernel requires c99, mostly for the struct initializers.  My
>> point was that staying at the c89 level has a maintainance cost, and a
>> cost/benefit analysis should be done to decide whether it is a good
>> idea.

I am generally in favor of the effect C99 struct and array
initializers have on the readability, but we also need to
balance that with the reality.  The patch is only about a few
structs and one array if I recall correctly isn't it?

What Olivier says is perfectly correct, and after "cost/benefit
analysis", I would have to say avoiding some C99 is fine if that
makes people's life on some major non-Linux platforms easier.

C99 clean-up is already in the "master", so please do not waste
more bandwidth nor time on this issue, but instead spend time
elsewhere to make our system better for more people ;-).

Thanks.
