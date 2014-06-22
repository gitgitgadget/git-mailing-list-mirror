From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: autopacking twice?
Date: Sun, 22 Jun 2014 17:22:32 +0200
Message-ID: <vpqbntlq893.fsf@anie.imag.fr>
References: <20140622055154.GA13819@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Sun Jun 22 17:33:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wyjlx-0006Mw-QD
	for gcvg-git-2@plane.gmane.org; Sun, 22 Jun 2014 17:33:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751451AbaFVPWl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jun 2014 11:22:41 -0400
Received: from mx1.imag.fr ([129.88.30.5]:57108 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751423AbaFVPWk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jun 2014 11:22:40 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s5MFMVKX021647
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 22 Jun 2014 17:22:31 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s5MFMWUs011569;
	Sun, 22 Jun 2014 17:22:32 +0200
In-Reply-To: <20140622055154.GA13819@redhat.com> (Michael S. Tsirkin's message
	of "Sun, 22 Jun 2014 08:51:54 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sun, 22 Jun 2014 17:22:31 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252309>

"Michael S. Tsirkin" <mst@redhat.com> writes:

> Guess: auto-packing was started in background, did not
> complete in time, and was restarted for the second time?

Probably once for fetch, and another after rebase.

> If true, some kind of lock file would be useful
> to prevent this.

It is the case with recent versions of Git (>= 1.8.5). Which version are
you running?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
