From: Benoit SIGOURE <tsuna@lrde.epita.fr>
Subject: Re: git-svn tags and branches
Date: Mon, 27 Aug 2007 17:36:20 +0200
Message-ID: <A0329662-9C87-44C2-84E4-4F60DCC1E95F@lrde.epita.fr>
References: <faulrb$483$1@sea.gmane.org> <867inhqaj9.fsf@lola.quinscape.zz> <20070827153138.GA12936@glandium.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-95--531617166"
Content-Transfer-Encoding: 7bit
Cc: git discussion list <git@vger.kernel.org>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Mon Aug 27 17:36:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPgds-0002kT-JM
	for gcvg-git@gmane.org; Mon, 27 Aug 2007 17:36:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757914AbXH0Pgd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Aug 2007 11:36:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757904AbXH0Pgc
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Aug 2007 11:36:32 -0400
Received: from 2.139.39-62.rev.gaoland.net ([62.39.139.2]:42528 "EHLO
	kualalumpur.lrde.epita.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757891AbXH0Pga (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2007 11:36:30 -0400
Received: from tsunaxbook.lrde.epita.fr ([192.168.101.162])
	by kualalumpur.lrde.epita.fr with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA:16)
	(Exim 4.50)
	id 1IPgdg-0004vm-O8; Mon, 27 Aug 2007 17:36:28 +0200
In-Reply-To: <20070827153138.GA12936@glandium.org>
X-Pgp-Agent: GPGMail 1.1.2 (Tiger)
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56850>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-95--531617166
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed

On Aug 27, 2007, at 5:31 PM, Mike Hommey wrote:

> On Mon, Aug 27, 2007 at 05:09:30PM +0200, David Kastrup  
> <dak@gnu.org> wrote:
>> I actually don't see how one can safely make them tags at all (rather
>> than branches) since Subversion does not enforce the members of a
>> "tags" subdirectory to remain unchanged after the initial copy.
>> Basically, tags are not different from branches in Subversion from
>> what you can do with them.
>
> Well, git-svn could make tags when the tag/branch is created in  
> subversion,
> and then create a branch on the first commit on top of that tag/ 
> branch in
> svn.
>

Or update the tag ref in Git so that it points to the new "HEAD" of  
the SVN tag.  But all in all, it's more consistent to have it look  
like a branch from the Git point of view, because that's really what  
it is after all.

-- 
Benoit Sigoure aka Tsuna
EPITA Research and Development Laboratory



--Apple-Mail-95--531617166
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (Darwin)

iD8DBQFG0u90wwE67wC8PUkRAiDvAJ97YjHLgLqJsZO5Q9ZDeTkMfxCiBACfRUm5
tHTVo0lY39FC+6heSfHLQRI=
=dvLE
-----END PGP SIGNATURE-----

--Apple-Mail-95--531617166--
