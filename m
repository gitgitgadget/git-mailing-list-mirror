From: Jochen Striepe <jochen@tolot.escape.de>
Subject: Re: [git patches] libata updates, GPG signed (but see admin notes)
Date: Wed, 2 Nov 2011 12:20:18 +0100
Message-ID: <20111102112018.GF17259@pompeji.miese-zwerge.org>
References: <CA+55aFz3=cbciRfTYodNhdEetXYxTARGTfpP9GL9RZK222XmKQ@mail.gmail.com>
 <7vy5w1ow90.fsf@alter.siamese.dyndns.org>
 <CA+55aFwL_s=DcT46dprcYVWEAm_=WkuTV6K9dAn3wc_bDQU8vA@mail.gmail.com>
 <4EAF1F40.3030907@zytor.com>
 <CA+55aFxprv9JR4gtt_UDXheHR5G8PrUA3-Mj0CPsU6E5EzNYeg@mail.gmail.com>
 <4EAF2245.90308@zytor.com>
 <CA+55aFzedaAzzWfzhqVf8y8ZW0jeb56hZwdV3UodSp8Q_Qhc2A@mail.gmail.com>
 <7vvcr4ojvp.fsf@alter.siamese.dyndns.org>
 <CA+55aFyKWLUMQFfaeKJKGFPV_7kfOGjf+pSZ1Y8afzkT4OYQ9Q@mail.gmail.com>
 <20111102091126.GG18903@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	"H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Jeff Garzik <jeff@garzik.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
To: Ingo Molnar <mingo@elte.hu>
X-From: linux-ide-owner@vger.kernel.org Wed Nov 02 12:33:16 2011
Return-path: <linux-ide-owner@vger.kernel.org>
Envelope-to: lnx-linux-ide@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-ide-owner@vger.kernel.org>)
	id 1RLZ4F-0005Rr-LM
	for lnx-linux-ide@lo.gmane.org; Wed, 02 Nov 2011 12:33:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754222Ab1KBLdN (ORCPT <rfc822;lnx-linux-ide@m.gmane.org>);
	Wed, 2 Nov 2011 07:33:13 -0400
Received: from oker.escape.de ([194.120.234.254]:39795 "EHLO oker.escape.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753060Ab1KBLdN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 2 Nov 2011 07:33:13 -0400
X-Greylist: delayed 538 seconds by postgrey-1.27 at vger.kernel.org; Wed, 02 Nov 2011 07:33:12 EDT
Received: from oker.escape.de (localhost [127.0.0.1])
	(envelope-sender: jochen@tolot.escape.de)
	by oker.escape.de (8.14.3/8.14.3/$Revision: 1.76 $) with ESMTP id pA2BNW74026752
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 2 Nov 2011 12:23:32 +0100
Received: (from uucp@localhost)
	by oker.escape.de (8.14.3/8.14.3/Submit) with UUCP id pA2BNWMV026749;
	Wed, 2 Nov 2011 12:23:32 +0100
Received: from pompeji.miese-zwerge.org (localhost [127.0.0.1])
	by pompeji.miese-zwerge.org (8.14.4/8.14.4/Debian-2) with ESMTP id pA2BKKVW014077;
	Wed, 2 Nov 2011 12:20:20 +0100
Received: (from jochen@localhost)
	by pompeji.miese-zwerge.org (8.14.4/8.14.4/Submit) id pA2BKIk2014076;
	Wed, 2 Nov 2011 12:20:18 +0100
Content-Disposition: inline
In-Reply-To: <20111102091126.GG18903@elte.hu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184628>

	Hi,

On Wed, Nov 02, 2011 at 10:11:26AM +0100, Ingo Molnar wrote:
> If this approach is used then it would be nice to have a .gitconfig 
> switch to require trusted pulls by default: to not allow doing 
> non-signed or untrusted pulls accidentally, or for Git to warn in a 
> visible, hard to miss way if there's a non-signed pull.
> 
> This adds social uncertainty (and an element of a silent alarm) to a 
> realistic attack: the attacker wouldnt know exactly how the puller 
> checks signed pull requests, it's kept private.

But that way you get a false sense of alarm when someone sent a
perfectly trustable pull request, e.g. by signed email.


Another question: If store the actual pgp/gpg signatures in the git tree,
how do you handle signatures by keys which were valid by the time the
signature was made but expired when checking some time afterwards? AFAICT,
gpg will only tell you the key is expired _now_, and will make no statement
regarding the time the actual signature was made.


Thanks,
Jochen.
