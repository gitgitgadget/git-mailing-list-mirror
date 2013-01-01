From: greened@obbligato.org
Subject: Re: git subtree error (just how do you expect me to merge 0 trees?)
Date: Mon, 31 Dec 2012 20:39:04 -0600
Message-ID: <87ehi539vb.fsf@waller.obbligato.org>
References: <FBE22FDC-5800-40C8-9778-82DFD27579F6@drewcrawfordapps.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Drew Crawford <drew@drewcrawfordapps.com>
X-From: git-owner@vger.kernel.org Tue Jan 01 03:40:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tprln-0005Cm-PC
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jan 2013 03:40:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751584Ab3AACjl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Dec 2012 21:39:41 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:48263 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751279Ab3AACjk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Dec 2012 21:39:40 -0500
Received: from c-75-73-20-8.hsd1.mn.comcast.net ([75.73.20.8] helo=waller.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
	(Exim 4.80)
	(envelope-from <greened@obbligato.org>)
	id 1TprsY-0005Wb-6H; Mon, 31 Dec 2012 20:46:58 -0600
In-Reply-To: <FBE22FDC-5800-40C8-9778-82DFD27579F6@drewcrawfordapps.com> (Drew
	Crawford's message of "Thu, 18 Oct 2012 18:04:57 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
X-Filter-Spam-Score: ()
X-Filter-Spam-Report: Spam detection software, running on the system "johnson.obbligato.org", has
 identified this incoming email as possible spam.  The original message
 has been attached to this so you can view it (if it isn't spam) or label
 similar future email.  If you have any questions, see
 @@CONTACT_ADDRESS@@ for details.
 Content preview:  Drew Crawford <drew@drewcrawfordapps.com> writes: > Ideally
    it would be better to emit an error-message from a script > higher up the
    calling chain that would be more descriptive about the > problem (such as
    suggesting no branch is specified).-- [...] 
 Content analysis details:   (-2.9 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -1.0 ALL_TRUSTED            Passed through trusted hosts only via SMTP
 -1.9 BAYES_00               BODY 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212382>

Drew Crawford <drew@drewcrawfordapps.com> writes:

> Ideally it would be better to emit an error-message from a script
> higher up the calling chain that would be more descriptive about the
> problem (such as suggesting no branch is specified).--

Ok, I used git rev-parse --verify and I have this working now.  Will
send to Junio in the batch with fixes from other folks.

Thanks for catching this!

                         -David
