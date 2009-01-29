From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Jan 2009, #07; Wed, 28)
Date: Wed, 28 Jan 2009 22:38:16 -0500
Message-ID: <20090129033816.GB11836@coredump.intra.peff.net>
References: <7vwscej26i.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 29 04:39:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSNko-000189-V9
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 04:39:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753946AbZA2DiT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 22:38:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753867AbZA2DiT
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 22:38:19 -0500
Received: from peff.net ([208.65.91.99]:46915 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753305AbZA2DiS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 22:38:18 -0500
Received: (qmail 28326 invoked by uid 107); 29 Jan 2009 03:38:27 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 28 Jan 2009 22:38:27 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Jan 2009 22:38:16 -0500
Content-Disposition: inline
In-Reply-To: <7vwscej26i.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107623>

On Wed, Jan 28, 2009 at 06:06:45PM -0800, Junio C Hamano wrote:

> * js/valgrind (Wed Jan 21 02:36:40 2009 +0100) 2 commits
>  - valgrind: ignore ldso errors
>  - Add valgrind support in test scripts
> 
> Dscho and Peff had further exchanges on the list; I am sort of waiting for
> the conclusion before picking any intermediate version up.

I think I gave an OK to the last version posted, but then the last thing
I saw from Dscho was "I have a new patch, but I'm not posting it right
this second":

  http://article.gmane.org/gmane.comp.version-control.git/107300

followed by much "is zlib broken" discussion which I think doesn't hold
us up (either it is a bug in zlib, in which case it is not our problem,
or it is a false positive, in which case we just add a suppression).

So I think we are waiting for the next round from Johannes.

> * jk/valgrind (Thu Oct 23 04:30:45 2008 +0000) 2 commits
>  . valgrind: ignore ldso errors
>  . add valgrind support in test scripts

I think it probably makes sense to drop these at this point. Dscho's
more recent work should be the basis to which new patches are compared.

-Peff
