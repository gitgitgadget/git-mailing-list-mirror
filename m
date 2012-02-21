From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: Patchset NTLM-Authentication
Date: Tue, 21 Feb 2012 10:22:17 +0100
Message-ID: <87vcn0h77a.fsf@thomas.inf.ethz.ch>
References: <4CDEC141B5583D408E79F2931DB7708301802B70@GSX300A.mxchg.m.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <git@vger.kernel.org>, <gitster@pobox.com>, <avarab@gmail.com>
To: "Schmidt, Marco" <Marco.Schmidt@cassidian.com>
X-From: git-owner@vger.kernel.org Tue Feb 21 10:22:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzlvY-0005AT-87
	for gcvg-git-2@plane.gmane.org; Tue, 21 Feb 2012 10:22:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753336Ab2BUJWW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Feb 2012 04:22:22 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:26103 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752274Ab2BUJWU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Feb 2012 04:22:20 -0500
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 21 Feb
 2012 10:22:17 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 21 Feb
 2012 10:22:17 +0100
In-Reply-To: <4CDEC141B5583D408E79F2931DB7708301802B70@GSX300A.mxchg.m.corp>
	(Marco Schmidt's message of "Tue, 21 Feb 2012 09:07:59 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191145>

"Schmidt, Marco" <Marco.Schmidt@cassidian.com> writes:

> I'm not conform with your patch submitting policy. I had no chance to
> track the git repository from my current location.

You should read Documentation/SubmittingPatches.  If your location does
not let you use any git:// or git+http:// ("smart http") transports, you
can use the wereHamster's bundler service https://bundler.caurea.org/ to
get a bundle that you can download over http.  (If you cannot download
*anything* over http, what is your internet access good for?)

Looking at the attachments:

[0002-Einf-hren-der-HTTP-Proxy-Authentifizierung.patch]
[0003-First-working-step.patch]
[0004-remove-debug-information.patch]

* You seem to have forgotten the first patch.  As it stands, the 0002
  one does not apply to my tree.

* The commit messages are useless.  The second one at least says
  "introduce HTTP proxy authentication" which tells me something about
  *what it does*, but in German.  It should also tell me why and how and
  possible other considerations.  See SubmittingPatches.

* The commits should "spring into perfect existence".  That is, in the
  above you should squash 3 and 4 into 2 so that 2 starts out working
  (presumably -- I'm only looking at the subjects) .  You can use rebase
  -i to clean everything up.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
