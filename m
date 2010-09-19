From: Russ Allbery <rra@debian.org>
Subject: Re: git am should recognize >From
Date: Sun, 19 Sep 2010 11:01:47 -0700
Organization: The Eyrie
Message-ID: <87wrqheho4.fsf@windlord.stanford.edu>
References: <AANLkTin_5qzDkMU_1stYZcJpfW-W7K0kxy=0K2dA7SwO@mail.gmail.com>
	<AANLkTinOa+s-28PYXHhtKr_POu2D33ibfgKDKk4Wqi=9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	"Stefan-W. Hahn" <stefan.hahn@s-hahn.de>,
	Lukas =?utf-8?Q?Sandstr=C3=B6m?= <luksan@gmail.com>,
	Jeff King <peff@peff.net>,
	Christian Himpel <chressie@googlemail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 19 20:08:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxOJq-0001vp-OL
	for gcvg-git-2@lo.gmane.org; Sun, 19 Sep 2010 20:08:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755204Ab0ISSIf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Sep 2010 14:08:35 -0400
Received: from smtp2.Stanford.EDU ([171.67.219.82]:47195 "EHLO
	smtp.stanford.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754574Ab0ISSIf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Sep 2010 14:08:35 -0400
X-Greylist: delayed 405 seconds by postgrey-1.27 at vger.kernel.org; Sun, 19 Sep 2010 14:08:35 EDT
Received: from smtp.stanford.edu (localhost.localdomain [127.0.0.1])
	by localhost (Postfix) with SMTP id C6A84170A6F;
	Sun, 19 Sep 2010 11:01:49 -0700 (PDT)
Received: from windlord.stanford.edu (windlord.Stanford.EDU [171.67.225.134])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.stanford.edu (Postfix) with ESMTPS id 8C19C170A6C;
	Sun, 19 Sep 2010 11:01:47 -0700 (PDT)
Received: by windlord.stanford.edu (Postfix, from userid 1000)
	id 5EDB22F5AB; Sun, 19 Sep 2010 11:01:47 -0700 (PDT)
In-Reply-To: <AANLkTinOa+s-28PYXHhtKr_POu2D33ibfgKDKk4Wqi=9@mail.gmail.com>
	(Jonathan Nieder's message of "Sun, 19 Sep 2010 17:32:11 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156504>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Aside: it seems that many format-patch users are not using it to
> generate an mbox with a template message, as originally intended;

Myself included.  I don't like other things sending mail for me outside of
my normal mail client, since my normal mail client does lots of other
things (like know what From address to use, save copies of outgoing mail,
etc.).

> instead, they just write a cover letter and attach the generated patches
> to it. Are we not advertising the "am --scissors" facility[1] well
> enough?

That seems like a bad substitute for real MIME structure.  My experience
is that patches as actual MIME attachments fare much better and are much
less likely to be mangled when getting to the committer than patches
inlined in the body of a message.  (Yes, this is a 180 degree reversal
from the situation about ten years ago.)

Speaking of git am features, it would also be lovely if git am would
recognize and accept the format produced by git show, since a lot of
beginning Git users tend towards git show output instead of git
format-patch.

-- 
Russ Allbery (rra@debian.org)               <http://www.eyrie.org/~eagle/>
