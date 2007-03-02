From: Bart Trojanowski <bart@jukie.net>
Subject: Re: Git checkout preserve timestamp?
Date: Fri, 2 Mar 2007 10:01:25 -0500
Message-ID: <20070302150125.GF7671@jukie.net>
References: <17895.18265.710811.536526@lisa.zopyra.com> <20070302091426.GA2605@diana.vm.bytemark.co.uk> <17896.9631.316001.869157@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Karl Hasselstr?m <kha@treskal.com>, git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Fri Mar 02 16:01:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HN9GK-0001o0-2H
	for gcvg-git@gmane.org; Fri, 02 Mar 2007 16:01:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992500AbXCBPBc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 2 Mar 2007 10:01:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992503AbXCBPBc
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Mar 2007 10:01:32 -0500
Received: from bart.ott.istop.com ([66.11.172.99]:40143 "EHLO jukie.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992500AbXCBPBb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Mar 2007 10:01:31 -0500
Received: from tau.jukie.net ([10.10.10.211]:37502)
	by jukie.net with esmtp (Exim 4.50)
	id 1HN9GA-00060g-KL; Fri, 02 Mar 2007 10:01:26 -0500
Received: by tau.jukie.net (Postfix, from userid 1000)
	id CDA702DC03C; Fri,  2 Mar 2007 10:01:25 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <17896.9631.316001.869157@lisa.zopyra.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41213>

* Bill Lear <rael@zopyra.com> [070302 08:28]:
> On Friday, March 2, 2007 at 10:14:26 (+0100) Karl Hasselstr=F6m write=
s:
> >                                     .... Of course, the proper fix =
is
> >to use a make-like tool that uses content hashes as well as timestam=
ps
> >to decide if a file has been updated ...
>=20
> I like this idea...

If the content is C, you can use ccache.  Which is pretty close to the
"proper fix".

-Bart

--=20
				WebSig: http://www.jukie.net/~bart/sig/
