From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [GIT PULL] GPIO bulk changes for kernel v4.6
Date: Fri, 18 Mar 2016 15:32:54 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1603181532040.4690@virtualbox>
References: <CACRpkdbGkfJ9bW1db64msMeQjue+=y+op5EmSx62FWOWDOJwWg@mail.gmail.com> <CA+55aFwV4Cq=4zJc6Fw0yAGrTmci_DFAjJKxkk05pjJJf3iYbA@mail.gmail.com> <56EB9B0C.4050507@nvidia.com> <CA+55aFy=-UAbVo+Xx08tBA7eTPk2B+G3=SbarVxThS57LdakPA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Laxman Dewangan <ldewangan@nvidia.com>,
	Junio C Hamano <gitster@pobox.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Mar 18 15:34:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agvUC-000709-Dw
	for gcvg-git-2@plane.gmane.org; Fri, 18 Mar 2016 15:34:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933389AbcCROeg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2016 10:34:36 -0400
Received: from mout.gmx.net ([212.227.17.20]:50872 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752564AbcCROeY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2016 10:34:24 -0400
Received: from virtualbox ([37.24.143.87]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0LwF9u-1ZjDZG3jl0-0186NL; Fri, 18 Mar 2016 15:32:57
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <CA+55aFy=-UAbVo+Xx08tBA7eTPk2B+G3=SbarVxThS57LdakPA@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:zfPP+bXGBDjq0lfSBgEl5LkcCWeUssCn+BLPmLe+KRUDsHosyTN
 UNIQgJyVf5UcbPNUp8ZPRDcUwfk9FolAevH+T/Sc7tHY5WhzLCwT6d6CgedJi/XkSj6rDbp
 hY3nuIJ+BzaRpKHAm096uLmPq1xaxuO866l3m0P0VwcZdCBwAAFrG/nwOVrnDDP85nmS/4P
 +BWfb6B6NIa4aHM0//mfA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:r2oc4Dchd5E=:+Io6j0+NHPzyt8tgjfsgFG
 bo7ddg8Tcn+swVcwr7B9CwSMjZo8JVHRNXjBBL0dsHYEBkryXentHdWwXonFqEMzjZ8HOPtrf
 HmD+xwYdPdEm0lHs2RF3ZCD9WKg0jZDR3Ru+mKj9jQ3vj/GEcLY+b3pGXlik3aW/qfSCebwjj
 Egg3OsyjWfOjBWCCvxUlTVO/yjKi6otkG4z80WYGDFxE7+EdgvQvVrR70H46MzNpkwglBZUjw
 LYy+ho1QoaCePrIXlyxEJSjv8T/FUYwniArCLPoOyppM/gbBv1az0zBNR/C+ksFxtjuEt+tUw
 VSqviIHZs2vcIEAzE5Sk5rlp6OYcwBH4E75lv+cL6K2S2d7JSxQLeYpWivVsZZlRNnAKxwHoW
 dKHLkalDZ3SaGtfv3WIG99ENR2vXoSSTei6xMhG98Dj69/x/BYo/x4d4878keKjFlDNi79Rtv
 bMmtvg2f5jSehHsfSdDm4mckHNUILIg+olzFXL6Y2wu+4vH24m8kJn9bKhUb+MxZnpnQWGXuv
 uCgJ28Uv/0bmzrl2TfBuJvU/nsVtaEyZ2sAYRPGb4mcFnHFl8vgdBWbWqt/N9J2srFFKrOBxf
 nnB+lC5Z+h0dEZPHghsLapt/s4MFXBVYZho1PlTAUJWQCcc2NHKusAIfOCnvHjOoebD/RcKSg
 v5uJOPeJsoatIBTin9sgZRFnB5FrhSgcC0MJiYCH6CJjKFugD3kwMNQ27bwXohL6t1lxcB4QE
 8a931HfUFRahktJNld3+qXh9HJ0VVMinev+HMR5UU8IliUaf2BlFvjcnZ7W/mQig4kILUbPy 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289219>

Hi Linus,

On Fri, 18 Mar 2016, Linus Torvalds wrote:

> I thought git didn't merge two branches that have no common base by
> default, but it seems it will happily do so.

What happened to "The coolest merge EVER!"?

	http://thread.gmane.org/gmane.comp.version-control.git/5126/

Ciao,
Dscho
