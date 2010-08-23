From: "Nathan W. Panike" <nathan.panike@gmail.com>
Subject: Re: HTML help files are broken
Date: Mon, 23 Aug 2010 11:17:33 -0500
Message-ID: <AANLkTi=QVoBkCLPwiqJUuoVQgVPfierr9xQU3F=qyO=A@mail.gmail.com>
References: <AANLkTimMZGswhWXyDMaFa9N1ipzoBXT7RptHMq2TYhmv@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 23 18:17:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OnZiP-0002ql-Uv
	for gcvg-git-2@lo.gmane.org; Mon, 23 Aug 2010 18:17:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754324Ab0HWQRg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Aug 2010 12:17:36 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:56106 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753022Ab0HWQRf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Aug 2010 12:17:35 -0400
Received: by wwe15 with SMTP id 15so308505wwe.1
        for <git@vger.kernel.org>; Mon, 23 Aug 2010 09:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=JaFEktYlStuoORQdfZrvycXtQvK4CaotYzzXyEiOEik=;
        b=Q3NNmXHjb9YTCCuj30ZfgXCG+gK68hfiryrulCFCcpFb15PuRdow2uKk8V99ADJOfj
         r/HfouGqGHZEEhpYmMW5cnlzjQh5uZi4B160zEXvBt3Y3+zJC1q/UTcJ7ZS1Lhbr7jFw
         k+AMP0wLqBq797LcnBbek9g+40Tmidlqrkbjs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=F+Ua+PuUwWpMeQ016RYcmH07Ur02b4S4N5dZzzLx4Q1XxVWNe7DBGRFkANN/um9yc3
         lE481M34bsRrBGaaPZ5M2U2ECfuNGebdqRb5T5HhCewj6InJnwAjBENvV3ckSMUaA/dK
         +QcrvWg+km9RGfbgaNXOReKeCGpD/M0nZiRpY=
Received: by 10.227.130.31 with SMTP id q31mr4556902wbs.179.1282580253553;
 Mon, 23 Aug 2010 09:17:33 -0700 (PDT)
Received: by 10.216.68.16 with HTTP; Mon, 23 Aug 2010 09:17:33 -0700 (PDT)
In-Reply-To: <AANLkTimMZGswhWXyDMaFa9N1ipzoBXT7RptHMq2TYhmv@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154232>

On Mon, Aug 23, 2010 at 10:59 AM, Nathan W. Panike
<nathan.panike@gmail.com> wrote:
> Some of the HTML manual files produced on my machine (Ubuntu 10.04)
> from the git source are broken: in git-help.html, I get the following
> for the link to the git-web--browse manual page:
>
> <a href=3D"git-web&#8212;browse.html">git-web&#8212;browse(1)</a>
>
> where the &#8212; (en-dash) replaces the "--" (dash-dash) that is on
> the filesystem. =A0How does one fix it, so that the line above would =
be
>
> <a href=3D"git-web--browse.html">git-web--browse(1)</a>?
>
> The command line I am using is a simple
>
> make doc.

I neglected to mention here that the perl version is 5.10.1 and
asciidoc version is 8.5.2

>
> I checked the git repository origin/html, and the correct link is
> produced there, so something in my configuration is messed up.
>
> Nathan Panike
>
