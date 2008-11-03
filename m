From: Kalle Olavi Niemitalo <kon@iki.fi>
Subject: Re: [PATCH] asciidoc: add minor workaround to add an empty line after code blocks
Date: Mon, 03 Nov 2008 02:12:01 +0200
Message-ID: <87k5blsm5q.fsf@Astalo.kon.iki.fi>
References: <87skqfus7v.fsf@iki.fi>
	<2c6b72b30810291235j554cc21dw4e3da4fdbfe633ee@mail.gmail.com>
	<87od13ujm4.fsf@iki.fi> <20081030104503.GA17131@diku.dk>
	<7v7i7n3vwe.fsf@gitster.siamese.dyndns.org>
	<18071eea0811011642g6bc36530sf2036ef15ce0df82@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 03 01:13:26 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kwn4N-0004pA-O3
	for gcvg-git-2@gmane.org; Mon, 03 Nov 2008 01:13:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753966AbYKCAMH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Nov 2008 19:12:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753947AbYKCAMG
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Nov 2008 19:12:06 -0500
Received: from smtp1.dnainternet.fi ([87.94.96.108]:60202 "EHLO
	smtp1.dnainternet.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753945AbYKCAMF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Nov 2008 19:12:05 -0500
Received: from Astalo.kon.iki.fi (85-23-32-64-Rajakyla-TR1.suomi.net [85.23.32.64])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp1.dnainternet.fi (Postfix) with ESMTP id 307F4CCAA
	for <git@vger.kernel.org>; Mon,  3 Nov 2008 02:12:01 +0200 (EET)
Received: from Kalle by Astalo.kon.iki.fi with local (Exim 4.52)
	id 1Kwn33-0006Jm-Fx; Mon, 03 Nov 2008 02:12:01 +0200
In-Reply-To: <18071eea0811011642g6bc36530sf2036ef15ce0df82@mail.gmail.com>
	(Thomas Adam's message of "Sat, 1 Nov 2008 23:42:44 +0000")
User-Agent: Gnus/5.110007 (No Gnus v0.7) Emacs/23.0.51 (gnu/linux)
X-Accept-Language: fi;q=1.0, en;q=0.9, sv;q=0.5, de;q=0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99893>

"Thomas Adam" <thomas.adam22@gmail.com> writes:

> Something the ELinks project does is distribute a fixed version
> of the asciidoc script to avoid annoying asciidoc errors each
> time there's a new asciidoc release.

Actually, we only distribute the AsciiDoc configuration files.
I should perhaps add the actual asciidoc Python script to the
ELinks source tree as well.  That seems to be the recommendation
in the AsciiDoc manual.

http://www.methods.co.nz/asciidoc/userguide.html#_shipping_stand_alone_asciidoc_source
