From: Magnus =?iso-8859-1?Q?B=E4ck?= <magnus.back@sonyericsson.com>
Subject: Re: Checkout tag?
Date: Sun, 22 Jan 2012 11:11:16 +0100
Message-ID: <20120122101116.GA31022@jpl.local>
References: <1327226753653-7213023.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Abscissa <bus_nabble_git@semitwist.com>
X-From: git-owner@vger.kernel.org Sun Jan 22 11:11:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RouOV-00041U-0Y
	for gcvg-git-2@lo.gmane.org; Sun, 22 Jan 2012 11:11:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751156Ab2AVKLU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 Jan 2012 05:11:20 -0500
Received: from smtprelay-b12.telenor.se ([62.127.194.21]:49906 "EHLO
	smtprelay-b12.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750877Ab2AVKLT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jan 2012 05:11:19 -0500
Received: from ipb1.telenor.se (ipb1.telenor.se [195.54.127.164])
	by smtprelay-b12.telenor.se (Postfix) with ESMTP id 86CE4D4F2
	for <git@vger.kernel.org>; Sun, 22 Jan 2012 11:11:17 +0100 (CET)
X-SMTPAUTH-B2: [b627879]
X-SENDER-IP: [83.227.167.132]
X-LISTENER: [smtp.bredband.net]
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApZOAIDfG09T46eEPGdsb2JhbABDiVCkTxkBAQEBNzKBcgEBBAEyASMjBQsLNBIUGAEMChoTh3wCtzWLQ2MElRiSUA
X-IronPort-AV: E=Sophos;i="4.71,551,1320620400"; 
   d="scan'208";a="254802124"
Received: from ua-83-227-167-132.cust.bredbandsbolaget.se (HELO elwood.jpl.local) ([83.227.167.132])
  by ipb1.telenor.se with ESMTP; 22 Jan 2012 11:11:17 +0100
Received: by elwood.jpl.local (Postfix, from userid 1000)
	id 3CA0B42309; Sun, 22 Jan 2012 11:11:16 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1327226753653-7213023.post@n2.nabble.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188949>

On Sunday, January 22, 2012 at 11:05 CET,
     Abscissa <bus_nabble_git@semitwist.com> wrote:

> I've managed to figure out you switch branches with the checkout
> command, like this:
>=20
> >git checkout branch_name
>=20
> Does that work for tags as well? The docs don't seem clear on that.
> If not, how do you get the working copy to be a specific tag?

Yes, "git checkout" works for branches, tags, commit SHA-1s, and
anything else that can be resolved to a SHA-1 identifying what to
check out. The git-checkout(1) man page says the following:

       git checkout [--patch] [<tree-ish>] [--] <pathspec>...
           ... The <tree-ish> argument can be used to specify a
           specific tree-ish (i.e. commit, tag or tree) ...

--=20
Magnus B=E4ck                   Opinions are my own and do not necessar=
ily
SW Configuration Manager      represent the ones of my employer, etc.
Sony Ericsson
