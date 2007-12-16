From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: Windows binaries for qgit 2.0
Date: Sun, 16 Dec 2007 08:55:37 +0100
Message-ID: <e5bfff550712152355o7c8ef2f3j95f239697f77ccef@mail.gmail.com>
References: <e5bfff550712150702p2675da8axed1f3db6273f619@mail.gmail.com>
	 <fk2juf$t25$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Abdelrazak Younes" <younes.a@free.fr>
X-From: git-owner@vger.kernel.org Sun Dec 16 08:56:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3oM3-0002iK-7F
	for gcvg-git-2@gmane.org; Sun, 16 Dec 2007 08:56:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754665AbXLPHzk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Dec 2007 02:55:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754164AbXLPHzk
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Dec 2007 02:55:40 -0500
Received: from rv-out-0910.google.com ([209.85.198.191]:39072 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754143AbXLPHzj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Dec 2007 02:55:39 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1469999rvb.1
        for <git@vger.kernel.org>; Sat, 15 Dec 2007 23:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=raImL61H/WbqWZH1zqxnhIesLUB1MC9vgz5vstbRqC4=;
        b=SutPlkaoMU3qD7mKTUVTTX96/3K4K7/rjU7LjdPt3mQerU6eFCvSruZHnO0/4xfUqVnx936c3w7BjGz+luzWQ+DwOxXu2jFOxxxufQ2PHt4b0Rjh6aTdDuPM1Cn7EB+33ZxYL7k7leXbybtFcPFv4AUX12njHdf3xICNes6rkvI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rsuGdp4wxuEOB1cCl8TmUS2F74tn7xdqqZbFvz8zL0sPIT1QbuWt154DvCFA+D1S2VBVETnXwf8/laDN3Tadtik1gUXIVjA4X7sl3s1e4Vt/E07zIScA/yyIRNrrRLXyQM52eFdjKG5xru6fNlJ3iH1O8uWfBZXjRz6/BGnRp5o=
Received: by 10.140.164.1 with SMTP id m1mr3097460rve.69.1197791737616;
        Sat, 15 Dec 2007 23:55:37 -0800 (PST)
Received: by 10.141.76.1 with HTTP; Sat, 15 Dec 2007 23:55:37 -0800 (PST)
In-Reply-To: <fk2juf$t25$1@ger.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68445>

On Dec 16, 2007 8:26 AM, Abdelrazak Younes <younes.a@free.fr> wrote:
>
> Sorry for the intrusion in this list but you don't need to compile Qt
> statically IMO. Just bundle the Qt dlls that you needs (most probably
> QtCore and QtGui) with you executable and be done with it.
>

Yes. That's another option, I will try that to see if things get better.

>
> If you are using debug dlls, those are known to be slower  because of

Actually I use debug dll for normal development and never experienced slowness.
I switched to "release" library to create the qgit package and _now_ I
have the thing much slower and also misbehaving. So for me are the
release library that have problems, not the debug ones.

> In any case, if you want to gain
> speed, you should compile with MSVC (MSVC2005Express is free as in beer).
>

Yes, I was thinking about this, but Qt don't officially supports MSVC
for the Qt4 GPL libraries, so that's the reason I was stick to mingw
(although now it comes more and more clear to me that the shipped
version has problems with release compiled libraries)

> Hope this helps,
> Abdel.
>

Yes, thanks a lot.
Marco
