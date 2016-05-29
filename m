From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [WIP-PATCH 1/2] send-email: create email parser subroutine
Date: Sun, 29 May 2016 19:53:26 +0200
Message-ID: <vpqpos4hht5.fsf@anie.imag.fr>
References: <20160527140104.11192-1-samuel.groot@grenoble-inp.org>
	<20160527140104.11192-2-samuel.groot@grenoble-inp.org>
	<vpqeg8mi4wm.fsf@anie.imag.fr> <20160528233329.GA1132@dcvr.yhbt.net>
	<8904f487-985c-bd2d-a8d1-4a712c6ef558@grenoble-inp.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Wong <e@80x24.org>, git@vger.kernel.org,
	erwan.mathoniere@grenoble-inp.org, jordan.de-gea@grenoble-inp.org,
	gitster@pobox.com, aaron@schrab.com,
	Tom RUSSELLO <tom.russello@grenoble-inp.org>
To: Samuel GROOT <samuel.groot@grenoble-inp.org>
X-From: git-owner@vger.kernel.org Sun May 29 19:53:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b74uQ-0007GN-Pv
	for gcvg-git-2@plane.gmane.org; Sun, 29 May 2016 19:53:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161004AbcE2Rxr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 May 2016 13:53:47 -0400
Received: from mx2.imag.fr ([129.88.30.17]:42314 "EHLO mx2.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1160998AbcE2Rxr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 May 2016 13:53:47 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx2.imag.fr (8.13.8/8.13.8) with ESMTP id u4THrOgi023748
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Sun, 29 May 2016 19:53:24 +0200
Received: from anie (anie.imag.fr [129.88.42.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u4THrQDp017383;
	Sun, 29 May 2016 19:53:26 +0200
In-Reply-To: <8904f487-985c-bd2d-a8d1-4a712c6ef558@grenoble-inp.org> (Samuel
	GROOT's message of "Sun, 29 May 2016 19:15:10 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (mx2.imag.fr [129.88.30.17]); Sun, 29 May 2016 19:53:25 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u4THrOgi023748
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1465149205.63839@jZNNivFB64Loh4GpJOEboA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295840>

Samuel GROOT <samuel.groot@grenoble-inp.org> writes:

> So should we merge parse_email and parse_header in one unique
> subroutine?

At least on the user (i.e. caller of the API) side, one function is
probably enough.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
