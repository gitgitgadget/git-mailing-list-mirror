From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Error in git citool
Date: Tue, 12 Apr 2011 11:10:28 +0200
Message-ID: <20110412091028.GA18422@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 12 11:10:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9ZcJ-0004Uf-7v
	for gcvg-git-2@lo.gmane.org; Tue, 12 Apr 2011 11:10:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754709Ab1DLJKa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Apr 2011 05:10:30 -0400
Received: from metis.ext.pengutronix.de ([92.198.50.35]:40473 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753303Ab1DLJK3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2011 05:10:29 -0400
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.72)
	(envelope-from <ukl@pengutronix.de>)
	id 1Q9ZcC-00031f-Hq
	for git@vger.kernel.org; Tue, 12 Apr 2011 11:10:28 +0200
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1Q9ZcC-0004tS-GL
	for git@vger.kernel.org; Tue, 12 Apr 2011 11:10:28 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171383>

Hello,

from time to time after heavily mixing vim and partial staging and
unstaging I hit from time to time:

	Application Error
	can't read "file_states()": no such element in array
	can't read "file_states()": no such element in array
	    while executing
	"set s $file_states($path)"
	    (procedure "handle_empty_diff" line 6)
	    invoked from within
	"handle_empty_diff"
	    (procedure "read_diff" line 129)
	    invoked from within
	"read_diff file6 {0.0 {force_first_diff ui_ready}}"

My tcl/tk magic is very limited, so maybe this is obvious for someone
else.

(BTW, this happens using Debian's git 1:1.7.2.3-2.2)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
