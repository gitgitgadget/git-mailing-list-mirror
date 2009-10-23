From: Sebastian Pipping <sping@gentoo.org>
Subject: Re: requesting info page (and pdf) doc releases
Date: Fri, 23 Oct 2009 21:22:12 +0200
Message-ID: <4AE20264.2060207@gentoo.org>
References: <4AE0C362.3030900@gentoo.org> <f46c52560910221513w1cb19949lfa05ef964987d809@mail.gmail.com> <7vtyxqaqg5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Rustom Mody <rustompmody@gmail.com>, git@vger.kernel.org,
	"Robin H. Johnson" <robbat2@gentoo.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 23 21:22:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N1PiR-0002Xu-5h
	for gcvg-git-2@lo.gmane.org; Fri, 23 Oct 2009 21:22:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752901AbZJWTWM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Oct 2009 15:22:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752869AbZJWTWM
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Oct 2009 15:22:12 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:58150 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752845AbZJWTWM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Oct 2009 15:22:12 -0400
Received: from [192.168.0.3] (unknown [78.52.97.59])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.gentoo.org (Postfix) with ESMTP id BD4BE67372;
	Fri, 23 Oct 2009 19:22:15 +0000 (UTC)
User-Agent: Thunderbird 2.0.0.23 (X11/20091018)
In-Reply-To: <7vtyxqaqg5.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131120>

Junio C Hamano wrote:
> Rustom Mody <rustompmody@gmail.com> writes:
> 
>> On Fri, Oct 23, 2009 at 2:11 AM, Sebastian Pipping <sping@gentoo.org> wrote:
>>> would be nice to get info pages (and pdf) doc releases in addition to
>>> html and man pages.  i imagine such a change to the release machine
>>> should not be too hard to integrate.  we could use it in gentoo.
>> +1
>> Why only gentoo? I would use it on ubuntu or windows as well
> 
> As I understand it, Gentoo is supposed to build everything from the source
> anyway, you would not want to use pregenerated info nor pdf, no?  You
> shouldn't be using pregenerated html nor man for that matter...

With "compiling" documentation things are a bit different.
Simplified, in contrast to source code compiling documentation leads to
the same results on all machines while sources produces lots of
different results depending on the configuration of the machine ("use
flags", compile flags, versions of linked libraries, ..) which differ
heavily from one machine to another.

Generating documentation downstream means more dependencies for us
without any advantages that I would be aware of.  In case of dblatex the
dependencies get quite extreme actually :-)  So we thought why not just
ask for it if you provide similar things already.


> FWIW, you can already say "make info" and "make pdf" yourselves if you
> have necessary toolchains installed.  Integration is not an issue.

We use make info at the moment.  (On a sidenote I hope you get it
working with the latest asciidoc again.  See my earlier mail on this list.)


> Neither my primary development box (Debian, which I would test before
> pushing things out) nor the machine at k.org I use for the final sanity
> check (FC11, on which the documents are automatically generated) has
> dblatex nor docbook2x installed.  I am not particularly enthused about
> installing a lot of dependencies for these packages on my machine.  I do
> not want to bother k.org admins who are already overloaded to install
> these on their machines either.

I see, thanks for your explanation.



Sebastian
