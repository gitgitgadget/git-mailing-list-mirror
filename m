From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Google Summer of Code 2013 (GSoC13)
Date: Mon, 18 Feb 2013 20:53:25 +0100
Message-ID: <87mwv1wg96.fsf@pctrast.inf.ethz.ch>
References: <87ehgd1qq2.fsf@pctrast.inf.ethz.ch>
	<87k3q5zfaa.fsf@pctrast.inf.ethz.ch>
	<CALkWK0ne3GX7wA1U0-TnMqU3mTFNe12TQ_s0=2MVJ=BMs8tirA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Shawn Pearce <spearce@spearce.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	Paul Mackerras <paulus@samba.org>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	Thomas Gummerer <t.gummerer@gmail.com>,
	David Michael Barr <davidbarr@google.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	"Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 20:54:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7Wmu-0006Xr-R8
	for gcvg-git-2@plane.gmane.org; Mon, 18 Feb 2013 20:54:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757314Ab3BRTxa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2013 14:53:30 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:25920 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755310Ab3BRTx2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2013 14:53:28 -0500
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 18 Feb
 2013 20:53:23 +0100
Received: from pctrast.inf.ethz.ch.ethz.ch (46.126.8.85) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 18 Feb
 2013 20:53:25 +0100
In-Reply-To: <CALkWK0ne3GX7wA1U0-TnMqU3mTFNe12TQ_s0=2MVJ=BMs8tirA@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Mon, 18 Feb 2013 23:43:01 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216506>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

>>     * Cannot look at the diff in word-diff mode (and apply it normally).
[...]
> Also: Having to figure out, heuristically, when to actually turn it on
> might be a worthwhile feature, especially for services like GitHub.

Actually that's a pretty cute idea of its own.  You could call it
--smart-diff or some such, and define its output as "whatever diff
format git thinks would be appropriate".

And given the current state of diff pipeline refactorization, the effort
is probably on the order of magnitude of a GSoC...

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
