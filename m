From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: ref name troubles, was Re: [PATCH v2] Introduce %<branch> as
   shortcut to the tracked branch
Date: Fri, 20 Mar 2009 16:12:51 +0100
Message-ID: <49C3B273.4080402@drmicha.warpmail.net>
References: <7vr60ubgul.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0903182343580.10279@pacific.mpi-cbg.de> <alpine.DEB.1.00.0903200121330.10279@pacific.mpi-cbg.de> <alpine.DEB.1.00.0903200137230.10279@pacific.mpi-cbg.de> <20090320004029.GX23521@spearce.org> <20090320060545.GB27008@coredump.intra.peff.net> <7vprgc4r6h.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0903201029290.10279@pacific.mpi-cbg.de> <20090320111238.GZ8940@machine.or.cz> <alpine.DEB.1.00.0903201245140.6865@intel-tinevez-2-302> <20090320115043.GB8940@machine.or.cz> <alpine.DEB.1.00.0903201255230.6865@intel-tinevez-2-302> <49C3A8D7.1040509@drmicha.warpmail.net> <alpine.DEB.1.00.0903201600500.6865@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Petr Baudis <pasky@suse.cz>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Andreas Gruenbacher <agruen@suse.de>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Mar 20 16:14:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkgQi-0008Bv-TY
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 16:14:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754731AbZCTPNL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Mar 2009 11:13:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753048AbZCTPNJ
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Mar 2009 11:13:09 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:46697 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752603AbZCTPNI (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Mar 2009 11:13:08 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 62C692F4F4D;
	Fri, 20 Mar 2009 11:13:06 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Fri, 20 Mar 2009 11:13:06 -0400
X-Sasl-enc: 7vwBAw8Efd0NPk4pmxiIdDhOYcy5B5FM/s18vhW/DExx 1237561986
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 29F374D0EC;
	Fri, 20 Mar 2009 11:13:05 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b4pre) Gecko/20090320 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <alpine.DEB.1.00.0903201600500.6865@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113970>

Johannes Schindelin venit, vidit, dixit 20.03.2009 16:01:
> Hi,
>=20
> On Fri, 20 Mar 2009, Michael J Gruber wrote:
>=20
>> Do we have ^ as a prefix yet?
>=20
> Yes, it means "not".  IOW '^bla blub' is the same as 'bla..blub'.

Oh yes, I forgot. commit specifiers and ranges are in different section=
s
in git-rev-parse.1.

>> Also, I don't think people would use @@ much in branch names.
>=20
> Whoa...

We already have ^! and ^@ (I didn't know).

While someone may have a branch like "@junio" I think doubled special
characters are uncommon. Except for that topic branch /&$%$%=A7$%&/) fo=
r a
really nasty bug.

Of course, if @@ refers to a tracked branch which follows another
branch, then @@@@...

Michael
