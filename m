From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Small rerere in rebase regression
Date: Wed, 25 May 2016 07:47:54 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1605250747040.4449@virtualbox>
References: <57434572.6030306@kdbg.org> <xmqqy4708ss0.fsf@gitster.mtv.corp.google.com> <57437693.3030106@kdbg.org> <xmqqk2ik77cr.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1605241510370.4449@virtualbox> <5744B00D.4020006@kdbg.org>
 <alpine.DEB.2.20.1605250710340.4449@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed May 25 07:48:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5Rfv-0005uu-0A
	for gcvg-git-2@plane.gmane.org; Wed, 25 May 2016 07:48:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755241AbcEYFsG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2016 01:48:06 -0400
Received: from mout.gmx.net ([212.227.17.20]:61741 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750765AbcEYFsF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2016 01:48:05 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0Li1hG-1bsTob2zeU-00n5yy; Wed, 25 May 2016 07:47:51
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <alpine.DEB.2.20.1605250710340.4449@virtualbox>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:HM1mqpxcyxBwvDs1yTG3xss+OtLg03z/XJTxmsdmAr85K7ECMTC
 PZzfI0qPeoblWqsqu+C07QoclumIQjU0EAu3e03v+Jfi82B6E+5DUK8fdlWUZmjTady0uC0
 t8qW8iw2gzHwQF5eXjKM4AgkCNVuBwTDJkE1d27ZBuG7I76XMQF/mN1ARvgbdZcMNijAH8d
 QbG+VVQUXCMU3mnlm1kYA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:fcdcsfltKr4=:fbpKk/fRDK9Y4s6Jp8McSQ
 FPfRgA3+XKWC4KWb4w01G4HaNZvuUqZlvdQl9gozmIv6tE3asd2CKMuz21NnpmdC6zKmo8WRj
 QVDCy6MFOBc01wXFMVse02DWug/a7NtM0ajRFmqQ86g2FnHrpiO7udr27Qfk2m7zYVMNKuuSI
 UDW++mdjEtHJlTIzI2SLpo0A0ImHF7LwRurgnVczKibNLraqbQ7Q8mFStfyD/ERPi3q7UsNJP
 yKrJTptD6CCQ/gdnmpBFiItENckZJ5xiQ1wrh+hleeN8YWMsz5TZdwbHTqrAlk12tDKHaXxVt
 jjy+5nrB1pCkifDL/PhYZrkb+5U4+Eq2zCIi4hgWtkgDq+uV9mgaIhlUCOxuIeSKpXXO0wQpc
 1wFMaz+pJX6TYL+dHB7Xfj6q4O4QrD74ilCPWs7bjXx7QAFS7NMSPn2FTUleQV9LfVZk+MjNC
 kzBS5Wpa+QsGwKkPD0ITNjRPlpCGK536WNIlkmDPsoxmcMGyAZIt2bQaSp/5HNX89J165j6Br
 hHwYQwxtZ4DPW0bJr3qPQLN8Dg+IrgA3zikWQqwZpTDEP801seE2ic4vogqTKw89hlvTNV3Fz
 9J5I10v3LIcO5ZPmwG0I6klrs4bmM/OsTbc7/+aQWs/9KDpGdOsLdM6eNHhgqr8XWQ2p3J+2n
 aylTDe6CSiu6x88H2bSO4NADcildcjR0QodzmBYWI7O3FBMEBj8Dxw5yXYfzsPSObhLmqJD02
 /zt8FwgvstsJoO5C5cdHKEzpsV0cS1VrCl/6eULFgogLXFX0CwBGrlkoXNxAjKZGrOX/4uEP 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295561>

Hi Hannes,

On Wed, 25 May 2016, Johannes Schindelin wrote:

> On Tue, 24 May 2016, Johannes Sixt wrote:
> 
> > Could not apply fa62fea... mastergittest@master|REBASE-i 1/1:1008> 5~
> > 
> > (Take note of the missing LF at the end of the message.)
> 
> Oops. Good catch, thank you! I just fixed this:
> 
> 	https://github.com/dscho/git/commit/0393d7bb2d

Argh. I fixed it in https://github.com/dscho/git/commit/0704d6f425 of
course.

Ciao,
Dscho
