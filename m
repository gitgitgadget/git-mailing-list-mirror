From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 1/5] t/t5800: skip if python version is older than 2.5
Date: Wed, 2 Jun 2010 08:21:00 +0200
Message-ID: <AANLkTinQrdJeTxoZ207kvv5R_3qUj5ocGgAlC22SQyOg@mail.gmail.com>
References: <Wt_M4qptcPdpY0Q3jqUbfIk6yMCN9Ja5RCtRUsADK5OJGrz7R_Cq1oGpeQoN7A9uCvw38jm63Jo@cipher.nrlssc.navy.mil> 
	<Wt_M4qptcPdpY0Q3jqUbfCU_HpY9NEjqs9eujZFD2rsUj5HRo__oQm7EUCxzXu38mC0y-ilUA14@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Wed Jun 02 08:21:27 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJhKQ-0005ms-NV
	for gcvg-git-2@lo.gmane.org; Wed, 02 Jun 2010 08:21:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755428Ab0FBGVW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Jun 2010 02:21:22 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:61605 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752375Ab0FBGVV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Jun 2010 02:21:21 -0400
Received: by gye5 with SMTP id 5so1883686gye.19
        for <git@vger.kernel.org>; Tue, 01 Jun 2010 23:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=SR1RZrIMk1FjZXm6uHiTODxW4kvU3dRisMR+FOcdUpc=;
        b=VRpO6mX/9x+DypuNQBZ5Edjn57p9RfIlFyXhgVyYHLtmg0qTNm9+m9IktDCYNw097h
         llQ/QKtB0cLW+k7Y5rlimSOQ2sRrZGnm9n4tgOonOaovHUNWrhO0VZiRH/hqAFKXch/R
         lUTGxklfTqL5aASA+5hWAS4l06rqexZ5nMC4w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=UA4NVGEboRUZZ6P/N3gwPpD8SDzctbrjE4jAny44vizUtBeZiaoa30xbKDs/LkKkrj
         AEFsX0jRYnyvTQ3ySW2bOa1wUaW9hGfCaAQVlP+sOtY+6kgCev3RseUn9o884VVPzusO
         9PSL1WRgpFdLEmLB8XTHEu/qsN0E091NtCKyo=
Received: by 10.151.61.20 with SMTP id o20mr7636253ybk.436.1275459680234; Tue, 
	01 Jun 2010 23:21:20 -0700 (PDT)
Received: by 10.151.61.12 with HTTP; Tue, 1 Jun 2010 23:21:00 -0700 (PDT)
In-Reply-To: <Wt_M4qptcPdpY0Q3jqUbfCU_HpY9NEjqs9eujZFD2rsUj5HRo__oQm7EUCxzXu38mC0y-ilUA14@cipher.nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148218>

Heya,

On Wed, Jun 2, 2010 at 02:13, Brandon Casey <casey@nrlssc.navy.mil> wro=
te:
> This test script depends on the git-remote-testgit python script. =C2=
=A0This
> python script makes use of the hashlib module which was released in p=
ython
> version 2.5. =C2=A0So, add a new pre-requisite named PYTHON_2_5_OR_NE=
WER to
> test-lib.sh and check for it in t5800.

Perhaps instead we can change git-remote-testgit to do:

"try:
import hashlib
except ImportError:
import ?? as hashlib
"

Otoh, python 2.5 has been out for a while (and is in fact only
downloadable as a source-only release these days). To be exact, it was
released on September 19, 2006.


--=20
Cheers,

Sverre Rabbelier
