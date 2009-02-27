From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: Building 1.6.2-rc2 in Cygwin
Date: Fri, 27 Feb 2009 20:37:53 +0800
Message-ID: <be6fef0d0902270437y14b3eb6kdf061109df19a77e@mail.gmail.com>
References: <c115fd3c0902260723o4d475df5yecc9ff23c55c7af4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Tim Visher <tim.visher@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 27 13:39:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ld200-0002RH-KI
	for gcvg-git-2@gmane.org; Fri, 27 Feb 2009 13:39:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754909AbZB0Mh5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Feb 2009 07:37:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754790AbZB0Mh4
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Feb 2009 07:37:56 -0500
Received: from rv-out-0506.google.com ([209.85.198.233]:4420 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751626AbZB0Mh4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Feb 2009 07:37:56 -0500
Received: by rv-out-0506.google.com with SMTP id g37so1076990rvb.1
        for <git@vger.kernel.org>; Fri, 27 Feb 2009 04:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=yIdS8trFaTjQY0tXlWcYNOfi1LQ4sG1blnAepTt7W/Y=;
        b=NBSn2Mup0YQurO/qle+gVkYB8FEd1dFdcjCWf4RJrackMSDkK2lEv+KDxadK1xaygG
         YMkAYdAiVvEXsw7A0+7pTjeitmUiV97CdaFeW2WtrvYQA+OxVj6gjPmNya339B+/CguC
         qLaCs7MOePjtM1TFr2Zd7IXCpXevC7HNeh0g4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=lnxIJyS5G2IrFJ4zGM4tR5fulzQoq+8V11j2Kd9EgX92nozwcVGBjl3dWKZF/GFH2Y
         SDpX9pg0QgnGgfWe18oF8hdP9rZy0+KYa2S2Unvt03NxRJHEEMbGmUwkukj3F3rNj8zE
         GWPtErS0kovHoF8fS7fNVit85PtKFx9Mjgci8=
Received: by 10.114.137.2 with SMTP id k2mr1147957wad.146.1235738274038; Fri, 
	27 Feb 2009 04:37:54 -0800 (PST)
In-Reply-To: <c115fd3c0902260723o4d475df5yecc9ff23c55c7af4@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111667>

Hi,

On Thu, Feb 26, 2009 at 11:23 PM, Tim Visher <tim.visher@gmail.com> wro=
te:
> =A0 =A0$ make
> =A0 =A0 =A0 =A0CC fast-import.o
> =A0 =A0In file included from builtin.h:4,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 from fast-import.c:142:
> =A0 =A0git-compat-util.h:100:19: iconv.h: No such file or directory
> =A0 =A0make: *** [fast-import.o] Error 1

Did you try installing libiconv library? It contains that particular
header file.

Whenever I make on cygwin and it chokes, I try searching cygwin's
package contents:

http://cygwin.com/cgi-bin2/package-grep.cgi?grep=3Dfile.h

You might find this handy too.

> Second, I built and installed 1.6.2-rc2 and it still is claiming a
> --version rc1. =A0I'm not sure if this is systemic or not, and obviou=
sly
> it would be bad if it was just me as it means I'm doing something
> wrong.

Hmm, you could try

$ make install prefix=3D/usr

By default, git installs into your home directory.

--=20
Cheers,
Ray Chuan
