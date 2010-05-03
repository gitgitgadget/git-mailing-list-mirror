From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: WANTED: patch splitting tool - waypoints
Date: Mon, 03 May 2010 08:31:03 +0200
Message-ID: <vpqd3xdlcns.fsf@bauges.imag.fr>
References: <20100502115842.GA11607@brong.net>
	<vpqpr1euy7e.fsf@bauges.imag.fr> <20100502234058.GA1818@brong.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bron Gondwana <brong@fastmail.fm>
X-From: git-owner@vger.kernel.org Mon May 03 08:31:19 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8pBW-0006XL-Ol
	for gcvg-git-2@lo.gmane.org; Mon, 03 May 2010 08:31:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755967Ab0ECGbN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 May 2010 02:31:13 -0400
Received: from mx1.imag.fr ([129.88.30.5]:44332 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755325Ab0ECGbN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 May 2010 02:31:13 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o436PDFA028552
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 3 May 2010 08:25:13 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1O8pBH-00029r-GZ; Mon, 03 May 2010 08:31:03 +0200
In-Reply-To: <20100502234058.GA1818@brong.net> (Bron Gondwana's message of "Mon\, 3 May 2010 09\:40\:58 +1000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 03 May 2010 08:25:13 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o436PDFA028552
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1273472713.97711@d2et23wM/bpQXM33DGGqyQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146216>

Bron Gondwana <brong@fastmail.fm> writes:

> On Sun, May 02, 2010 at 05:20:53PM +0200, Matthieu Moy wrote:
>
>> About the "never made a mistake" part, if you mistakenly add a hunk
>> with "git add -p", then "git reset -p" (in recent enough Git's) is
>> your friend.
>
> Ooh, that's probably the bit that I was missing :)  Excellent.  I'll
> have a play and see how the workflow feels.

There's also "git stash -p", which may trigger another smiley ;-).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
