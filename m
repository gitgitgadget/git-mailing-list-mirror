From: "David E. Wheeler" <david@justatheory.com>
Subject: Bad Man Page URLs
Date: Thu, 5 Apr 2012 18:48:19 -0700
Message-ID: <2AC038A1-3D8D-425E-92B3-DADFD027761A@justatheory.com>
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 06 03:48:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFyIN-0007H5-1B
	for gcvg-git-2@plane.gmane.org; Fri, 06 Apr 2012 03:48:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756864Ab2DFBsY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Apr 2012 21:48:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41867 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752188Ab2DFBsX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Apr 2012 21:48:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5D91B6D25
	for <git@vger.kernel.org>; Thu,  5 Apr 2012 21:48:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from
	:content-type:content-transfer-encoding:subject:date:message-id
	:to:mime-version; s=sasl; bh=3hlvWzQPWUduBFpGFkQRPih0vc4=; b=fFm
	IAfIt3fUcqzZL/dAQu+3gL7IUc2nsq/4vnj8rgSMfh7DRNdzMFMzzU8z2gNWpwYK
	ZN0CNGVTdyPiJY3v5No8NlufhUHiXzc7lL/n3lk+lXVvGlTokaC20RosJ5aPXaEm
	wuLi+kOe7olP90oDhSzSDrDHSbDQqGOOq77rbWCU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 549D06D21
	for <git@vger.kernel.org>; Thu,  5 Apr 2012 21:48:20 -0400 (EDT)
Received: from [10.0.1.19] (unknown [50.137.40.254]) (using TLSv1 with cipher
 AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F10D26D20 for
 <git@vger.kernel.org>; Thu,  5 Apr 2012 21:48:19 -0400 (EDT)
X-Mailer: Apple Mail (2.1257)
X-Pobox-Relay-ID: 963FE78C-7F8A-11E1-8283-9DB42E706CDE-76319746!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194834>

Hello,

I noticed this in 1.7.7.3, but just rebuilt 1.7.9.6 from source on OS X=
 Lion and am still seeing it. These are the links at the end of `man gi=
t`:

> NOTES
>         1. Everyday Git
>            file:///home/junio/share/doc/git-doc/everyday.html
>=20
>         2. Git User's Manual
>            file:///home/junio/share/doc/git-doc/user-manual.html
>=20
>         3. git concepts chapter of the user-manual
>            file:///home/junio/share/doc/git-doc/user-manual.html#git-=
concepts
>=20
>         4. howto
>            file:///home/junio/share/doc/git-doc/howto-index.html
>=20
>         5. GIT API documentation
>            file:///home/junio/share/doc/git-doc/technical/api-index.h=
tml
>=20
>         6. git@vger.kernel.org
>            mailto:git@vger.kernel.org

Those URLs are sadly not useful. :-( FYI, here=92s the script I use to =
build Git:

  https://github.com/theory/my-cap/blob/master/bin/git.sh

Note that the man pages are installed with these two lines:

    curl -O http://git-core.googlecode.com/files/git-manpages-$VERSION.=
tar.gz
    sudo tar xzv -C /usr/local/share/man -f git-manpages-$VERSION.tar.g=
z

Is there a bug reporting system I should report this to?

Thanks,

David
