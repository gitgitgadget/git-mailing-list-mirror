From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: Error during git gc
Date: Wed, 27 May 2009 16:00:19 +0200
Message-ID: <vpqeiua8x3g.fsf@bauges.imag.fr>
References: <APEJLFBGDNOMCHGLHIHFEEKPDEAA.dforman@dairyfoodusa.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: "David Forman" <dforman@dairyfoodusa.com>
X-From: git-owner@vger.kernel.org Wed May 27 16:04:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9JkM-0000BG-4q
	for gcvg-git-2@gmane.org; Wed, 27 May 2009 16:04:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763226AbZE0OEV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2009 10:04:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763067AbZE0OEV
	(ORCPT <rfc822;git-outgoing>); Wed, 27 May 2009 10:04:21 -0400
Received: from harmonie.imag.fr ([147.171.130.40]:42540 "EHLO harmonie.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762908AbZE0OEU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2009 10:04:20 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by harmonie.imag.fr (8.13.8/8.13.8) with ESMTP id n4RE0KY2000427;
	Wed, 27 May 2009 16:00:20 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1M9Jg3-0002bj-Sk; Wed, 27 May 2009 16:00:19 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1M9Jg3-0007ss-RL; Wed, 27 May 2009 16:00:19 +0200
In-Reply-To: <APEJLFBGDNOMCHGLHIHFEEKPDEAA.dforman@dairyfoodusa.com> (David Forman's message of "Wed\, 27 May 2009 08\:28\:29 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.91 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (harmonie.imag.fr [147.171.130.40]); Wed, 27 May 2009 16:00:20 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120067>

(please provide a Subject: line)

"David Forman" <dforman@dairyfoodusa.com> writes:

> I've encountered the following whenever I access Git and try to compress the
> database due to loose objects.
>
> error: cannot lock ref 'HEAD~'
> error: cannot lock ref 'refs/heads/collections~'
> error: cannot lock ref 'refs/heads/master~'

I'd say you've edited the files .git/HEAD, refs/heads/collections, ...
manually with a text editor that leaves ~ backup files. Unless you
_really_ have branches called collections~ and master~, you can move
these three files (in a temporary folder, or to trash if you're
confident enough).

-- 
Matthieu
