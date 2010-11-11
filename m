From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH 1/2] [RFC] Use --find- instead of --detect- as prefix for long forms of -M and -C.
Date: Thu, 11 Nov 2010 11:47:04 +0100
Message-ID: <201011111147.04365.trast@student.ethz.ch>
References: <1289420833-20602-1-git-send-email-ydirson@altern.org> <1289420833-20602-2-git-send-email-ydirson@altern.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Yann Dirson <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Thu Nov 11 11:47:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGUgT-0004fF-7b
	for gcvg-git-2@lo.gmane.org; Thu, 11 Nov 2010 11:47:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755250Ab0KKKrK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Nov 2010 05:47:10 -0500
Received: from gwse.ethz.ch ([129.132.178.237]:32445 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753788Ab0KKKrJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Nov 2010 05:47:09 -0500
Received: from CAS21.d.ethz.ch (172.31.51.111) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.254.0; Thu, 11 Nov
 2010 11:47:08 +0100
Received: from pctrast.inf.ethz.ch (129.132.208.172) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.1.218.12; Thu, 11 Nov
 2010 11:47:07 +0100
User-Agent: KMail/1.13.5 (Linux/2.6.36-90-desktop; KDE/4.5.3; x86_64; ; )
In-Reply-To: <1289420833-20602-2-git-send-email-ydirson@altern.org>
X-Originating-IP: [129.132.208.172]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161224>

Yann Dirson wrote:
> Rationale: this is both shorter to spell and consistent with
> --find-copies-harder.
[...]
>  -M[<n>]::
> ---detect-renames[=<n>]::
> +--find-renames[=<n>]::

Umm.  The reasoning seems ok for me, but the farthest you can go is
deprecating the options.  Removing them as in

> -	else if (!prefixcmp(arg, "-M") || !prefixcmp(arg, "--detect-renames=") ||
> -		 !strcmp(arg, "--detect-renames")) {
> +	else if (!prefixcmp(arg, "-M") || !prefixcmp(arg, "--find-renames=") ||
> +		 !strcmp(arg, "--find-renames")) {

would break backwards compatibility.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
