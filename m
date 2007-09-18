From: Benoit SIGOURE <tsuna@lrde.epita.fr>
Subject: Re: commit summary, --pretty=short and other tools
Date: Tue, 18 Sep 2007 12:27:14 +0200
Message-ID: <CEE6032F-39FB-42D8-A57A-671E4E0875C7@lrde.epita.fr>
References: <20070917112136.GA30201@glandium.org> <55887C88-8523-4839-8B91-236256A5E893@lrde.epita.fr> <46EF7BF7.3070107@op5.se> <Pine.LNX.4.64.0709181109130.28586@racer.site>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-73--796846623"
Content-Transfer-Encoding: 7bit
Cc: Andreas Ericsson <ae@op5.se>, Mike Hommey <mh@glandium.org>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Sep 18 12:28:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXaJN-0004ul-ER
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 12:28:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754751AbXIRK1h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 06:27:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755257AbXIRK1h
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 06:27:37 -0400
Received: from 2.139.39-62.rev.gaoland.net ([62.39.139.2]:60794 "EHLO
	kualalumpur.lrde.epita.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754720AbXIRK1g (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 06:27:36 -0400
Received: from tsunaxbook.lrde.epita.fr ([192.168.101.162])
	by kualalumpur.lrde.epita.fr with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <tsuna@lrde.epita.fr>)
	id 1IXaIn-0003u2-O7; Tue, 18 Sep 2007 12:27:33 +0200
In-Reply-To: <Pine.LNX.4.64.0709181109130.28586@racer.site>
X-Pgp-Agent: GPGMail 1.1.2 (Tiger)
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58572>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-73--796846623
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed

On Sep 18, 2007, at 12:13 PM, Johannes Schindelin wrote:

> Hi,
>
> On Tue, 18 Sep 2007, Andreas Ericsson wrote:
>
>> const char *find_commit_subject_end(const char *commit_msg)
>> {
>> 	const char *dot, *paragraph_end;
>> 		paragraph_end = strstr(commit_msg, "\n\n");
>> 	dot = strchr(commit_msg, '.');
>> 		return min_non_null(dot, paragraph_end); }
>>
>> would probably get it right very nearly always.
>
> Counterexample (not even mentioning the missing handling of NULL):
>
> http://brick.kernel.dk/git/? 
> p=qemu.git;a=commit;h=eb66d86e295cd5a8f13221589806e15db62a62fa
>
> And no, the responsible developer showed a strong unwillingness to  
> adapt
> to better tools and workflows.
>

OK, look, I think this is the typical case where there is no single  
solution to fit all use cases.
To handle this specific case, you could say "OK let's stop at  
punctuation symbols then".  But what if my commit message is "Add  
namespace::member whatever."

If there is a single line followed by a blank line: it's a git-style  
commit message, do what was done before.
Otherwise, we need some heuristic to find the relevant part of the  
commit message (if there is such a relevant part in the first place!).

-- 
Benoit Sigoure aka Tsuna
EPITA Research and Development Laboratory



--Apple-Mail-73--796846623
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (Darwin)

iD8DBQFG76gCwwE67wC8PUkRAhcGAKCYZHhiiC5jRgXwAt5B+d+D2lShdQCgpYv1
d3/32IfPa2wWHbDWhaqM6CA=
=CHPZ
-----END PGP SIGNATURE-----

--Apple-Mail-73--796846623--
