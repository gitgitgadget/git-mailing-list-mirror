From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [FAQ?] Rationale for git's way to manage the index
Date: Sun, 06 May 2007 20:23:05 +0200
Message-ID: <vpqbqgxak1i.fsf@bauges.imag.fr>
References: <vpqwszm9bm9.fsf@bauges.imag.fr>
	<alpine.LFD.0.98.0705060951460.25245@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 06 20:23:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HklON-0008FK-As
	for gcvg-git@gmane.org; Sun, 06 May 2007 20:23:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754910AbXEFSX2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 May 2007 14:23:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754928AbXEFSX2
	(ORCPT <rfc822;git-outgoing>); Sun, 6 May 2007 14:23:28 -0400
Received: from imag.imag.fr ([129.88.30.1]:33436 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754914AbXEFSX2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2007 14:23:28 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l46IN5pZ027469
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 6 May 2007 20:23:06 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1HklNx-0007mn-NY; Sun, 06 May 2007 20:23:05 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1HklNx-0003kF-LJ; Sun, 06 May 2007 20:23:05 +0200
Mail-Followup-To: git@vger.kernel.org
In-Reply-To: <alpine.LFD.0.98.0705060951460.25245@woody.linux-foundation.org> (Linus Torvalds's message of "Sun\, 6 May 2007 10\:25\:16 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.97 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Sun, 06 May 2007 20:23:06 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46358>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Sun, 6 May 2007, Matthieu Moy wrote:
>> 
>> But the fact that git actually remembers the _content_ of files in the
>> index, and that the default behavior for "commit" is to commit only
>> the content that is explicitely "git add"ed is something I've never
>> seen outside git.
>
> Yeah. You'd better get used to it, because it's fundamental.

Thanks a lot for the detailed explanations.

Note that I'm not "complaining", but just not understanding something.

(I would actually complain about the documentation not being clear
enough, but I'll try to complain with a contribution instead ;-) I'll
add something to the FAQ on the wiki, but it's down right now).

>  - You fundamentally cannot do it any other way.
>
>    Not doing it the way git does it (point to the content) means that the 
>    index-replacement has to point to something else, namely a "file ID". 

Well, git's index still tells more than "the content FOOBAR exists,
somewhere". It also "contains", if not "points to", the file name.

> What's so hard with adding that "-a" to "git commit"? You don't even need 
> it on the status line, the status is relevant and understandable (and 
> actually tells you more) even without it.

Off course, I don't have strong argument against it. The biggest
annoyance is that my fingers are used to "commit -m message", and now
type "commit -a message", but ...

The reason why I'm posting this is that I was wondering whether
"commit -a" not being the default was supposed to be a message like
"you shouln't use it too often".

It seems it isn't. I'll just get used to "commit -a" (and probably
alias it), and discover the actual benefits of the index little by
little.

> [...] it basically could be used ass a definition of CVS: [...]
                                   ^^^
Not sure this was intentional, but your spelling of "as" when used to
talk about CVS seems to reveal something about your state of mind ;-).

Thanks,

-- 
Matthieu
