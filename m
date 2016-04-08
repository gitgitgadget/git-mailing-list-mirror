From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] rebase: convert revert to squash on autosquash
Date: Fri, 08 Apr 2016 13:39:08 +0200
Message-ID: <vpq37qwpbxf.fsf@anie.imag.fr>
References: <1460041965-31526-1-git-send-email-mst@redhat.com>
	<alpine.DEB.2.20.1604071720160.2967@virtualbox>
	<20160407184026-mutt-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Fri Apr 08 13:39:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoUl8-00080J-PX
	for gcvg-git-2@plane.gmane.org; Fri, 08 Apr 2016 13:39:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757920AbcDHLjZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2016 07:39:25 -0400
Received: from mx2.imag.fr ([129.88.30.17]:60199 "EHLO mx2.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753343AbcDHLjZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2016 07:39:25 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx2.imag.fr (8.13.8/8.13.8) with ESMTP id u38Bd6Ij003921
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Fri, 8 Apr 2016 13:39:06 +0200
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u38Bd8ja015101;
	Fri, 8 Apr 2016 13:39:08 +0200
In-Reply-To: <20160407184026-mutt-send-email-mst@redhat.com> (Michael S.
	Tsirkin's message of "Thu, 7 Apr 2016 18:51:45 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (mx2.imag.fr [129.88.30.17]); Fri, 08 Apr 2016 13:39:07 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u38Bd6Ij003921
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1460720349.85801@oA9hAoLATKv+SlfV0kH5Wg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291025>

"Michael S. Tsirkin" <mst@redhat.com> writes:

> Doing this automatically for all users might be a bit too drastic for
> the upstream git.  So there could be an option, or something - if
> there's interest I can add that. I thought I'd test the waters before
> I spend time on that.

If the goal is to test the waters, then adding an RFC tag to your
subject helps starting more constructive discussion and avoid alarm
bells ringing like Johannes' reaction. Having the content of this
paragraph as a comment below the --- part of the patch also helps.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
