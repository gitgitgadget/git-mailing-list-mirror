From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [git patches] libata updates, GPG signed (but see admin notes)
Date: Wed, 2 Nov 2011 10:11:26 +0100
Message-ID: <20111102091126.GG18903@elte.hu>
References: <1320049150.8283.19.camel@dabdike>
 <CA+55aFz3=cbciRfTYodNhdEetXYxTARGTfpP9GL9RZK222XmKQ@mail.gmail.com>
 <7vy5w1ow90.fsf@alter.siamese.dyndns.org>
 <CA+55aFwL_s=DcT46dprcYVWEAm_=WkuTV6K9dAn3wc_bDQU8vA@mail.gmail.com>
 <4EAF1F40.3030907@zytor.com>
 <CA+55aFxprv9JR4gtt_UDXheHR5G8PrUA3-Mj0CPsU6E5EzNYeg@mail.gmail.com>
 <4EAF2245.90308@zytor.com>
 <CA+55aFzedaAzzWfzhqVf8y8ZW0jeb56hZwdV3UodSp8Q_Qhc2A@mail.gmail.com>
 <7vvcr4ojvp.fsf@alter.siamese.dyndns.org>
 <CA+55aFyKWLUMQFfaeKJKGFPV_7kfOGjf+pSZ1Y8afzkT4OYQ9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	"H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Jeff Garzik <jeff@garzik.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: linux-kernel-owner@vger.kernel.org Wed Nov 02 10:13:20 2011
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1RLWsq-0000fm-5T
	for glk-linux-kernel-3@lo.gmane.org; Wed, 02 Nov 2011 10:13:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755953Ab1KBJNN (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Wed, 2 Nov 2011 05:13:13 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:50949 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753522Ab1KBJNL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2011 05:13:11 -0400
Received: from elvis.elte.hu ([157.181.1.14])
	by mx2.mail.elte.hu with esmtp (Exim)
	id 1RLWsW-0002jx-P8
	from <mingo@elte.hu>; Wed, 02 Nov 2011 10:13:02 +0100
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id B539D3E25A4; Wed,  2 Nov 2011 10:12:54 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CA+55aFyKWLUMQFfaeKJKGFPV_7kfOGjf+pSZ1Y8afzkT4OYQ9Q@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Received-SPF: neutral (mx2.mail.elte.hu: 157.181.1.14 is neither permitted nor denied by domain of elte.hu) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
X-ELTE-SpamScore: -2.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.0 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.3.1
	-2.0 BAYES_00               BODY: Bayes spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184618>


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> And the receiving side would just do the "git pull" and 
> automatically just get notified that "Yes, this push has been 
> signed by key Xyz Abcdef"

If this approach is used then it would be nice to have a .gitconfig 
switch to require trusted pulls by default: to not allow doing 
non-signed or untrusted pulls accidentally, or for Git to warn in a 
visible, hard to miss way if there's a non-signed pull.

This adds social uncertainty (and an element of a silent alarm) to a 
realistic attack: the attacker wouldnt know exactly how the puller 
checks signed pull requests, it's kept private.

Thanks,

	Ingo
