From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH] Documentation: add submodule.* to the big configuration
 variable list
Date: Thu, 15 Jul 2010 11:34:55 +0200
Message-ID: <201007151134.56090.johan@herland.net>
References: <4C3DD7EF.6010805@panasas.com> <20100715074155.GA22244@burratino>
 <20100715075119.GB22244@burratino>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Peter Krefting <peter@softwolves.pp.se>,
	Boaz Harrosh <bharrosh@panasas.com>,
	Git Mailing List <git@vger.kernel.org>,
	Lars Hjemli <hjemli@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 15 11:35:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZKqM-0002xI-DH
	for gcvg-git-2@lo.gmane.org; Thu, 15 Jul 2010 11:35:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932898Ab0GOJe6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Jul 2010 05:34:58 -0400
Received: from smtp.getmail.no ([84.208.15.66]:49903 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932874Ab0GOJe5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Jul 2010 05:34:57 -0400
Received: from get-mta-scan03.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L5L00JGJEM8LT90@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Thu, 15 Jul 2010 11:34:56 +0200 (MEST)
Received: from get-mta-scan03.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 71EC41EEF4F9_C3ED640B	for <git@vger.kernel.org>; Thu,
 15 Jul 2010 09:34:56 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan03.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 590421EEC29A_C3ED640F	for <git@vger.kernel.org>; Thu,
 15 Jul 2010 09:34:56 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L5L004AFEM82820@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Thu, 15 Jul 2010 11:34:56 +0200 (MEST)
User-Agent: KMail/1.13.5 (Linux/2.6.34-ARCH; KDE/4.4.5; x86_64; ; )
In-reply-to: <20100715075119.GB22244@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151070>

On Thursday 15 July 2010, Jonathan Nieder wrote:
> The url, path, and update items in [submodule "foo"] stanzas are
> nicely explained in the .gitmodules and =E2=80=98git submodule=E2=80=99
> documentation.  Point there from the config documentation.
>=20
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>

Acked-by: Johan Herland <johan@herland.net>

> ---
> It=E2=80=99s late, so I don=E2=80=99t trust this to be coherent Engli=
sh necessarily.
> Thoughts and improvements welcome.
>=20
>  Documentation/config.txt |    9 +++++++++
>  1 files changed, 9 insertions(+), 0 deletions(-)
>=20
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 1029bc4..f1fb5ac 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1685,6 +1685,15 @@ status.submodulesummary::
>  	summary of commits for modified submodules will be shown (see
>  	--summary-limit option of linkgit:git-submodule[1]).
>=20
> +submodule.<name>.path::
> +submodule.<name>.url::
> +submodule.<name>.update::
> +	The path within this project, URL, and updating strategy

May be more legible with:

  The path within this project, the URL, and the updating strategy...


=2E..Johan

--=20
Johan Herland, <johan@herland.net>
www.herland.net
