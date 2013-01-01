From: greened@obbligato.org
Subject: Re: [BUG?] git-subtree behavior when the -P tree is removed and recreated
Date: Mon, 31 Dec 2012 19:43:13 -0600
Message-ID: <871ue54r0u.fsf@waller.obbligato.org>
References: <CACUV5ofmuUku=byR1_+Cq+g0SdzqZbH1Z1tPfQf4eNABVyYb_Q@mail.gmail.com>
	<CACUV5odffQoCxr=hTuP+S+DU4+6qD7y=YkTCN3iRr7rjar1bLQ@mail.gmail.com>
	<CACUV5ocT56iOS3dZsJ4JLo70o1HJv2TSrvBHE646SyQVmOuYRg@mail.gmail.com>
	<877gozuooz.fsf@pctrast.inf.ethz.ch>
	<CACUV5odJx1+47ggOAppN7whJhLABrRP-3mRWo8adQqbxF4mA5A@mail.gmail.com>
	<7v8v8uav8t.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tomi Belan <tomi.belan@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Avery Pennarun <apenwarr@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 01 02:44:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tpqts-0001Tu-U4
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jan 2013 02:44:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751283Ab3AABnz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Dec 2012 20:43:55 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:48238 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751111Ab3AABny (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Dec 2012 20:43:54 -0500
Received: from c-75-73-20-8.hsd1.mn.comcast.net ([75.73.20.8] helo=waller.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
	(Exim 4.80)
	(envelope-from <greened@obbligato.org>)
	id 1Tpr0a-0005NB-0F; Mon, 31 Dec 2012 19:51:12 -0600
In-Reply-To: <7v8v8uav8t.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 19 Dec 2012 07:59:14 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
X-Filter-Spam-Score: ()
X-Filter-Spam-Report: Spam detection software, running on the system "johnson.obbligato.org", has
 identified this incoming email as possible spam.  The original message
 has been attached to this so you can view it (if it isn't spam) or label
 similar future email.  If you have any questions, see
 @@CONTACT_ADDRESS@@ for details.
 Content preview:  Junio C Hamano <gitster@pobox.com> writes: > Maybe it is a
    seasonal thing, just before the holiday season, but > this has been unresponded
    for a couple of months, not even with a > "That combination is not supported",
    or "Thanks for a bug report". [...] 
 Content analysis details:   (-2.9 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -1.0 ALL_TRUSTED            Passed through trusted hosts only via SMTP
 -1.9 BAYES_00               BO 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212377>

Junio C Hamano <gitster@pobox.com> writes:

> Maybe it is a seasonal thing, just before the holiday season, but
> this has been unresponded for a couple of months, not even with a
> "That combination is not supported", or "Thanks for a bug report".

I did finally see this message.  I totally admit that I've been pretty
absent.  It just happens that I have a ton of paid work to do and
voluteer work unfortunately comes last, after family and after paid
work.

For this bug I honestly don't know what is supposed to happen.  I'm
still learning the code.  It's a bit of a shell-script mess to be
honest, very hard to follow.  That's why it's still in contrib/
and will remain so for a while.

I am more than happy for others to jump in and help out.  I'm not a
gatekeeper.

                          -David
