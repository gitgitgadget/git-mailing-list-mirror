From: Ludvig Strigeus <strigeus@gmail.com>
Subject: Re: Git for Windows 1.6.2.1-preview20090322
Date: Mon, 23 Mar 2009 23:03:33 +0100
Message-ID: <4285cd450903231503x5d332bfft17b01e598d11bc09@mail.gmail.com>
References: <alpine.DEB.1.00.0903080132470.10279@pacific.mpi-cbg.de>
	 <alpine.DEB.1.00.0903222149330.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 23 23:06:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlsGY-0001QG-ER
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 23:05:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754173AbZCWWDh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Mar 2009 18:03:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752853AbZCWWDg
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 18:03:36 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:60509 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752691AbZCWWDg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Mar 2009 18:03:36 -0400
Received: by fxm2 with SMTP id 2so2013942fxm.37
        for <git@vger.kernel.org>; Mon, 23 Mar 2009 15:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=xB1twYyv/0d9/+4UpbWwJgZnYvViTPxXtMWXRmR65Uw=;
        b=F1QKQstyAucj7YcNiwAiXTXVgf+/SSUAps1iNxI0dPKkl59KrKZjOJs5IsUjiGuwlD
         YRdSwKAlTgw0/rTT0wsj1Xb2F3Zscafx5ataR3i1dHlDV4pFBiDQAWHB0b/f5C1OKStN
         HivmW8cdquPJ7zvtv97tLAdNkuQXd2rVG2AFY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ZeBHntLqaPSS0hPXKgW3+PPsl+FYYmM3mF1vLHqiAq0+isdvmNctgX4jAkV9+omuXk
         WwUSUsaN0/qPD7DjIak9Q90V1y/l7dg6uVg5XDwFzgxA6zjFKK9pXDJIzZBEwX/M5/qE
         lzDHJyMLSls7CucZ0Lc6cB/xs7LOYxxEfV3b0=
Received: by 10.103.117.8 with SMTP id u8mr3289841mum.123.1237845813224; Mon, 
	23 Mar 2009 15:03:33 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0903222149330.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114355>

On Sun, Mar 22, 2009 at 10:17 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> - There are a few issues with ssh hanging (Issue 197), permission den=
ied
> =A0on renaming pack files (mentioned in Issue 194), and spurious writ=
e
> =A0errors during rebase (Issue 200) that seem not to be reproducible =
on
> =A0most computers.

I had this problem with write errors during rebase. I tracked it down
to having the files open in Visual Studio while doing the rebase. As
soon as a file is changed, Visual Studio seems to open the file (as
part of its feature to detect if files changed on disk), which
confliced with git for some reason. As soon as I closed MSVS, rebase
worked well.

/Ludde
