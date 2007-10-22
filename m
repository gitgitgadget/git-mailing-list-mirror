From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: Proposed git mv behavioral change
Date: Mon, 22 Oct 2007 16:00:15 +0200
Message-ID: <20071022140015.GA1992@diana.vm.bytemark.co.uk>
References: <20071019031959.GE14735@spearce.org> <20071019032407.GA10622@coredump.intra.peff.net> <7E3647F4-E61C-4FBE-9AA7-81CDBE324308@MIT.EDU> <20071019033500.GB10697@coredump.intra.peff.net> <93BF5798-F1C3-48EE-8233-A0F111BF8138@MIT.EDU> <20071019034704.GB11095@coredump.intra.peff.net> <1192859748.13347.146.camel@g4mdd.entnet> <20071020062400.GA30388@coredump.intra.peff.net> <20071020063628.GV14735@spearce.org> <20071020064003.GA30605@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Ari Entlich <lmage11@twcny.rr.com>,
	Michael Witten <mfwitten@MIT.EDU>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Oct 22 16:01:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ijxq1-0000m8-4W
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 16:01:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751870AbXJVOAt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Oct 2007 10:00:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751902AbXJVOAt
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 10:00:49 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3283 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751739AbXJVOAs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 10:00:48 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1IjxpI-0000bZ-00; Mon, 22 Oct 2007 15:00:16 +0100
Content-Disposition: inline
In-Reply-To: <20071020064003.GA30605@coredump.intra.peff.net>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62008>

On 2007-10-20 02:40:03 -0400, Jeff King wrote:

> Right. So the exact state you have in your index never actually
> existed in your working tree. But that's OK if:
>   - the changes are trivial and obviously correct
>   - you're not actually planning on _committing_ that, you just want
>     to build the commit using the index

Or

    - you plan to revisit the commit at a later time and verify that
      it's OK

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
