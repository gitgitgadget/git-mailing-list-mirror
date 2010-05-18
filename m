From: "Anthony W. Youngman" <wol@thewolery.demon.co.uk>
Subject: Re: What should be the CRLF policy when win + Linux?
Date: Tue, 18 May 2010 16:13:50 +0100
Message-ID: <U4$sctFu6q8LFwWA@thewolery.demon.co.uk>
References: <4BE141E3.2060904@gmail.com>
 <x2h600158c31005051935i6f379a9j6aa36b4503776b87@mail.gmail.com>
 <o2ved79be1d1005060029n67f451c6p3b48b83c51031222@mail.gmail.com>
 <i2i600158c31005060834s72e10fb7te19048e3b174d29b@mail.gmail.com>
 <alpine.LFD.2.00.1005061009020.901@i5.linux-foundation.org>
 <h2x600158c31005061300tfe485e01x251ae20b22ef5b27@mail.gmail.com>
 <x2s40aa078e1005061340vaf404ab3g30b2b98ca408205@mail.gmail.com>
 <w2h600158c31005061514m1fc1e75ay9096eb27d9a1a4ba@mail.gmail.com>
 <o2v40aa078e1005061625md5fede79h660a22227c4f22d1@mail.gmail.com>
Reply-To: "Anthony W. Youngman" <wol@thewolery.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;charset=us-ascii;format=flowed
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 18 17:15:17 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OEOVm-0000Hn-JB
	for gcvg-git-2@lo.gmane.org; Tue, 18 May 2010 17:15:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751894Ab0ERPPK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 May 2010 11:15:10 -0400
Received: from anchor-post-3.mail.demon.net ([195.173.77.134]:34340 "EHLO
	anchor-post-3.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750914Ab0ERPPI (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 May 2010 11:15:08 -0400
Received: from dyn-62-56-65-222.dslaccess.co.uk ([62.56.65.222] helo=thewolery.demon.co.uk)
	by anchor-post-3.mail.demon.net with esmtpa (AUTH thewolery)
	(Exim 4.69)
	id 1OEOVe-00075d-nA
	for git@vger.kernel.org; Tue, 18 May 2010 15:15:06 +0000
In-Reply-To: <o2v40aa078e1005061625md5fede79h660a22227c4f22d1@mail.gmail.com>
User-Agent: Turnpike/6.07-M (<UJe6Tll4PTCam3mvYGb+2+qght>)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147284>

In message 
<o2v40aa078e1005061625md5fede79h660a22227c4f22d1@mail.gmail.com>, Erik 
Faye-Lund <kusmabite@googlemail.com> writes
>Closed source does not imply a single operating system, and you get
>these issues whenever you have a project with targets systems with
>different newline style. In my day job I develop closed source,
>multi-platform software, using git. So it's certainly not MY most
>common scenario.

And there's a lot more line endings out there than just lf or crlf.

Okay, the two I'm about to quote have, I believe, gone the way of the 
dinosaur, but wasn't the mac just cr? And what is *still* my favourite 
system, Prime (a multics derivative too), used a "packed lf", so your 
line ending could be either lf or lfnull depending on the line length 
(it was always stored on disk as an integral word-length, a word being 
16 bits. So if your text was an even number of characters, the ending 
was lfnull to pad it to the next word boundary).

Cheers,
Wol
-- 
Anthony W. Youngman - anthony@thewolery.demon.co.uk
