From: greened@obbligato.org
Subject: Re: git-subtree Next Round Ready
Date: Tue, 10 Apr 2012 13:12:02 -0500
Message-ID: <87hawrqwwd.fsf@waller.obbligato.org>
References: <87398we3ox.fsf@smith.obbligato.org>
	<7vobrgs5tb.fsf@alter.siamese.dyndns.org>
	<87bon01cpx.fsf@smith.obbligato.org>
	<7vmx6jqzug.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 10 20:10:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHfWZ-0000Xv-NU
	for gcvg-git-2@plane.gmane.org; Tue, 10 Apr 2012 20:10:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757258Ab2DJSKf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Apr 2012 14:10:35 -0400
Received: from li209-253.members.linode.com ([173.255.199.253]:41449 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752259Ab2DJSKe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2012 14:10:34 -0400
Received: from c-75-73-20-8.hsd1.mn.comcast.net ([75.73.20.8] helo=waller.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.77)
	(envelope-from <greened@obbligato.org>)
	id 1SHboI-0007HP-FC; Tue, 10 Apr 2012 09:12:42 -0500
In-Reply-To: <7vmx6jqzug.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 10 Apr 2012 09:02:02 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
X-Filter-Spam-Score: ()
X-Filter-Spam-Report: Spam detection software, running on the system "johnson.obbligato.org", has
 identified this incoming email as possible spam.  The original message
 has been attached to this so you can view it (if it isn't spam) or label
 similar future email.  If you have any questions, see
 @@CONTACT_ADDRESS@@ for details.
 Content preview:  Junio C Hamano <gitster@pobox.com> writes: > I'll pull this
    directly to 'master' as this touches nothing outside > contrib/subtree/ directory.
    Thanks! [...] 
 Content analysis details:   (1.4 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -1.0 ALL_TRUSTED            Passed through trusted hosts only via SMTP
  2.4 DATE_IN_FUTURE_03_06   Date: is 3 to 6 hours after Received: date
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195114>

Junio C Hamano <gitster@pobox.com> writes:

> I'll pull this directly to 'master' as this touches nothing outside
> contrib/subtree/ directory.

Thanks!

> If this will eventually become part of git-core, the default set for
> $(prefix) in contrib/subtree/Makefile may want to watch what we set in the
> toplevel Makefile, but minor things like that can be tweaked in-tree.

Yeah, I thought about that but I didn't know the best way to grab the
default from the Makefile.

It should be easy to move this to git-core.  The top-level Makefile
should just work when the files are moved out of contrib.

Thanks for integrating this.  Then I can look at Herman's changes and
then maybe we can talk about what we need to do to move this to
git-core.

                             -Dave
