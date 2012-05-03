From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: Please pull git-po master branch
Date: Thu, 3 May 2012 09:49:09 +0200
Message-ID: <874nrxwvpm.fsf@thomas.inf.ethz.ch>
References: <CANYiYbHtKKWw9LPnr+1khC5Oms-kOtA2WEucoNoE3Njzqiahzw@mail.gmail.com>
	<87d36n2f2r.fsf@thomas.inf.ethz.ch>
	<7vtxzyilid.fsf@alter.siamese.dyndns.org>
	<CANYiYbH+N3k_=FWyeS_HfBWSBeBdOUqW5qrHFe=qV4ECtYABpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Ralf Thielow <ralf.thielow@googlemail.com>,
	Git List <git@vger.kernel.org>,
	Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>,
	Byrial Jensen <byrial@vip.cybercity.dk>,
	Vincent van Ravesteijn <vfr@lyx.org>,
	Marco Sousa <marcomsousa@gmail.com>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 03 09:49:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPqmw-0000NG-QH
	for gcvg-git-2@plane.gmane.org; Thu, 03 May 2012 09:49:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752817Ab2ECHtP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 May 2012 03:49:15 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:15865 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752109Ab2ECHtL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 May 2012 03:49:11 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.283.3; Thu, 3 May
 2012 09:49:10 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.1.355.2; Thu, 3 May
 2012 09:49:09 +0200
In-Reply-To: <CANYiYbH+N3k_=FWyeS_HfBWSBeBdOUqW5qrHFe=qV4ECtYABpA@mail.gmail.com>
	(Jiang Xin's message of "Thu, 3 May 2012 12:31:57 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196891>

Jiang Xin <worldhello.net@gmail.com> writes:

>  * Pull requests with a initial XX.po (untranslated) and updated TEAMS file
>    will not merge to the master branch, but merge to a work in progress
>    branch, such as WIP/XX.

Please don't take my complaint as a request to completely over-engineer
the process, that will just make it more work for everyone and scare
away potential translators.

I think it's sufficient to

* not put _completely new_ translations in maint

This one is actually very similar to the rule for code: maint does not
usually get new features either.  (The only exception I'm aware of is
when maint needs to learn to "speak" a new format introduced in newer
versions.)

* not submit pull requests late in the rc phase

With a similar reasoning.  Because there are usually several -rc tags,
doing this will ensure that the new translations get fairly wide
exposure with interested developers.

So more or less what we do for code, too.


Of course there's the flip side that I should have watched i18n more
closely (as evidenced by me being a loudmouth now).

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
