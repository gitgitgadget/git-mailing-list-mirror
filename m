From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Merge commit before branch tip
Date: Mon, 26 Jul 2010 18:15:02 +0200
Message-ID: <vpqy6cyw77d.fsf@bauges.imag.fr>
References: <AANLkTikp5dHz97qp3pf+DE-wABNVYTGAQ+h30D9Fa04c@mail.gmail.com>
	<20100726160620.GA4399@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bradley Wagner <bradley.wagner@hannonhill.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 26 18:15:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdQKh-0006RD-KK
	for gcvg-git-2@lo.gmane.org; Mon, 26 Jul 2010 18:15:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753405Ab0GZQPI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jul 2010 12:15:08 -0400
Received: from mx2.imag.fr ([129.88.30.17]:51236 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752624Ab0GZQPH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jul 2010 12:15:07 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o6QGDMNh019114
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 26 Jul 2010 18:13:24 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1OdQKU-0000xT-8b; Mon, 26 Jul 2010 18:15:02 +0200
In-Reply-To: <20100726160620.GA4399@burratino> (Jonathan Nieder's message of "Mon\, 26 Jul 2010 11\:06\:20 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 26 Jul 2010 18:13:24 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o6QGDMNh019114
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1280765604.37444@SInE0ZyBUJKOYknHaBB00w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151853>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Hi Bradley,
>
> Bradley Wagner wrote:
>
>> I realize this is not a best practice but is it possible to merge a
>> branch but at a point before the branch tip?
>
> I do not even think it is not a best practice.  You can do
>
>   $ git fetch --all
>   $ git merge origin/master~1

... or whatever commit identifier indeed:

   $ git merge 64fdc08da

is fine too, but you have to find out the 64fdc08da part (using git
log for example).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
