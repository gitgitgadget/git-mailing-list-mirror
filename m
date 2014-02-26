From: Simon Ruderich <simon@ruderich.org>
Subject: Re: `git stash pop` UX Problem
Date: Wed, 26 Feb 2014 01:39:39 +0100
Message-ID: <20140226003938.GA6809@ruderich.org>
References: <530B0395.5030407@booking.com>
 <CANUGeEbPrPp8Sa-KEKSxNDWJShdkDBTkQyXv7tDJ6ReH6MXrHw@mail.gmail.com>
 <vpqlhx0a3cb.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Brandon McCaig <bamccaig@gmail.com>,
	Omar Othman <omar.othman@booking.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Feb 26 01:44:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIScG-0001UU-Vk
	for gcvg-git-2@plane.gmane.org; Wed, 26 Feb 2014 01:44:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751134AbaBZAot (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Feb 2014 19:44:49 -0500
Received: from zucker.schokokeks.org ([178.63.68.96]:46837 "EHLO
	zucker.schokokeks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750800AbaBZAos (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Feb 2014 19:44:48 -0500
X-Greylist: delayed 301 seconds by postgrey-1.27 at vger.kernel.org; Tue, 25 Feb 2014 19:44:48 EST
Received: from localhost (p54B5E2A1.dip0.t-ipconnect.de [::ffff:84.181.226.161])
  (AUTH: PLAIN simon@ruderich.org, TLS: TLSv1/SSLv3,128bits,AES128-SHA)
  by zucker.schokokeks.org with ESMTPSA; Wed, 26 Feb 2014 01:39:40 +0100
  id 000000000002001B.00000000530D37CC.00006E07
Content-Disposition: inline
In-Reply-To: <vpqlhx0a3cb.fsf@anie.imag.fr>
User-Agent: Mutt/1.5.21 (2013-03-19)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242696>

On Mon, Feb 24, 2014 at 05:21:40PM +0100, Matthieu Moy wrote:
> One easy thing to do OTOH would be to show a hint at the end of "git
> stash pop"'s output, like

I think that's a good idea. It makes it obvious that Git has kept
the stash and that the user should drop it when he's done - if he
wants to.

> $ git stash pop
> Auto-merging foo.txt
> CONFLICT (content): Merge conflict in foo.txt
> 'stash pop' failed. Please, resolve the conflicts manually. The stash
> was not dropped in case you need to restart the operation. When you are
> done resolving the merge, you may run the following to drop the stash:
>
>   git stash drop

Maybe just the following to keep the output on a single line:

    Use 'git stash drop' to remove the stash after resolving the conflicts.

But maybe that's too short as it doesn't mention explicitly, that
the stash was kept.

Regards
Simon
-- 
+ privacy is necessary
+ using gnupg http://gnupg.org
+ public key id: 0x92FEFDB7E44C32F9
