From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH v2] Documentation/git-clone: describe --mirror more verbose
Date: Mon, 04 Oct 2010 14:52:08 +0200
Message-ID: <4CA9CDF8.6040002@drmicha.warpmail.net>
References: <4CA99E43.1000204@drmicha.warpmail.net> <1286185878-23795-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	Darren 'Some People' Hart <darren@dvhart.com>
To: =?UTF-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
	<u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Mon Oct 04 14:52:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2kWQ-0002ha-Fw
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 14:52:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755798Ab0JDMv5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Oct 2010 08:51:57 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:48309 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755790Ab0JDMv4 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Oct 2010 08:51:56 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 38DC7150;
	Mon,  4 Oct 2010 08:51:56 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute3.internal (MEProxy); Mon, 04 Oct 2010 08:51:56 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=KcABuRcEl7Mem4/Tefur82JHQSk=; b=mBt0N1Qk9pNeMnIVmYMrSAI2OnwKB2Q8kao3PWvkUWrJv1BtmycJtuOVv/rFW1o4QzpRjggII+t/HWWlNWw1eMKyj+bnB5W35c1uwiBqW3r4XEUmo8TgfkI33q1JA0dUmxmAilhs3qnZfR15avflfRs2aMraV1zXfS/fFjLCoEM=
X-Sasl-enc: NQ+TQ8+3q5R7YUCs8AjxXTdcNmshSlq/719q9Jd5qVtQ 1286196716
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 8187B404815;
	Mon,  4 Oct 2010 08:51:55 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.9) Gecko/20100921 Fedora/3.1.4-1.fc13 Lightning/1.0b3pre Thunderbird/3.1.4
In-Reply-To: <1286185878-23795-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158043>

Uwe Kleine-K=C3=B6nig venit, vidit, dixit 04.10.2010 11:51:
> Some people in #linux-rt claimed that you cannot define "--mirror" wi=
th
> "mirror" only.
>=20
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Darren 'Some People' Hart <darren@dvhart.com>
> Cc: Michael J Gruber <git@drmicha.warpmail.net>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  Documentation/git-clone.txt |    7 ++++++-
>  1 files changed, 6 insertions(+), 1 deletions(-)
>=20
> diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.tx=
t
> index dc7d3d1..524a080 100644
> --- a/Documentation/git-clone.txt
> +++ b/Documentation/git-clone.txt
> @@ -128,7 +128,12 @@ objects from the source repository into a pack i=
n the cloned repository.
>  	configuration variables are created.
> =20
>  --mirror::
> -	Set up a mirror of the remote repository.  This implies `--bare`.
> +	Set up a mirror of the source repository.  This implies `--bare`.
> +	Compared to `--bare`, `--mirror` does not only map local branches o=
f
> +	the source to local branches of the target but all refs (including
> +	remote branches, notes etc.) and sets up a refspec configuration su=
ch
> +	that all these refs are overwritten by a `git remote update` in the
> +	target repository.
> =20
>  --origin <name>::
>  -o <name>::

Yep, and thanks for being patient! JC may prefer a grammatically correc=
t
commit subject ("more verbosely") but in any case, thanks for hanging i=
n
there ;)

Michael

Acked-by: sender
