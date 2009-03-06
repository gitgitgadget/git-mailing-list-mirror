From: Miles Bader <miles@gnu.org>
Subject: Re: setting up tracking on push
Date: Fri, 06 Mar 2009 20:15:37 +0900
Message-ID: <buoy6vi297q.fsf@dhlpc061.dev.necel.com>
References: <buofxhr2vta.fsf@dhlpc061.dev.necel.com>
	<76718490903052049k217e9c12gb7881f8904fdd9d@mail.gmail.com>
	<alpine.DEB.1.00.0903061144480.10279@pacific.mpi-cbg.de>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Mar 06 12:17:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfY3W-0000Bb-NB
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 12:17:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754360AbZCFLPy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Mar 2009 06:15:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753678AbZCFLPx
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Mar 2009 06:15:53 -0500
Received: from TYO201.gate.nec.co.jp ([202.32.8.193]:36553 "EHLO
	tyo201.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753643AbZCFLPx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Mar 2009 06:15:53 -0500
Received: from relay11.aps.necel.com ([10.29.19.46])
	by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id n26BFcpX004250;
	Fri, 6 Mar 2009 20:15:38 +0900 (JST)
Received: from relay31.aps.necel.com ([10.29.19.20] [10.29.19.20]) by relay11.aps.necel.com with ESMTP; Fri, 6 Mar 2009 20:15:38 +0900
Received: from dhlpc061 ([10.114.112.181] [10.114.112.181]) by relay31.aps.necel.com with ESMTP; Fri, 6 Mar 2009 20:15:37 +0900
Received: by dhlpc061 (Postfix, from userid 31295)
	id D5A4952E270; Fri,  6 Mar 2009 20:15:37 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
Blat: Foop
In-Reply-To: <alpine.DEB.1.00.0903061144480.10279@pacific.mpi-cbg.de>
	(Johannes Schindelin's message of "Fri, 6 Mar 2009 11:45:56 +0100
	(CET)")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112423>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>> > I vaguely feel like I should be able to do:
>> >
>> > =A0git push --track origin grognul
>
> http://search.gmane.org/?query=3Dpush+track&group=3Dgmane.comp.versio=
n-control.git
>
> Summary for the lazy: it needs a lot of work to be implemented proper=
ly.

Alternatively, maybe a "git track [REMOTE [BRANCH]]" command that simpl=
y
adds makes adding the appropriate config magic more convenient ?

I dunno what the arg syntax would look like in the general case;
I almost always want to use the current branch, and track an identicall=
y
named branch in the origin remote though...

-Miles

--=20
Custard, n. A vile concoction produced by a malevolent conspiracy of th=
e hen,
the cow, and the cook.
