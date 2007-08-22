From: Benoit SIGOURE <tsuna@lrde.epita.fr>
Subject: Re: confused about preserved permissions
Date: Wed, 22 Aug 2007 14:18:19 +0200
Message-ID: <6031FB22-648E-47DE-92EE-2E7255322C27@lrde.epita.fr>
References: <20070820164411.GA15637@piper.oerlikon.madduck.net>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-24--975497953"
Content-Transfer-Encoding: 7bit
Cc: git discussion list <git@vger.kernel.org>
To: martin f krafft <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Wed Aug 22 14:18:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INpAg-0006Zr-7z
	for gcvg-git@gmane.org; Wed, 22 Aug 2007 14:18:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758187AbXHVMS1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Aug 2007 08:18:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758209AbXHVMS0
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Aug 2007 08:18:26 -0400
Received: from 2.139.39-62.rev.gaoland.net ([62.39.139.2]:49461 "EHLO
	kualalumpur.lrde.epita.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756622AbXHVMSZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2007 08:18:25 -0400
Received: from tsunaxbook.lrde.epita.fr ([192.168.101.162])
	by kualalumpur.lrde.epita.fr with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA:16)
	(Exim 4.50)
	id 1INpAF-0003uF-RS; Wed, 22 Aug 2007 14:18:23 +0200
In-Reply-To: <20070820164411.GA15637@piper.oerlikon.madduck.net>
X-Pgp-Agent: GPGMail 1.1.2 (Tiger)
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56372>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-24--975497953
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed

On Aug 20, 2007, at 6:44 PM, martin f krafft wrote:

> Hello,
>
> I am a bit confused about how git stores and restores permissions.
[...]
> And is there a way to tell git not to mess with the permissions in
> the worktree when switching branches? I am not sure what's causing
> it since the inode of files does not seem to change, so git
> apparently explicitly fchmod()'s files.
>
> I'd be grateful for any documentation to read in addition to the
> code. I saw core.filemode, but that's only about the x bit, it
> seems.
>
> Thanks,

Hi,
this thread drifted away and although the discussion is interesting,  
the original question hasn't been answered so far and I am in a  
situation where I'd like to know the answer (because my working tree  
needs to be group-readable for a given project and my umask 066 keeps  
annoying me although I don't want to change it).

Someone on IRC pointed me to http://git.or.cz/gitwiki/ 
ContentLimitations which says:

"By design, git cannot track other aspects of the filesystem, including:
   * File modes (except for the "executable" bit, and being symbolic  
link)"

That's weird since the file mode is saved in the tree, isn't there a  
way to ask Git to restore this file mode?

Cheers,

-- 
Benoit Sigoure aka Tsuna
EPITA Research and Development Laboratory



--Apple-Mail-24--975497953
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (Darwin)

iD8DBQFGzCmLwwE67wC8PUkRAlJyAJkBCQzLVlZrdIIlJJLgbGDYU4qTTACg1Wqe
jyvebCi/aZ89xj8PLHF7+Sc=
=pcSR
-----END PGP SIGNATURE-----

--Apple-Mail-24--975497953--
