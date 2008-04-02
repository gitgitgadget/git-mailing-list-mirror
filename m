From: Pavel Roskin <proski@gnu.org>
Subject: Re: "stg reset --status" doesn't just reset status
Date: Wed, 02 Apr 2008 13:30:24 -0400
Message-ID: <1207157424.5828.16.camel@dv>
References: <20080401222124.1b4niqtm0ogw40sk@webmail.spamcop.net>
	 <20080402120026.GA17241@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
To: Karl =?ISO-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Wed Apr 02 19:31:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jh6nv-0006aZ-W0
	for gcvg-git-2@gmane.org; Wed, 02 Apr 2008 19:31:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753667AbYDBRa2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Apr 2008 13:30:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753739AbYDBRa2
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Apr 2008 13:30:28 -0400
Received: from c60.cesmail.net ([216.154.195.49]:48029 "EHLO c60.cesmail.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753667AbYDBRa1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Apr 2008 13:30:27 -0400
Received: from unknown (HELO relay.cesmail.net) ([192.168.1.81])
  by c60.cesmail.net with ESMTP; 02 Apr 2008 13:30:25 -0400
Received: from [192.168.1.21] (static-72-92-88-10.phlapa.fios.verizon.net [72.92.88.10])
	by relay.cesmail.net (Postfix) with ESMTP id 77743619058;
	Wed,  2 Apr 2008 13:30:25 -0400 (EDT)
In-Reply-To: <20080402120026.GA17241@diana.vm.bytemark.co.uk>
X-Mailer: Evolution 2.12.3 (2.12.3-3.fc8) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78701>

On Wed, 2008-04-02 at 14:00 +0200, Karl Hasselstr=F6m wrote:

> (I assume "stg reset --status" is just a typo for "stg status
> --reset"?)

Exactly.  "stg status --reset" is so against the logic that I could not
even write it properly :)

> I'd be fine with removing status --reset, but since there is currentl=
y
> no other way to do this in StGit, I expect Catalin would object. (As =
I
> recall, that's precisely what happened when I did try to remove it
> some time ago.)

1) stg diff | patch -Rp1
2) stg new -m "trash" trash; stg refresh; stg delete trash

Besides, I don't think everything should be easily doable from stgit.

> I'm currently (slowly) working on an "stg reset" command that'll be
> able to reset the stack to any prior state. It could be made to reset
> to the most recent recorded state if no extra argument is given, whic=
h
> I think would make it do what you want.

Sounds good.  Thank you!

--=20
Regards,
Pavel Roskin
