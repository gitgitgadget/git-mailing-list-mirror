From: Ted Zlatanov <tzz@lifelogs.com>
Subject: Re: netrc credential helper promotion out of contrib?
Date: Tue, 03 Sep 2013 11:12:07 -0400
Organization: =?utf-8?B?0KLQtdC+0LTQvtGAINCX0LvQsNGC0LDQvdC+0LI=?= @
 Cienfuegos
Message-ID: <87ob8ahrco.fsf@lifelogs.com>
References: <87k3jjp9q5.fsf@lifelogs.com>
	<xmqqvc305fh4.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 03 17:12:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGsHH-0000EG-Ll
	for gcvg-git-2@plane.gmane.org; Tue, 03 Sep 2013 17:12:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754221Ab3ICPMU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Sep 2013 11:12:20 -0400
Received: from plane.gmane.org ([80.91.229.3]:42030 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754095Ab3ICPMT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Sep 2013 11:12:19 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1VGsHB-0000Bu-N8
	for git@vger.kernel.org; Tue, 03 Sep 2013 17:12:17 +0200
Received: from c-98-229-61-72.hsd1.ma.comcast.net ([98.229.61.72])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 03 Sep 2013 17:12:17 +0200
Received: from tzz by c-98-229-61-72.hsd1.ma.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 03 Sep 2013 17:12:17 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: c-98-229-61-72.hsd1.ma.comcast.net
X-Face: bd.DQ~'29fIs`T_%O%C\g%6jW)yi[zuz6;d4V0`@y-~$#3P_Ng{@m+e4o<4P'#(_GJQ%TT= D}[Ep*b!\e,fBZ'j_+#"Ps?s2!4H2-Y"sx"
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/24.3.50 (gnu/linux)
Cancel-Lock: sha1:knWyqP6TSpyBfe86ukhJpW5NL9Y=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233728>

On Tue, 20 Aug 2013 12:28:39 -0700 Junio C Hamano <gitster@pobox.com> wrote: 

JCH> Ted Zlatanov <tzz@lifelogs.com> writes:
>> A while has passed since contrib/credential/netrc was added. Is it OK to
>> promote it to be part of the main installation?

JCH> I gave it a quick glance, and it seems to be cleanly written, except
JCH> that "EOHIPPUS" (End-of-Hippus?  Eohippus the extinct horse?) looked
JCH> a bit too strange to my taste ;-).  It does not seem to use features
JCH> older versions of Perl some people are stuck with do not support.

Thanks, I was careful about that.  `EOF' as the end-of-document marker
is a bit boring, don't you think?  Well, I can use it here if you
insist, but it seems OK to me.

JCH> I do not mind seeing a patch that moves contrib/credential/netrc to
JCH> credential/netrc and adjusts the top-level Makefile.  The test
JCH> script needs to be updated to fit the rest of t/ hierarchy better,
JCH> though.

OK, I will work on that patch.  Thanks for the reply.

Ted
