From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: Unable to make git with https support
Date: Wed, 7 Mar 2012 20:57:15 +0100
Message-ID: <87pqcotc9w.fsf@thomas.inf.ethz.ch>
References: <CADjGbJq_HL--_CAuE_Yj3B0srx=WDficot8bgadvW92zz9PJdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <git@vger.kernel.org>
To: Nate Parsons <parsons.nate@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 07 20:57:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5MzF-0006FK-Jj
	for gcvg-git-2@plane.gmane.org; Wed, 07 Mar 2012 20:57:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932758Ab2CGT5U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Mar 2012 14:57:20 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:2718 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932553Ab2CGT5T (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Mar 2012 14:57:19 -0500
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Wed, 7 Mar
 2012 20:57:15 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (188.155.176.28) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.1.355.2; Wed, 7 Mar
 2012 20:57:16 +0100
In-Reply-To: <CADjGbJq_HL--_CAuE_Yj3B0srx=WDficot8bgadvW92zz9PJdg@mail.gmail.com>
	(Nate Parsons's message of "Wed, 7 Mar 2012 14:52:13 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [188.155.176.28]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192476>

Nate Parsons <parsons.nate@gmail.com> writes:

>> ./configure --with-curl --prefix=$HOME

What does it say when configuring libcurl?  Are there any errors?  What
if you use the Makefile directly (it's our main build method)?

> But my machine does have curl, and that curl can access https urls

Have you also installed libcurl-devel (or whatever the package might be
called, but it seems you are also using opensuse)?

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
