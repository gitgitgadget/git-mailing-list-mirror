From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] git-send-email: Accept -n as a synonym for --dry-run
Date: Thu, 9 Dec 2010 14:35:02 +0100
Message-ID: <201012091435.02669.trast@student.ethz.ch>
References: <1291869878-19645-1-git-send-email-asedeno@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>
To: "Alejandro R. =?iso-8859-1?q?Sede=F1o?=" <asedeno@mit.edu>
X-From: git-owner@vger.kernel.org Thu Dec 09 14:35:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQgeP-0001gL-Hj
	for gcvg-git-2@lo.gmane.org; Thu, 09 Dec 2010 14:35:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752064Ab0LINfH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Dec 2010 08:35:07 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:17219 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751197Ab0LINfF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Dec 2010 08:35:05 -0500
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.218.12; Thu, 9 Dec
 2010 14:34:38 +0100
Received: from pctrast.inf.ethz.ch (129.132.153.233) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.1.218.12; Thu, 9 Dec
 2010 14:35:03 +0100
User-Agent: KMail/1.13.5 (Linux/2.6.37-rc4-13-desktop; KDE/4.5.3; x86_64; ; )
In-Reply-To: <1291869878-19645-1-git-send-email-asedeno@mit.edu>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163281>

Alejandro R. Sede=F1o wrote:
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 76565de..7e3df9a 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -85,7 +85,7 @@ git send-email [options] <file | directory | rev-li=
st options >
>      --confirm               <str>  * Confirm recipients before sendi=
ng;
>                                       auto, cc, compose, always, or n=
ever.
>      --quiet                        * Output one line of info per ema=
il.
> -    --dry-run                      * Don't actually send the emails.
> +    -n, --dry-run                  * Don't actually send the emails.
>      --[no-]validate                * Perform patch sanity checks. De=
fault on.
>      --[no-]format-patch            * understand any non optional arg=
uments as
>                                       `git format-patch` ones.

Good change by itself, but this is the first short option for
git-send-email.  Maybe --force should also get its analogous -f alias?
Any others?

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
