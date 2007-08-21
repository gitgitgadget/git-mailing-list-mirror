From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGIT PATCH 2/2] Don't touch ref files manually
Date: Tue, 21 Aug 2007 18:46:29 +0200
Message-ID: <20070821164629.GB17045@diana.vm.bytemark.co.uk>
References: <20070810031949.19791.54562.stgit@yoghurt> <20070810032318.19791.70483.stgit@yoghurt> <b0943d9e0708210623h112faa42p97bba06bc9fab774@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pavel Roskin <proski@gnu.org>, git@vger.kernel.org,
	Yann Dirson <ydirson@altern.org>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 21 18:46:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INWsL-0002QA-JJ
	for gcvg-git@gmane.org; Tue, 21 Aug 2007 18:46:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759325AbXHUQqg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 21 Aug 2007 12:46:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759026AbXHUQqg
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Aug 2007 12:46:36 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3220 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757944AbXHUQqg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Aug 2007 12:46:36 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1INWs9-0004Tq-00; Tue, 21 Aug 2007 17:46:29 +0100
Content-Disposition: inline
In-Reply-To: <b0943d9e0708210623h112faa42p97bba06bc9fab774@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56306>

On 2007-08-21 14:23:29 +0100, Catalin Marinas wrote:

> Thanks for this patch.

Two things:

  * The test in your tree has the latin1 form of my name in it,
    instead of utf8. (I noticed because I got a conflict when I
    rebased onto your master.)

  * The test suite now fails on your master (since you've applied just
    the test and not the fix). Please don't do that; it makes
    development needlessly hard. (To be fair, this is partly my fault,
    since I posted the fixin a separate patch. I'll change my ways.)

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
