From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH] More test cases for sanitized path names
Date: Fri, 1 Feb 2008 10:16:18 +0100
Message-ID: <20080201091618.GA32734@diana.vm.bytemark.co.uk>
References: <47975FE6.4050709@viscovery.net> <7v7ihtqfm8.fsf@gitster.siamese.dyndns.org> <7vve5dox0o.fsf_-_@gitster.siamese.dyndns.org> <200802010534.55925.robin.rosenberg.lists@dewire.com> <7vabmlb0y0.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Shawn Bohrer <shawn.bohrer@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 01 10:19:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JKs3i-0003JI-W2
	for gcvg-git-2@gmane.org; Fri, 01 Feb 2008 10:19:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754044AbYBAJTH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Feb 2008 04:19:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754062AbYBAJTG
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Feb 2008 04:19:06 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4162 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754037AbYBAJTE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Feb 2008 04:19:04 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1JKs0R-000068-00; Fri, 01 Feb 2008 09:16:19 +0000
Content-Disposition: inline
In-Reply-To: <7vabmlb0y0.fsf@gitster.siamese.dyndns.org>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72160>

On 2008-01-31 23:17:11 -0800, Junio C Hamano wrote:

> I'd like to make the _first_ patch after 1.5.4 to be a fix-up for
> tests that misuse test_expect_failure. After that, we can use
> test_expect_failure to mark tests that ought to pass but don't
> because of bugs in the commands.

This is precisely what StGit's test suite does, and it has a very nice
property (beyond looking tidy): it's possible to first commit a new
(failing) test, and then commit a fix for the bug that made the test
fail, and have the test suite pass at every step.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
