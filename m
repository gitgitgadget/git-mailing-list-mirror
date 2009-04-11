From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-cvsimport: add support for cvs pserver password
 scrambling.
Date: Sat, 11 Apr 2009 13:52:59 -0700
Message-ID: <7vhc0udiac.fsf@gitster.siamese.dyndns.org>
References: <5794AED2-43FF-4441-8292-0C9BFB3139A2@gmail.com>
 <20090410093434.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Dirk =?utf-8?Q?H=C3=B6rner?= <dirker@gmail.com>
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Sat Apr 11 22:55:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LskEG-0005Q5-Fd
	for gcvg-git-2@gmane.org; Sat, 11 Apr 2009 22:55:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758824AbZDKUxf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 11 Apr 2009 16:53:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753616AbZDKUxe
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Apr 2009 16:53:34 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:43228 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753255AbZDKUxe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Apr 2009 16:53:34 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 54BA2A943B;
	Sat, 11 Apr 2009 16:53:31 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 78813A9436; Sat,
 11 Apr 2009 16:53:23 -0400 (EDT)
In-Reply-To: <20090410093434.6117@nanako3.lavabit.com> (Nanako Shiraishi's
 message of "Fri, 10 Apr 2009 09:34:34 +0900")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D0AA2BAA-26DA-11DE-A74B-C121C5FC92D5-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116348>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> Quoting Dirk H=C3=B6rner:
>
>> Instead of a cleartext password, the CVS pserver expects a scrambled=
 one
>> in the authentication request. With this patch it is possible to imp=
ort
>> CVS repositories only accessible via pserver and user/password.
>>=20
>> Signed-off-by: Dirk Hoerner <dirker@gmail.com>
>
> Junio, may I ask what happened to this patch?

I do not use cvs emulation myself, nor pserver access, and I actually h=
ave
been waiting for people who do use pserver access to report breakages a=
nd
people pointing this patch out.
