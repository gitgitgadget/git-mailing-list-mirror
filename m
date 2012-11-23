From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: [PATCH v3 1/3] git-submodule add: Add -r/--record option
Date: Fri, 23 Nov 2012 17:03:01 +0100
Message-ID: <20121123160301.GC14509@book.hvoigt.net>
References: <20121117153007.GB7695@book.hvoigt.net> <20121117192026.GI22234@odin.tremily.us> <7vd2z9t7y2.fsf@alter.siamese.dyndns.org> <20121120011628.GD321@odin.tremily.us> <7v1ufou92h.fsf@alter.siamese.dyndns.org> <20121120121912.GC7096@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Phil Hord <phil.hord@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Nahor <nahor.j+gmane@gmail.com>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Fri Nov 23 17:06:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tbvlg-0006lS-Ql
	for gcvg-git-2@plane.gmane.org; Fri, 23 Nov 2012 17:06:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755233Ab2KWQGA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Nov 2012 11:06:00 -0500
Received: from smtprelay04.ispgateway.de ([80.67.31.32]:50554 "EHLO
	smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754096Ab2KWQGA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Nov 2012 11:06:00 -0500
Received: from [77.21.76.22] (helo=localhost)
	by smtprelay04.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1TbviY-0001EN-F1; Fri, 23 Nov 2012 17:03:02 +0100
Content-Disposition: inline
In-Reply-To: <20121120121912.GC7096@odin.tremily.us>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210263>

On Tue, Nov 20, 2012 at 07:19:12AM -0500, W. Trevor King wrote:
> The benefit is that =C6var's
>=20
>   $ git submodule foreach 'git checkout $(git config --file $toplevel=
/.gitmodules submodule.$name.branch) && git pull'
>=20
> becomes
>=20
>   $ git submodule update --pull

There is an important question still unanswered here for me: How does
the submodule get the configuration what the local branch tracks on the
remote side?

Cheers Heiko
