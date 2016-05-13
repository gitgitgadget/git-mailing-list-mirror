From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (May 2016, #02; Fri, 6)
Date: Fri, 13 May 2016 13:52:11 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1605131349020.4092@virtualbox>
References: <xmqqeg9e24ay.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1605100757410.4092@virtualbox> <xmqqy47iqszk.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 13 13:52:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1Bdi-0007Hl-N2
	for gcvg-git-2@plane.gmane.org; Fri, 13 May 2016 13:52:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752102AbcEMLwP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2016 07:52:15 -0400
Received: from mout.gmx.net ([212.227.17.22]:56544 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751139AbcEMLwO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2016 07:52:14 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0Mhdex-1bEi1D3jyl-00MpZ1; Fri, 13 May 2016 13:52:08
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <xmqqy47iqszk.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:SexFC5iKWVyKslYCaoazUN8e61GsMiL0DfOQl4cYNhn+DfjnH8U
 ADKsO2v7B5uCQIl66pKY0xYHsiC44TtpwnSPjvKJH5bVbhRcVzsN8G2Qp9seJWuRBDCZzfp
 qq/oepFKcqpAyXnK6e5fxaxZpk2g7YJ0xdRjy0WiAP9naogZbNDVkY7lBM0YmOtlySVvFAM
 Cowfc9QpnEoxGDplb/Ebg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:CDhqUvPiLYc=:UyATSLWh/vViOpXMR+beYi
 tbfWevdMyH/N+vdzhru8Gytuf2aHjTEZVwcY77ByhXMlcfod3MoDcSGgfQuS3y1fNrNhHojtG
 nZ+7gEvpXbJ9C9ulJNpE6E/BLxR7nsW/ahgxOKQfe4p8GEC4YetpnNTvZia61OyeaQ3zK3UWO
 sykGh7Rlq4lYQWrz/cYLLNbcEeK1IOIUC7L5IItUgXeRMkT5ydd8dcNnFMCRCGDfS0RH0DtWW
 B9nlQAKc+E85m9Xy0OA3gBdJgUt90UA3EFuICa8B76w1jbib9X7MoyPd9TW9s5lte/7WIAoM1
 kcr9QGjju9gHdtDqdkgDQ6lBhbHkomgH2+L2yIf37o3mx8S/zQDDvEWc9FIi/S+JjcGtAeZll
 XxpIW+LGrALjsqxZbvkwC9qc3BcDGWMb6mPjLLChD6D2Y6gcnP6JKoHSY6YiI1VLk7Q6dXj6b
 IHnxs4HEW6bUBVF/K4gkCXh060HaaGM+aDGLanqNH1L6mWNqX0gLF5rY4SXCkXC3E4bfz1QUh
 VojGQe/I9XheR05FNJb0RxyneO3UQV2MPKjMFDEbAkZEHldN46X254mC0DSYAn3Tj2FRinugi
 dqCv2oZPdWwyDTCiboajSlc8odOeTII9WxP9XgAfalDA9AOfP+0ZWWEBV1Y51AYJrLo7sUq3o
 S8SHc9Nx3yQR7umniqoAIS88jW4xXfBSPUEqO+HB/KkbP+dK77y8Qzw0YLZd8ppQE4PsyboSq
 8qjk+NzVddov/mJDzH3XKWQzFwIenhxZM+CDnvb8hjPBfsF/8UKV5Mj3uwjk3hXvewzOiwqr 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294525>

Hi Junio,

On Tue, 10 May 2016, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Fri, 6 May 2016, Junio C Hamano wrote:
> >
> > 2) I was under the impression that we preferred test_i18ngrep over grep...
> 
> Only when the strings we are expecting are subject to i18n.  I
> somehow did not think your report() codepath has any i18n/l10n?

I finally remembered why I thought that test_i18ngrep was to be preferred
over grep. For years, Git for Windows carried a patch that introduced a
special `cmp` for use with text files, so that differences in the
end-of-line markers could be ignored. IIRC we abandoned this when
test_i18ncmp learned to perform this trick. Only that it really is
test_cmp that learned this trick... so I was wrong.

So please forget what I said about this part of the patch.

Ciao,
Dscho
