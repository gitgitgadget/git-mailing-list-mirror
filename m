From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 1/4] Documentation: minor grammatical fixes in git-archive.txt.
Date: Tue, 17 Mar 2009 10:18:17 +0100
Message-ID: <49BF6AD9.4020207@drmicha.warpmail.net>
References: <1237270577-17261-1-git-send-email-dmellor@whistlingcat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org
To: "David J. Mellor" <dmellor@whistlingcat.com>
X-From: git-owner@vger.kernel.org Tue Mar 17 10:20:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjVT0-0005N9-G2
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 10:20:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755469AbZCQJSe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2009 05:18:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755182AbZCQJSe
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 05:18:34 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:58580 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753860AbZCQJSd (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Mar 2009 05:18:33 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 882782F1F87;
	Tue, 17 Mar 2009 05:18:31 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Tue, 17 Mar 2009 05:18:31 -0400
X-Sasl-enc: 1yKceGtnouWSqCLrSAaosFNNtU5uFalIzfNgrHqxm6VE 1237281511
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id C4D4C14D28;
	Tue, 17 Mar 2009 05:18:30 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b4pre) Gecko/20090317 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <1237270577-17261-1-git-send-email-dmellor@whistlingcat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113446>

David J. Mellor venit, vidit, dixit 17.03.2009 07:16:
> Signed-off-by: David J. Mellor <dmellor@whistlingcat.com>
[replying to the first patch since there's no cover letter]

For patches like this one, I wish we had a robust way of using "git
format-patch --color-words"... "Robust" as in "working for most
recipients + git-am".

So I applied your series locally and checked the --color-words diff.
Nice work, all 4 of them!

One minor reoccurring issue is the following type of construct:

###
The good/bad input is logged, and:

------------
$ git bisect log
------------

shows what you have done so far.
###

The first line is not a complete sentence. Neither is the last one,
which you have to read together with the code inset (that's fine), which
on the other belongs to the sentence started in line 1.

All of the above constitutes 1 sentence and should not be chopped in
parts by the colon.

I know this construct is somewhat common, but I don't think it is
correct. In any case it disrupts the reading flow. [In fact, that
disruption is the very reason why it is sometimes used in the middle of
a written sentence: as a substitute for the rhetoric element "pause".]

In the example above your patch introduces it, in other places it has
been used before. So this might my an opportunity to get rid of it
consistently ;)

Michael
