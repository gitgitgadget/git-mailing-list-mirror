From: "W. Trevor King" <wking@tremily.us>
Subject: Re: regression:
 "96b9e0e3 config: treat user and xdg config permission problems as errors"
 busted git-daemon
Date: Fri, 12 Apr 2013 07:26:36 -0400
Message-ID: <20130412112636.GC20178@odin.tremily.us>
References: <20130411181439.GA2820@sigill.intra.peff.net>
 <7vwqs8hmh1.fsf@alter.siamese.dyndns.org>
 <20130411200330.GA15667@odin.tremily.us>
 <7vip3shfpd.fsf@alter.siamese.dyndns.org>
 <20130411222301.GA11283@sigill.intra.peff.net>
 <20130412005748.GA17116@odin.tremily.us>
 <7vvc7sfkwn.fsf@alter.siamese.dyndns.org>
 <20130412043501.GA12942@sigill.intra.peff.net>
 <7vr4igfj9w.fsf@alter.siamese.dyndns.org>
 <20130412050550.GA15724@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=5QAgd0e35j3NYeGe
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Mike Galbraith <bitbucket@online.de>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 12 13:26:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQc88-0007Di-9S
	for gcvg-git-2@plane.gmane.org; Fri, 12 Apr 2013 13:26:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755200Ab3DLL0v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Apr 2013 07:26:51 -0400
Received: from vms173003pub.verizon.net ([206.46.173.3]:58560 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755181Ab3DLL0u (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Apr 2013 07:26:50 -0400
Received: from odin.tremily.us ([unknown] [72.68.100.81])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0ML500F7L3SC7F50@vms173003.mailsrvcs.net> for
 git@vger.kernel.org; Fri, 12 Apr 2013 06:26:37 -0500 (CDT)
Received: by odin.tremily.us (Postfix, from userid 1000)	id B3E3A95E0CE; Fri,
 12 Apr 2013 07:26:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1365765996; bh=BkJNTqX0rICHA1LMlZd/6XGEkS1X/xt/T3+8iiAx4w8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=B7PAAqzYNXaZhnX9Zy8rZ2/c19KauZN/0rwqXUdWts/vA726YOAOX7CK0DnBxBxyw
 nSObo/8Zw8aNdjnTkt1afC1Qk95dIOPuwULQuY6TbRzfhSwDUXKHoZkYhiYpBHjzOU
 nGuxA9QpbQzmEaVXlKi7bB++kf04/R++eKSsTW5o=
Content-disposition: inline
In-reply-to: <20130412050550.GA15724@sigill.intra.peff.net>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220977>


--5QAgd0e35j3NYeGe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2013 at 01:05:50AM -0400, Jeff King wrote:
>   Like many programs that switch user id, the daemon does not reset
>   environment variables such a `$HOME` when it runs git programs like
>   `upload-pack` and `receive-pack`. When using this option, you may also
>   want to set and export `HOME` to point at the home directory of
>   `<user>` before starting the daemon, and make sure the Git
>   configuration file in that directory are readable by `<user>`.

How about "and make sure any Git configuration files", since there
might not be any Git configuration files.

Cheers,
Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--5QAgd0e35j3NYeGe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRZ+9rAAoJEEUbTsx0l5OMl4QQAIzT2b5pWjJBN9ofRMc2tkVZ
N0mvG1jcKzJrMClbZJfCLFFNURabYITlES4/Zm5B6oqaZ4ucYdG+9vFnXlbwdNCC
lJVlPqiO1D2776Z1nHyDjUJCJeGMi3ULZ367qcdEK9LxSDJw4C+pEYz3v3j14jkH
gj1E70ralHjqPZWzbziykk8LTDcmVEB0Pvg7PmUWOXkMpyPOg+pb6l5eGkIKRBzh
+nNQ9F3ACIDpzXyL1ybKqxzgmb2TX5c56ZKYSHIIUGmNbejJN0sf1xacl84vgO24
k1EM8hzF1z6YNec1RwWky4qgu8krR2eYNpdEOMLl+xrCiXM+51G7ftUlo0AqiRi7
JMN47wU7MZQtyepkWuqmhMiS5VaV8hGOaLMtrnMtsLWZOeSc8qNcEPiBOWJhDgGY
NhwyW15NQG1G545iHMKYIX0+35DnHXYpiicTBLnxBdjCZYS/ZMkArpHXFjnyFyMP
h2L97NqjjNZqDYreUys6RXRwciaFNQMqOGz8ccQwZRpLrAV7lCnwUfcjGZfM0w86
Ou07rtnXUu5EfNGEco8fJGRWtlQm3Iy97tAV2SDgJAkswmFftyke8qqMeWZ7uAel
55hWLXUbRw1n7/MT8aHnd68Am6IS8zdXr7Dz4vs25BkET5sy9P8cGAvLlH1Ah1VM
p0XhFa5ifB7hU+H3hIGt
=UsTl
-----END PGP SIGNATURE-----

--5QAgd0e35j3NYeGe--
