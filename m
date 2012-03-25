From: greened@obbligato.org
Subject: Re: Not a git repository: '.'
Date: Sun, 25 Mar 2012 16:59:55 -0500
Message-ID: <877gy8e3z8.fsf@smith.obbligato.org>
References: <87r4wh6hce.fsf@smith.obbligato.org> <4F6E0F07.6030400@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Mon Mar 26 00:03:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SBvXE-0001f4-UB
	for gcvg-git-2@plane.gmane.org; Mon, 26 Mar 2012 00:03:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932228Ab2CYWDb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Mar 2012 18:03:31 -0400
Received: from li209-253.members.linode.com ([173.255.199.253]:36252 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932199Ab2CYWDa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Mar 2012 18:03:30 -0400
Received: from c-75-73-20-8.hsd1.mn.comcast.net ([75.73.20.8] helo=smith.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.77)
	(envelope-from <greened@obbligato.org>)
	id 1SBrnq-0000ja-9g; Sun, 25 Mar 2012 13:04:30 -0500
In-Reply-To: <4F6E0F07.6030400@kdbg.org> (Johannes Sixt's message of "Sat, 24
	Mar 2012 19:14:31 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Filter-Spam-Score: ()
X-Filter-Spam-Report: Spam detection software, running on the system "johnson.obbligato.org", has
 identified this incoming email as possible spam.  The original message
 has been attached to this so you can view it (if it isn't spam) or label
 similar future email.  If you have any questions, see
 @@CONTACT_ADDRESS@@ for details.
 Content preview:  Johannes Sixt <j6t@kdbg.org> writes: > Most likely, GIT_DIR=.
    is set when the hook is entered. Does unset > GIT_DIR help? That was indeed
    the problem. Thank you! [...] 
 Content analysis details:   (1.4 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -1.0 ALL_TRUSTED            Passed through trusted hosts only via SMTP
  2.4 DATE_IN_FUTURE_03_06   Date: is 3 to 6 hours after Received: date
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193884>

Johannes Sixt <j6t@kdbg.org> writes:

> Most likely, GIT_DIR=. is set when the hook is entered. Does unset
> GIT_DIR help?

That was indeed the problem.  Thank you!

                        -Dave
